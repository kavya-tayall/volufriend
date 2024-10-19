import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';
import 'package:volufriend/auth/bloc/org_event_bloc.dart';
import 'package:volufriend/core/utils/size_utils.dart';
import 'package:volufriend/crud_repository/volufriend_crud_repo.dart';
import 'package:volufriend/widgets/custom_elevated_button.dart';
import 'bloc/vf_userattendancereportpage_bloc.dart';
import 'models/vf_userattendancereportpage_model.dart';
import '../../auth/bloc/login_user_bloc.dart';

class VfUserAttendanceReportPageScreen extends StatelessWidget {
  const VfUserAttendanceReportPageScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            context.read<orgVoluEventBloc>().add(resetEvent());

            final userBloc = BlocProvider.of<UserBloc>(context);
            final userState = userBloc.state;

            final vfUserAttendanceReportBloc = VfUserattendancereportpageBloc(
              vfCrudService: context.read<VolufriendCrudService>(),
              initialState: VfUserattendancereportpageState(
                vfUserattendancereportpageModelObj:
                    VfUserattendancereportpageModel(),
              ),
            );

            // Add the event to load attendance based on user state
            if (userState is LoginUserWithHomeOrg) {
              final userId = userState.userId!;
              final username = userState.user.username ?? '';
              vfUserAttendanceReportBloc.add(
                LoadAttendanceEvent(
                  userId: userId,
                  username: username,
                  attendanceDateRange: DateTimeRange(
                    start: DateTime.now().subtract(const Duration(days: 30)),
                    end: DateTime.now(),
                  ),
                ),
              );
            }

            return vfUserAttendanceReportBloc;
          },
        ),
      ],
      child: const VfUserAttendanceReportPageScreenContent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const VfUserAttendanceReportPageScreenContent();
  }
}

class VfUserAttendanceReportPageScreenContent extends StatelessWidget {
  const VfUserAttendanceReportPageScreenContent({Key? key}) : super(key: key);

  Widget _buildDateRangePicker(BuildContext context) {
    // Watch for changes in the selected date range from the Bloc's state
    final selectedRange = context
        .watch<VfUserattendancereportpageBloc>()
        .state
        .attendanceDateRange;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Date Range:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey[800],
          ),
        ),
        const SizedBox(height: 8),
        CustomElevatedButton(
          onPressed: () async {
            // Show the date range picker with the current selected range as initial value
            final DateTimeRange? picked = await showDateRangePicker(
              context: context,
              firstDate: DateTime(2024),
              lastDate: DateTime.now(),
              initialDateRange: selectedRange,
            );

            // Only dispatch the event if a valid range is picked
            if (picked != null) {
              print('Picked Date Range: $picked');
              context
                  .read<VfUserattendancereportpageBloc>()
                  .add(UpdateDateRangeEvent(picked));

              // Dispatch the UpdateAttendanceEvent after updating the date range
              context.read<VfUserattendancereportpageBloc>().add(
                    UpdateAttendanceEvent(
                      attendanceDateRange: picked,
                      userId: context.read<UserBloc>().state.userId!,
                      username: context
                              .read<VfUserattendancereportpageBloc>()
                              .state
                              .userName ??
                          '',
                    ),
                  );
            }
          },
          text: selectedRange == null
              ? 'Select Date Range' // If no range is selected, show prompt
              : '${DateFormat('MM/dd/yyyy').format(selectedRange.start)} - ${DateFormat('MM/dd/yyyy').format(selectedRange.end)}',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final attendances = context
        .watch<VfUserattendancereportpageBloc>()
        .state
        .vfUserattendancereportpageModelObj
        ?.userAttendance;

    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context, attendances ?? []),
        body: Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(top: 14.h),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24.h),
                BlocBuilder<VfUserattendancereportpageBloc,
                    VfUserattendancereportpageState>(
                  builder: (context, state) {
                    if (!state.isLoading) {
                      final userName = state.userName ?? '';
                      return Text(
                        'Volunteering Hours Report for $userName',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey[800],
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                SizedBox(height: 16.h),
                // Use BlocBuilder to manage the date range picker button state
                _buildDateRangePicker(context),
                SizedBox(height: 16.h),
                BlocListener<VfUserattendancereportpageBloc,
                    VfUserattendancereportpageState>(
                  listener: (context, state) {
                    // Listen for changes in loading state or error messages
                    if (state.isLoading) {
                      // You can show a loading indicator here if needed
                    } else if (state.errorMessage.isNotEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errorMessage)),
                      );
                    }
                  },
                  child: BlocBuilder<VfUserattendancereportpageBloc,
                      VfUserattendancereportpageState>(
                    builder: (context, state) {
                      if (state.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state.vfUserattendancereportpageModelObj
                              ?.userAttendance?.isNotEmpty ==
                          true) {
                        final attendances = state
                            .vfUserattendancereportpageModelObj!
                            .userAttendance!;
                        return AttendanceTable(attendances: attendances);
                      } else {
                        return Center(
                          child: Text(
                            'No data available',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w600),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(
      BuildContext context, List<Attendance> attendances) {
    return AppBar(
      title: const Text('User Attendance Report'),
      actions: [
        IconButton(
          icon: const Icon(Icons.picture_as_pdf),
          onPressed: () {
            _generatePdf(
              attendances,
              context.read<VfUserattendancereportpageBloc>().state.userName ??
                  '',
              context
                  .read<VfUserattendancereportpageBloc>()
                  .state
                  .attendanceDateRange
                  .start,
              context
                  .read<VfUserattendancereportpageBloc>()
                  .state
                  .attendanceDateRange
                  .end,
            );
          },
        ),
      ],
    );
  }

  Future<void> _generatePdf(List<Attendance> attendances, String userName,
      DateTime startDate, DateTime endDate) async {
    final pdf = pw.Document();
    final currentDateTime = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final formattedUserName = userName.isNotEmpty ? userName : "Unknown User";

    // Format the date range
    final dateRange =
        '${DateFormat('MM/dd/yyyy').format(startDate)} - ${DateFormat('MM/dd/yyyy').format(endDate)}';

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Attendance Report for $formattedUserName',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Text(
                'Date Range: $dateRange',
                style: pw.TextStyle(
                  fontSize: 16,
                ),
              ),
              pw.Text(
                'Generated on: $currentDateTime',
                style: pw.TextStyle(
                  fontSize: 14,
                ),
              ),
              pw.SizedBox(height: 16),
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                          'Organization Name',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                          'Event Date',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                          'Event Name',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                          'Shift Activity',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                          'Coordinator Name',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                          'Email',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                          'Phone',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ...attendances.map((attendance) {
                    return pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(attendance.organizationName),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(DateFormat('EEEE, d MMMM, y')
                              .format(DateTime.parse(attendance.eventDate))),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(attendance.eventName),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(attendance.shiftName),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(attendance.coordinatorName ?? ''),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(attendance.coordinatorEmail ?? ''),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(attendance.coordinatorName ?? ''),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ],
          );
        },
      ),
    );

    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'Attendance_Report_$formattedUserName$currentDateTime.pdf',
    );
  }
}

class AttendanceTable extends StatelessWidget {
  final List<Attendance> attendances;

  const AttendanceTable({required this.attendances, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final horizontalScrollController = ScrollController();
    final verticalScrollController = ScrollController();

    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: horizontalScrollController,
        child: Scrollbar(
          thumbVisibility: true,
          controller: horizontalScrollController,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            controller: verticalScrollController,
            child: Scrollbar(
              thumbVisibility: true,
              controller: verticalScrollController,
              child: DataTable(
                headingRowColor: WidgetStateProperty.all(Colors.blue),
                dataRowColor:
                    WidgetStateProperty.resolveWith((row) => Colors.white),
                columns: [
                  DataColumn(label: _buildHeaderCell('Organization Name')),
                  DataColumn(label: _buildHeaderCell('Event Date')),
                  DataColumn(label: _buildHeaderCell('Event Name')),
                  DataColumn(label: _buildHeaderCell('Shift Activity')),
                  DataColumn(label: _buildHeaderCell('Coordinator Name')),
                  DataColumn(label: _buildHeaderCell('Email')),
                  DataColumn(label: _buildHeaderCell('Hours Attended')),
                ],
                rows: attendances.map((attendance) {
                  return DataRow(cells: [
                    DataCell(Text(attendance.organizationName)),
                    DataCell(Text(DateFormat('EEEE, d MMMM, y')
                        .format(DateTime.parse(attendance.eventDate)))),
                    DataCell(Text(attendance.eventName)),
                    DataCell(Text(attendance.shiftName)),
                    DataCell(Text(attendance.coordinatorName)),
                    DataCell(Text(attendance.coordinatorEmail)),
                    DataCell(Text(attendance.hoursAttended.toString())),
                  ]);
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget _buildHeaderCell(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Text(
        label,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}

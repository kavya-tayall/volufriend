import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';
import 'package:volufriend/auth/bloc/org_event_bloc.dart';
import 'package:volufriend/core/utils/size_utils.dart';
import 'package:volufriend/crud_repository/volufriend_crud_repo.dart';
import 'package:volufriend/widgets/vf_app_bar_with_title_back_button.dart';
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
            final userBloc = BlocProvider.of<UserBloc>(context);
            final userState = userBloc.state;

            final vfUserAttendanceReportBloc = VfUserattendancereportpageBloc(
              vfCrudService: context.read<VolufriendCrudService>(),
              initialState: VfUserattendancereportpageState(
                vfUserattendancereportpageModelObj:
                    VfUserattendancereportpageModel(),
              ),
            );

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

  @override
  Widget build(BuildContext context) {
    final attendances = context
        .watch<VfUserattendancereportpageBloc>()
        .state
        .vfUserattendancereportpageModelObj
        ?.userAttendance;

    return Scaffold(
      appBar: const VfAppBarWithTitleBackButton(
        title: 'Volunteering Hours Report',
        showSearchIcon: false,
        showFilterIcon: false,
      ),
      body: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: 14.h),
        padding: EdgeInsets.symmetric(horizontal: 24.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              BlocBuilder<VfUserattendancereportpageBloc,
                  VfUserattendancereportpageState>(
                builder: (context, state) {
                  final userName = state.userName ?? '';
                  return Text(
                    'Volunteering Hours Report for $userName',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0070BB),
                    ),
                  );
                },
              ),
              SizedBox(height: 16.h),
              BlocBuilder<VfUserattendancereportpageBloc,
                  VfUserattendancereportpageState>(
                builder: (context, state) {
                  return _buildDateRangePicker(
                      context, state.attendanceDateRange);
                },
              ),
              SizedBox(height: 24.h),
              BlocBuilder<VfUserattendancereportpageBloc,
                  VfUserattendancereportpageState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.vfUserattendancereportpageModelObj
                          ?.userAttendance?.isNotEmpty ==
                      true) {
                    return AttendanceList(
                        attendances: state.vfUserattendancereportpageModelObj!
                            .userAttendance!);
                  } else {
                    return Center(
                      child: Text(
                        'No data available',
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w600),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _generatePdf(
          attendances ?? [],
          context.read<VfUserattendancereportpageBloc>().state.userName ?? '',
          context
                  .read<VfUserattendancereportpageBloc>()
                  .state
                  .attendanceDateRange
                  ?.start ??
              DateTime.now(),
          context
                  .read<VfUserattendancereportpageBloc>()
                  .state
                  .attendanceDateRange
                  ?.end ??
              DateTime.now(),
        ),
        backgroundColor: Color(0xFF0070BB),
        label: Row(
          children: const [
            Icon(Icons.picture_as_pdf, color: Colors.white),
            SizedBox(width: 8),
            Text('Print Report', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _buildDateRangePicker(
      BuildContext context, DateTimeRange? selectedDateRange) {
    return GestureDetector(
      onTap: () async {
        final picked = await showDateRangePicker(
          context: context,
          firstDate: DateTime(2020),
          lastDate: DateTime.now(),
          initialDateRange: selectedDateRange ??
              DateTimeRange(
                start: DateTime.now().subtract(const Duration(days: 30)),
                end: DateTime.now(),
              ),
        );
        if (picked != null) {
          context
              .read<VfUserattendancereportpageBloc>()
              .add(UpdateDateRangeEvent(picked));

          context.read<VfUserattendancereportpageBloc>().add(
                UpdateAttendanceEvent(
                  userId: context
                      .read<VfUserattendancereportpageBloc>()
                      .state
                      .userId,
                  username: context
                      .read<VfUserattendancereportpageBloc>()
                      .state
                      .userName,
                  attendanceDateRange: picked,
                ),
              );
        }
      },
      child: BlocBuilder<VfUserattendancereportpageBloc,
          VfUserattendancereportpageState>(
        builder: (context, state) {
          final displayDateRange = state.attendanceDateRange;
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Color(0xFF0070BB)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  displayDateRange != null
                      ? '${DateFormat('MM/dd/yyyy').format(displayDateRange.start)} - ${DateFormat('MM/dd/yyyy').format(displayDateRange.end)}'
                      : 'Select Date Range',
                  style: const TextStyle(
                    color: Color(0xFF0070BB),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Icon(Icons.calendar_today, color: Color(0xFF0070BB)),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _generatePdf(List<Attendance> attendances, String userName,
      DateTime startDate, DateTime endDate) async {
    final pdf = pw.Document();
    final currentDateTime = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final formattedUserName = userName.isNotEmpty ? userName : "Unknown User";
    final dateRange =
        '${DateFormat('MM/dd/yyyy').format(startDate)} - ${DateFormat('MM/dd/yyyy').format(endDate)}';

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                padding: const pw.EdgeInsets.all(12),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.blue, width: 1.5),
                  borderRadius: pw.BorderRadius.circular(8),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Attendance Report for $formattedUserName',
                      style: pw.TextStyle(
                        fontSize: 20,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.blueGrey800,
                      ),
                    ),
                    pw.SizedBox(height: 4),
                    pw.Text(
                      'Date Range: $dateRange',
                      style:
                          pw.TextStyle(fontSize: 12, color: PdfColors.grey700),
                    ),
                    pw.Text(
                      'Generated on: $currentDateTime',
                      style:
                          pw.TextStyle(fontSize: 12, color: PdfColors.grey700),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 16),
              pw.Table(
                border: pw.TableBorder.all(
                    color: PdfColors.blueGrey300, width: 0.5),
                children: [
                  pw.TableRow(
                    decoration: pw.BoxDecoration(color: PdfColors.blue100),
                    children: [
                      _pdfTableHeader('Organization Name'),
                      _pdfTableHeader('Event Date'),
                      _pdfTableHeader('Event Name'),
                      _pdfTableHeader('Shift Activity'),
                      _pdfTableHeader('Hours'),
                      _pdfTableHeader('Coordinator Name'),
                      _pdfTableHeader('Email'),
                    ],
                  ),
                  ...attendances.map((attendance) {
                    return pw.TableRow(
                      children: [
                        _pdfTableCell(attendance.organizationName),
                        _pdfTableCell(DateFormat('yyyy-MM-dd')
                            .format(DateTime.parse(attendance.eventDate))),
                        _pdfTableCell(attendance.eventName),
                        _pdfTableCell(attendance.shiftName),
                        _pdfTableCell(attendance.hoursAttended.toString()),
                        _pdfTableCell(attendance.coordinatorName),
                        _pdfTableCell(attendance.coordinatorEmail),
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

  pw.Widget _pdfTableHeader(String text) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontWeight: pw.FontWeight.bold,
          fontSize: 12,
          color: PdfColors.blueGrey800,
        ),
        textAlign: pw.TextAlign.center,
      ),
    );
  }

  pw.Widget _pdfTableCell(String text) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      child: pw.Text(
        text,
        style: pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
        textAlign: pw.TextAlign.center,
      ),
    );
  }
}

class AttendanceList extends StatelessWidget {
  final List<Attendance> attendances;

  const AttendanceList({required this.attendances, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: attendances.length,
      itemBuilder: (context, index) {
        final attendance = attendances[index];
        return Card(
          color: Colors.white,
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildRow('Organization', attendance.organizationName),
                _buildRow('Event Date', attendance.eventDate),
                _buildRow('Event Name', attendance.eventName),
                _buildRow('Shift Activity', attendance.shiftName),
                _buildRow(
                    'Hours Attended', attendance.hoursAttended.toString()),
                _buildRow('Coordinator', attendance.coordinatorName),
                _buildRow('Email', attendance.coordinatorEmail),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF0070BB),
            ),
          ),
          Expanded(
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volufriend/auth/bloc/org_event_bloc.dart';
import 'models/userprofilelist_item_model.dart';
import 'models/vf_approvehoursscreen_model.dart';
import 'widgets/userprofilelist_item_widget.dart';
import 'bloc/vf_approvehoursscreen_bloc.dart';
import '../../widgets/custom_elevated_button.dart';
import 'package:volufriend/crud_repository/volufriend_crud_repo.dart';
import 'package:intl/intl.dart';
import '../../auth/bloc/login_user_bloc.dart';

class VfApprovehoursscreenScreen extends StatelessWidget {
  const VfApprovehoursscreenScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    final vfcrudService = VolufriendCrudService(); // Define the vfcrudService
    final String eventId =
        BlocProvider.of<orgVoluEventBloc>(context).state.eventId;
    final String shiftId1 =
        BlocProvider.of<orgVoluEventBloc>(context).state.shiftId1;
    final String shiftId2 =
        BlocProvider.of<orgVoluEventBloc>(context).state.shiftId2;
    final String eventName =
        BlocProvider.of<orgVoluEventBloc>(context).state.eventSelected?.title ??
            '';
    final DateTime? tmpeventDate = BlocProvider.of<orgVoluEventBloc>(context)
        .state
        .eventSelected
        ?.startDate;
    final String? eventDate = tmpeventDate != null
        ? DateFormat('EEEE, MMMM d, y').format(tmpeventDate)
        : null;

    return BlocProvider<VfApprovehoursscreenBloc>(
      create: (context) => VfApprovehoursscreenBloc(
        vfcrudService: vfcrudService,
        initialState: VfApprovehoursscreenState(
          vfApprovehoursscreenModelObj: VfApprovehoursscreenModel(),
          searchController: TextEditingController(),
          shift1Attendees: [], // Empty list of attendees for shift 1
          shift2Attendees: [], // Empty list of attendees for shift 2
        ),
      )..add(VfApprovehoursscreenInitialEvent(eventId, shiftId1, shiftId2,
          eventName, eventDate!)), // Dispatch the initial event
      child: const VfApprovehoursscreenScreen(), // Your screen widget
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildEventDetails(context),
              const SizedBox(height: 8),
              Expanded(
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      _buildShiftTabs(),
                      const SizedBox(height: 8),
                      Expanded(
                        child: TabBarView(
                          children: [
                            _buildShiftContent(context, "Shift Id1", 0),
                            _buildShiftContent(context, "Shift Id2", 1),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// AppBar with elegant background
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(
        "Approve Attendance",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      backgroundColor: Colors.blueAccent,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      ),
      elevation: 0,
    );
  }

  /// Event Details: Name on left and Date with Icon on right
  Widget _buildEventDetails(BuildContext context) {
    return BlocBuilder<VfApprovehoursscreenBloc, VfApprovehoursscreenState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Event Name on the left
            Text(
              state.eventName ?? "Event Name",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            // Event Date with an Icon on the right
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  state.eventDate ?? "Event Date",
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  /// Tabs for Shifts with custom styling
  Widget _buildShiftTabs() {
    return BlocBuilder<VfApprovehoursscreenBloc, VfApprovehoursscreenState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: TabBar(
            labelColor: Colors.blueAccent,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blueAccent,
            tabs: [
              Tab(
                child: Column(
                  children: [
                    const Text("Shift 1",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(
                      "${state.vfApprovehoursscreenModelObj.shift1Attendees.length} Attendees\n",
                      style:
                          const TextStyle(fontSize: 12, color: Colors.black54),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Tab(
                child: Column(
                  children: [
                    const Text("Shift 2",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(
                      "${state.vfApprovehoursscreenModelObj.shift2Attendees.length} Attendees\n",
                      style:
                          const TextStyle(fontSize: 12, color: Colors.black54),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Shift Content including user list and buttons
  Widget _buildShiftContent(
      BuildContext context, String shiftId, int shiftIndex) {
    return Column(
      children: [
        Expanded(child: _buildUserProfileList(context, shiftId, shiftIndex)),
        _buildTotalHoursDisplay(context, shiftId, shiftIndex),
        const SizedBox(height: 8),
        _buildApproveRejectButtons(context, shiftId, shiftIndex),
      ],
    );
  }

  /// User Profile List for each Shift
  Widget _buildUserProfileList(
      BuildContext context, String shiftId, int shiftIndex) {
    return BlocBuilder<VfApprovehoursscreenBloc, VfApprovehoursscreenState>(
      builder: (context, state) {
        var attendees = shiftIndex == 0
            ? state.vfApprovehoursscreenModelObj.shift1Attendees
            : state.vfApprovehoursscreenModelObj.shift2Attendees;

        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 12),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: DataTable(
              columnSpacing: 16.0,
              headingRowColor: WidgetStateProperty.all(Colors.blueAccent),
              headingTextStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              dataTextStyle:
                  const TextStyle(fontSize: 14, color: Colors.black87),
              columns: const [
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Logged Hours')),
                DataColumn(label: Text('Approved Hours')),
                DataColumn(label: Text('Status')),
              ],
              rows: List<DataRow>.generate(
                attendees.length,
                (index) {
                  var attendee = attendees[index];
                  TextEditingController approvedHoursController =
                      TextEditingController(
                    text: attendee.hoursApproved?.toString(),
                  );

                  return DataRow(
                    cells: [
                      DataCell(Text(attendee.username ?? "Unknown")),
                      DataCell(Text(attendee.hoursAttended?.toString() ?? "0")),
                      DataCell(
                        TextFormField(
                          controller: approvedHoursController,
                          enabled: attendee.isApproved ?? true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 12.0),
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            context.read<VfApprovehoursscreenBloc>().add(
                                  UpdateApprovedHoursEvent(
                                    shiftId: shiftId,
                                    shiftIndex: shiftIndex,
                                    attendeeIndex: index,
                                    approvedHours: int.tryParse(value) ?? 0,
                                  ),
                                );
                          },
                        ),
                      ),
                      DataCell(
                        Switch(
                          value: attendee.isApproved ?? true,
                          onChanged: (value) {
                            if (!value) {
                              approvedHoursController.clear();
                              context.read<VfApprovehoursscreenBloc>().add(
                                    UpdateApprovedHoursEvent(
                                      shiftId: shiftId,
                                      shiftIndex: shiftIndex,
                                      attendeeIndex: index,
                                      approvedHours: 0,
                                    ),
                                  );
                            }
                            context.read<VfApprovehoursscreenBloc>().add(
                                  ToggleApproveRejectEvent(
                                    shiftId: shiftId,
                                    attendeeIndex: index,
                                    isApproved: value,
                                    shiftIndex: shiftIndex,
                                  ),
                                );
                          },
                          activeColor: Colors.green,
                          inactiveThumbColor: Colors.red,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  /// Total Hours and Attendees Display for each shift
  Widget _buildTotalHoursDisplay(
      BuildContext context, String shiftId, int shiftIndex) {
    return BlocBuilder<VfApprovehoursscreenBloc, VfApprovehoursscreenState>(
      builder: (context, state) {
        final shiftAttendees = state.getAttendeesForShift(shiftId, shiftIndex);
        final totalAttendees = shiftAttendees.length;
        final totalApprovedHours = shiftAttendees
            .where((a) => a.isApproved == true)
            .fold<double>(0, (sum, a) => sum + (a.hoursApproved ?? 0));
        final totalAttendedHours = shiftAttendees.fold<double>(
            0, (sum, a) => sum + (a.hoursAttended ?? 0));

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            children: [
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Total Attendees: $totalAttendees",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Total Attended: ${totalAttendedHours.toStringAsFixed(1)} hrs",
                    style: const TextStyle(color: Colors.grey),
                  ),
                  Text(
                    "Total Approved: ${totalApprovedHours.toStringAsFixed(1)} hrs",
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              const Divider(),
            ],
          ),
        );
      },
    );
  }

  /// Approve and Reject Buttons for each shift
  Widget _buildApproveRejectButtons(
      BuildContext context, String shiftId, int shiftIndex) {
    return BlocBuilder<VfApprovehoursscreenBloc, VfApprovehoursscreenState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomElevatedButton(
              width: 106,
              onPressed: () {
                context.read<VfApprovehoursscreenBloc>().add(
                    VfSubmitApprovehourEvent(
                        getOrgUserId(context), shiftIndex));
              },
              text: "Submit",
              buttonStyle: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 3,
              ),
            ),
            CustomElevatedButton(
              onPressed: () {
                context
                    .read<VfApprovehoursscreenBloc>()
                    .add(RejectAllHoursEvent(shiftId, shiftIndex));
              },
              text: "Reject All",
              buttonStyle: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 3,
              ),
            ),
          ],
        );
      },
    );
  }

  static String getOrgUserId(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);
    final userState = userBloc.state;
    if (userState is LoginUserWithHomeOrg) {
      final userHomeOrg = userState.user.userHomeOrg;
      return userHomeOrg?.useridinorg ?? '';
    }
    return '';
  }
}

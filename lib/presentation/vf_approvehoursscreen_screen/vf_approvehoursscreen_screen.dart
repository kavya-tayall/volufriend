import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volufriend/auth/bloc/org_event_bloc.dart';
import 'package:volufriend/presentation/vf_homescreen_container_screen/vf_homescreen_container_screen.dart';
import 'models/userprofilelist_item_model.dart';
import 'models/vf_approvehoursscreen_model.dart';
import 'widgets/userprofilelist_item_widget.dart';
import 'bloc/vf_approvehoursscreen_bloc.dart';
import '../../widgets/custom_elevated_button.dart';
import 'package:volufriend/crud_repository/volufriend_crud_repo.dart';
import 'package:intl/intl.dart';
import '../../auth/bloc/login_user_bloc.dart';
import '../../widgets/vf_app_bar_with_title_back_button.dart'; // Import custom app bar widget

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
        ? DateFormat('EEEE, MMM d, y').format(tmpeventDate)
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
      child: BlocListener<VfApprovehoursscreenBloc, VfApprovehoursscreenState>(
        listener: (context, state) {
          if (state.sucessMessage.isNotEmpty) {
            // Show success message with a shorter duration
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.sucessMessage),
                backgroundColor: Colors.green,
                duration: const Duration(seconds: 2), // Shorter duration
              ),
            );

            // Redirect to HomeContainerScreen after showing the message
            Future.delayed(const Duration(seconds: 2), () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => VfHomescreenContainerScreen()),
              );
            });
          }
        },
        child: Scaffold(
          appBar: VfAppBarWithTitleBackButton(
            title: "Approve Attendance",
            showSearchIcon: false,
            showFilterIcon: false,
            onBackPressed: () {
              context.read<orgVoluEventBloc>().add(approvehoursEvent(
                  '',
                  '',
                  '',
                  Voluevents(
                    eventId: '',
                  )));
              Navigator.of(context).pop();
            },
          ),
          body: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Column(
              children: [
                _buildEventDetails(context),
                const SizedBox(height: 12),
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
      ),
    );
  }

  Widget _buildEventDetails(BuildContext context) {
    return BlocBuilder<VfApprovehoursscreenBloc, VfApprovehoursscreenState>(
      builder: (context, state) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.eventName ?? "Event Name",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.calendar_today,
                        size: 14, color: Colors.blueAccent),
                    const SizedBox(width: 6),
                    Text(
                      state.eventDate ?? "Event Date",
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildShiftTabs() {
    return BlocBuilder<VfApprovehoursscreenBloc, VfApprovehoursscreenState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TabBar(
            labelColor: Colors.blueAccent,
            unselectedLabelColor: Colors.grey,
            indicator: BoxDecoration(
              color: Colors.blueAccent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            tabs: const [
              Tab(text: "Shift 1"),
              Tab(text: "Shift 2"),
            ],
          ),
        );
      },
    );
  }

  Widget _buildShiftContent(
      BuildContext context, String shiftId, int shiftIndex) {
    return Column(
      children: [
        Expanded(child: _buildUserProfileList(context, shiftId, shiftIndex)),
        const SizedBox(height: 12),
        _buildTotalHoursDisplay(context, shiftId, shiftIndex),
        const SizedBox(height: 16),
        _buildApproveRejectButtons(context, shiftId, shiftIndex),
      ],
    );
  }

  Widget _buildUserProfileList(
      BuildContext context, String shiftId, int shiftIndex) {
    return BlocBuilder<VfApprovehoursscreenBloc, VfApprovehoursscreenState>(
      builder: (context, state) {
        var attendees = shiftIndex == 0
            ? state.vfApprovehoursscreenModelObj.shift1Attendees
            : state.vfApprovehoursscreenModelObj.shift2Attendees;

        return SingleChildScrollView(
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 2,
            child: DataTable(
              columnSpacing: 12.0,
              headingRowColor: MaterialStateProperty.all(Colors.blueAccent),
              headingTextStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
              dataTextStyle:
                  const TextStyle(fontSize: 12, color: Colors.black87),
              columns: const [
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Logged')),
                DataColumn(label: Text('Approved')),
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
                        SizedBox(
                          width: 50,
                          child: TextFormField(
                            controller: approvedHoursController,
                            enabled: attendee.isApproved ?? true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 8.0),
                            ),
                            keyboardType: TextInputType.number,
                            style: const TextStyle(fontSize: 12),
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
          child: Card(
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Wrap(
                alignment: WrapAlignment.spaceEvenly,
                runSpacing: 8.0,
                children: [
                  _buildInfoTile(
                    icon: Icons.group,
                    label: "Attendees",
                    value: "$totalAttendees",
                  ),
                  _buildInfoTile(
                    icon: Icons.access_time,
                    label: "Attended",
                    value: "${totalAttendedHours.toStringAsFixed(1)} hrs",
                  ),
                  _buildInfoTile(
                    icon: Icons.check_circle,
                    label: "Approved",
                    value: "${totalApprovedHours.toStringAsFixed(1)} hrs",
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoTile(
      {required IconData icon, required String label, required String value}) {
    return SizedBox(
      width: 80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.blueAccent, size: 18),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildApproveRejectButtons(
      BuildContext context, String shiftId, int shiftIndex) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomElevatedButton(
            height: 36,
            width: 140,
            onPressed: () {
              context.read<VfApprovehoursscreenBloc>().add(
                  VfSubmitApprovehourEvent(getOrgUserId(context), shiftIndex));
            },
            text: "Submit",
            buttonStyle: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ),
          CustomElevatedButton(
            height: 36,
            width: 140,
            onPressed: () {
              context.read<VfApprovehoursscreenBloc>().add(RejectAllHoursEvent(
                  shiftId, shiftIndex, getOrgUserId(context)));
            },
            text: "Reject All",
            buttonStyle: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              backgroundColor: Colors.red,
            ),
          ),
        ],
      ),
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volufriend/auth/bloc/org_event_bloc.dart';
import 'package:volufriend/core/utils/size_utils.dart';
import 'package:volufriend/crud_repository/volufriend_crud_repo.dart';
import 'bloc/vf_myupcomingeventscreen_bloc.dart';
import 'models/vf_myupcomingeventscreen_model.dart';
import '../../auth/bloc/login_user_bloc.dart';
import 'package:intl/intl.dart';
import 'widgets/myupcomingevent_ListView_ListTile_widget.dart';

class VfMyupcomingeventscreenScreen extends StatelessWidget {
  const VfMyupcomingeventscreenScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            context.read<orgVoluEventBloc>().add(resetEvent());

            final userBloc = BlocProvider.of<UserBloc>(context);
            final userState = userBloc.state;

            if (userState is LoginUserWithHomeOrg) {
              final userId = userState.userId;

              final vfMyupcomingeventscreenBloc = VfMyupcomingeventscreenBloc(
                vfCrudService: context.read<VolufriendCrudService>(),
                initialState: const VfMyupcomingeventscreenState(
                  vfMyupcomingeventscreenModelObj:
                      VfMyupcomingeventscreenModel(),
                ),
              );

              vfMyupcomingeventscreenBloc
                  .add(LoadUpcomingEventsEvent(userId: userId!));

              return vfMyupcomingeventscreenBloc;
            } else {
              return VfMyupcomingeventscreenBloc(
                vfCrudService: context.read<VolufriendCrudService>(),
                initialState: const VfMyupcomingeventscreenState(
                  vfMyupcomingeventscreenModelObj:
                      VfMyupcomingeventscreenModel(),
                ),
              );
            }
          },
        ),
      ],
      child: const VfMyupcomingeventscreenScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(top: 14.h),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24.h),
                BlocBuilder<VfMyupcomingeventscreenBloc,
                    VfMyupcomingeventscreenState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state.vfMyupcomingeventscreenModelObj?.orgEvent
                            ?.isNotEmpty ==
                        true) {
                      final events =
                          state.vfMyupcomingeventscreenModelObj?.orgEvent ?? [];
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: events.length,
                        itemBuilder: (context, index) {
                          final event = events[index];
                          final hasShift1 = event.shifts.isNotEmpty;
                          final hasShift2 = event.shifts.length > 1;

                          return EventTile(
                            eventName: event.title ?? 'No Title',
                            location: event.address ?? 'No Address',
                            eventDate: event.startDate ?? DateTime.now(),
                            shift1Name: hasShift1
                                ? event.shifts[0].activity ?? 'No Shift'
                                : 'No Shift',
                            shift1StartTime: hasShift1
                                ? event.shifts[0].startTime
                                : DateTime.now(),
                            shift1EndTime: hasShift1
                                ? event.shifts[0].endTime
                                : DateTime.now(),
                            shift2Name:
                                hasShift2 ? event.shifts[1].activity : null,
                            shift2StartTime:
                                hasShift2 ? event.shifts[1].startTime : null,
                            shift2EndTime:
                                hasShift2 ? event.shifts[1].endTime : null,
                            isFirstRow: index == 0 ? true : false,
                            onWithdraw: () => _showWithdrawConfirmationDialog(
                                context, event.title ?? 'No Title'),
                          );
                        },
                      );
                    } else if (state.errorMessage != '') {
                      return _buildErrorState();
                    } else {
                      return _buildEmptyState();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('My Upcoming Events',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.h,
          )),
      elevation: 4,
      backgroundColor: Colors.teal,
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {
            // Handle notifications
          },
        ),
      ],
    );
  }

  void _showWithdrawConfirmationDialog(BuildContext context, String eventName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // Rounded corners
          ),
          title: Row(
            children: const [
              Icon(Icons.warning_amber_rounded, color: Colors.orange),
              SizedBox(width: 10), // Spacing between icon and text
              Text('Withdraw from Event'),
            ],
          ),
          content: Text(
            'Are you sure you want to withdraw from "$eventName"? Your spot will be released, and you won’t be able to attend this event.',
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
          actionsPadding:
              const EdgeInsets.all(12), // Padding around the buttons
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                'No, Keep My Spot',
                style: TextStyle(
                  color: Colors.green, // Positive action color
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent, // Danger action color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Rounded button
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 8), // Padding inside the button
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // Call your BLoC or method to withdraw from the event
                // context.read<VfMyupcomingeventscreenBloc>().add(WithdrawEvent(eventId));
              },
              child: const Text(
                'Yes, Withdraw',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: Colors.red, size: 80.h),
          SizedBox(height: 16.h),
          Text('Error loading events', style: TextStyle(fontSize: 18.h)),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.event_note, color: Colors.grey, size: 80.h),
          SizedBox(height: 16.h),
          Text('No upcoming events available',
              style: TextStyle(fontSize: 18.h)),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volufriend/core/app_export.dart';
import 'package:volufriend/core/utils/size_utils.dart';
import 'package:volufriend/crud_repository/volufriend_crud_repo.dart';
import 'package:volufriend/localization/app_localization.dart';

import 'bloc/vf_volunteerhomepage_bloc.dart';
import 'models/vf_volunteerhomepage_model.dart';

class VfVolunteerHomepageScreen extends StatelessWidget {
  const VfVolunteerHomepageScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    context
        .read<VfVolunteerhomepageBloc>()
        .add(VfVolunteerhomepageInitialEvent());
    return MultiBlocProvider(
      providers: [
        // VolunteerBloc provider
        BlocProvider(
          create: (context) => VolunteerBloc(
            context
                .read<VolufriendCrudService>(), // Correctly passing the service
          )..add(
              LoadUpcomingEvents('-O7B9mT9rUCaKu7B6Oxh')), // Trigger the event
        ),

        // InterestBloc provider
        BlocProvider(
          create: (context) => InterestBloc(
            context
                .read<VolufriendCrudService>(), // Correctly passing the service
          )..add(LoadInterestedEvents(
              'Lp11LruykHU1CJDhapwxsrL1XhG3')), // Trigger the event with userId
        ),
      ],
      child: const VfVolunteerHomepageScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(top: 14.h),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "lbl_upcoming_volunteering_events".tr,
                  style: theme.textTheme.headlineMedium,
                ),
                SizedBox(height: 24.h),
                BlocBuilder<VolunteerBloc, VolunteerState>(
                  builder: (context, state) {
                    if (state is VolunteerLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is VolunteerLoaded) {
                      final events = state.upcomingEvents;
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: events.length,
                        itemBuilder: (context, index) {
                          return EventCard(event: events[index]);
                        },
                      );
                    } else if (state is VolunteerError) {
                      return Center(child: Text('Error loading events'.tr));
                    } else {
                      return Center(child: Text('No data available'.tr));
                    }
                  },
                ),
                SizedBox(height: 16.h),
                Text(
                  "lbl_events_interested_in".tr,
                  style: theme.textTheme.headlineMedium,
                ),
                SizedBox(height: 24.h),
                BlocBuilder<InterestBloc, InterestState>(
                  builder: (context, state) {
                    if (state is InterestLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is InterestLoaded) {
                      final events = state.interestedEvents;
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: events.length,
                        itemBuilder: (context, index) {
                          return EventCard(event: events[index]);
                        },
                      );
                    } else if (state is InterestError) {
                      return Center(
                          child: Text('Error loading interested events'.tr));
                    } else {
                      return Center(child: Text('No data available'.tr));
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

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('lbl_volunteer_home'.tr),
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
}

class EventCard extends StatelessWidget {
  final Voluevents event;

  const EventCard({required this.event, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.h),
      child: ListTile(
        title: Text(event.title ?? 'lbl_no_title'.tr),
        subtitle: Text(event.startDate.toString()),
        onTap: () {
          // Handle event tap
        },
      ),
    );
  }
}

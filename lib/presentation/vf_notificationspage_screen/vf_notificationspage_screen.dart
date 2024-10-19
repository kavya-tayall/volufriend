// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/app_export.dart';
import 'bloc/vf_notificationspage_bloc.dart';
import 'package:volufriend/crud_repository/volufriend_crud_repo.dart';
import '../../auth/bloc/login_user_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart'; // Import Firebase Messaging
import 'package:volufriend/core/utils/LocalStorageService.dart'; // Import your LocalStorageService
import 'package:provider/provider.dart'; // Import the Provider package

class VfNotificatioPageScreen extends StatelessWidget {
  VfNotificatioPageScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    // Access the existing LocalStorageService instance from the provider
    final localStorageService =
        Provider.of<LocalStorageService>(context, listen: false);

    return BlocProvider<VfNotificationspageBloc>(
      create: (context) => VfNotificationspageBloc(
          vfcurdService: VolufriendCrudService(),
          initialState: NotificationsInitial(),
          localStorageService: localStorageService) // Use the existing instance
        ..add(LoadNotificationsEvent(
            BlocProvider.of<UserBloc>(context).state.userId!)),
      child: VfNotificatioPageScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Notifications"),
          actions: [
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                // Implement delete all notifications
                context
                    .read<VfNotificationspageBloc>()
                    .add(DeleteAllNotificationsEvent(// Dispatch the event
                        BlocProvider.of<UserBloc>(context).state.userId!));
              },
            ),
          ],
        ),
        body: BlocBuilder<VfNotificationspageBloc, VfNotificationspageState>(
          builder: (context, state) {
            if (state is NotificationsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is NotificationsLoaded) {
              return ListView.builder(
                itemCount: state.notificationList.length,
                itemBuilder: (context, index) {
                  final notification = state.notificationList[index];
                  return Dismissible(
                    key: Key(notification.id),
                    onDismissed: (direction) {
                      context.read<VfNotificationspageBloc>().add(
                          DeleteNotificationEvent(
                              notification.id,
                              BlocProvider.of<UserBloc>(context)
                                  .state
                                  .userId!));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text("${notification.title} dismissed")),
                      );
                    },
                    background: Container(color: Colors.red),
                    child: ListTile(
                      title: Text(notification.title,
                          style: notification.isRead
                              ? null
                              : TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(notification.message),
                    ),
                  );
                },
              );
            } else if (state is NotificationsError) {
              return Center(child: Text("Error loading notifications"));
            }
            return Container(); // Fallback
          },
        ),
      ),
    );
  }
}

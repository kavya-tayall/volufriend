/* import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_project/crud/get_user/bloc/bloc.dart';
import 'package:flutter_bloc_project/crud/get_users/bloc/bloc.dart';
import 'view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideDrawer(),
      appBar: AppBar(
        title: const Text("Get User"),
      ),
      body: const SafeArea(
        child: Column(
          children: [
            UserProfile(),
            Expanded(child: UserList()), // Added UserList to the HomePage
          ],
        ),
      ),
    );
  }
}

class UserProfile extends StatelessWidget {
  const UserProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUserBloc, GetUserState>(
      builder: (context, state) {
        switch (state) {
          case GetUserLoading():
            return const Center(child: CircularProgressIndicator());
          case GetUserLoaded():
            return Center(
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network("${state.user.pictureUrl}"),
                  ),
                  Text(
                    '${state.user.firstName} ${state.user.lastName}',
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            );
          case GetUserError():
            return const Text('Something went wrong!');
        }
      },
    );
  }
}

class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUsersBloc, GetUsersState>(
      builder: (context, state) {
        if (state is GetUsersLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetUsersLoaded) {
          if (state.users.isEmpty) {
            return const Center(child: Text('No users found'));
          }
          return ListView.builder(
            itemCount: state.users.length,
            itemBuilder: (context, index) {
              final user = state.users[index];
              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    user.pictureUrl ??
                        'https://via.placeholder.com/150', // Placeholder image for null avatars
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error),
                  ),
                ),
                title: Text(
                    '${user.firstName ?? 'Unknown'} ${user.lastName ?? 'User'}'),
                subtitle: Text(user.email ?? 'No email available'),
              );
            },
          );
        } else if (state is GetUsersError) {
          return const Center(child: Text('Something went wrong!'));
        } else {
          return const Center(child: Text('Unknown state'));
        }
      },
    );
  }
}
 */
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/app_export.dart';
import 'bloc/vf_settings_bloc.dart';

class VfSettingsScreen extends StatelessWidget {
  const VfSettingsScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<VfSettingsBloc>(
      create: (context) => VfSettingsBloc()..add(LoadSettingsEvent()),
      child: const VfSettingsScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: BlocBuilder<VfSettingsBloc, VfSettingsScreenState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Account Section
                _buildSectionTitle(context, 'Account'),
                const Divider(),
                _buildAccountOption(
                  context,
                  'Edit Profile',
                  Icons.edit,
                  () => Navigator.pushNamed(context, '/editProfile'),
                ),
                _buildAccountOption(
                  context,
                  'Change Password',
                  Icons.lock,
                  () => Navigator.pushNamed(context, '/changePassword'),
                ),
                const SizedBox(height: 20),
                // Notification Section
                _buildSectionTitle(context, 'Notifications'),
                const Divider(),
                _buildNotificationOption(
                  context,
                  'Send notifications on new events',
                  state.sendNotificationOnNewEvents,
                  (value) => context.read<VfSettingsBloc>().add(
                        ToggleNotificationEvent('newEvents', value),
                      ),
                ),
                _buildNotificationOption(
                  context,
                  'Send reminder prior to events',
                  state.sendReminderPriorToEvents,
                  (value) => context.read<VfSettingsBloc>().add(
                        ToggleNotificationEvent('eventReminders', value),
                      ),
                ),
                const SizedBox(height: 20),
                // Get Help Section
                _buildSectionTitle(context, 'Get Help'),
                const Divider(),
                _buildAccountOption(
                  context,
                  'Contact Support',
                  Icons.help_outline,
                  () => Navigator.pushNamed(context, '/contactSupport'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }

  Widget _buildAccountOption(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
      leading: Icon(icon, color: Theme.of(context).primaryColor),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _buildNotificationOption(
    BuildContext context,
    String title,
    bool value,
    Function(bool) onChanged,
  ) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
      title: Text(title),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}

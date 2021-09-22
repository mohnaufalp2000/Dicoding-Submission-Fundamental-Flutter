import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_3/data/provider/scheduling_provider.dart';
import 'package:submission_3/ui/widget/custom_dialog.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Material(
          child: ListTile(
            title: Text('Dark Theme'),
            trailing: Switch.adaptive(
                value: false, onChanged: (value) => customDialog(context)),
          ),
        ),
        Material(
          child: ListTile(
            title: Text('Notification'),
            trailing: Consumer<SchedulingProvider>(
              builder: (context, scheduled, _) {
                return Switch.adaptive(
                    value: scheduled.isScheduled,
                    onChanged: (value) async {
                      scheduled.scheduledRestaurant(value);
                    });
              },
            ),
          ),
        )
      ],
    );
  }
}

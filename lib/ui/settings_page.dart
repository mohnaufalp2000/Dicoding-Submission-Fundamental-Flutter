import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_3/data/provider/preferences_provider.dart';
import 'package:submission_3/data/provider/scheduling_provider.dart';
import 'package:submission_3/res/widget.dart';
import 'package:submission_3/ui/widget/custom_dialog.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provider, child) {
        return ListView(
          children: [
            Material(
              child: ListTile(
                title: textRegular('Dark Theme', 14),
                trailing: Switch.adaptive(
                    value: provider.isDarkTheme,
                    onChanged: (value) => provider.enabledDarkTheme(value)),
              ),
            ),
            Material(
              child: ListTile(
                title: textRegular('Notification', 14),
                trailing: Consumer<SchedulingProvider>(
                  builder: (context, scheduled, _) {
                    return Switch.adaptive(
                        value: provider.isDailyRestaurantActive,
                        onChanged: (value) async {
                          scheduled.scheduledRestaurant(value);
                          provider.enabledDailyNews(value);
                        });
                  },
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

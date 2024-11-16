import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:italky2/data%20storage/local%20storage/settings_saver.dart';

class NotificationSettings extends StatelessWidget {
  const NotificationSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Notification"),
        ),
        body: ListView(
          children: [
            SettingsGroup(title: "general", children: [
              SwitchSettingsTile(
                title: "New messages",
                settingKey: SettingCache.messagesNotificationKey,
                defaultValue: true,
              ),
              SwitchSettingsTile(
                title: "New requests",
                settingKey: SettingCache.newRequestKey,
                defaultValue: true,
              ),
              SettingsGroup(
                title: "about app",
                children: [
                  SwitchSettingsTile(
                    title: "App updates",
                    settingKey: SettingCache.updateNotificationKey,
                    defaultValue: true,
                  ),
                  SimpleSettingsTile(title: "What's new",child:const Scaffold(),)
                ],
              ),
            ])
          ],
        ),
      ),
    );
  }
}

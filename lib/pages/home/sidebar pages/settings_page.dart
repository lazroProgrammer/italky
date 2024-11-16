import 'package:flutter/material.dart';
import 'package:italky2/pages/home/sidebar%20pages/settings_pages/notification_settings.dart';

import 'package:quickalert/quickalert.dart';

import 'package:flutter_settings_screens/flutter_settings_screens.dart';

import 'package:italky2/pages/home/sidebar pages/settings_pages/icon_widget.dart';

import 'package:italky2/pages/home/sidebar pages/settings_pages/account_settings.dart';

import 'package:italky2/data storage/local storage/settings_saver.dart';



class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: SafeArea(
          child: ListView(
            children: [
              SwitchSettingsTile(
                settingKey: SettingCache.nightModeKey,
                title: "Dark mode",
                leading: const IconWidget(
                    icon: Icons.dark_mode, color: Color(0xFF642ef3)),
                onChange: (_){}
              ),
              const SizedBox(
                height: 8.0,
              ),
              SettingsGroup(title: "General", children: [
                SimpleSettingsTile(
                  title: "Account settings",
                  subtitle: "Privacy, security, language",
                  leading:const IconWidget(color: Colors.green,icon: Icons.person, ),
                  child: const AccountSettings(),
                ),

                SimpleSettingsTile(
                  title: "Notification",
                  subtitle: "messages, app updates",
                  leading: const IconWidget(
                      icon: Icons.notifications, color: Colors.orange),
                    child: const NotificationSettings(),
                ),
                SimpleSettingsTile(
                  title: "Delete account",
                  leading: const IconWidget(
                      icon: Icons.delete_forever, color: Colors.redAccent),
                  onTap: () => QuickAlert.show(
                      context: context,
                      type: QuickAlertType.confirm,
                      text: "do you want to proceed ?",
                      confirmBtnText: "Yes",
                      confirmBtnColor: Colors.redAccent,
                      onConfirmBtnTap: () {
                        Navigator.of(context).pop();
                      }),
                ),
              ]),
              SettingsGroup(title: "Feedback", children: [
                 const SizedBox(height: 8,),
                SimpleSettingsTile(
                  title: "Report a bug",
                  leading: IconWidget(
                      icon: Icons.bug_report, color: Colors.green.shade700),
                ),
                SimpleSettingsTile(
                  title: "Send feedback",
                  leading:const IconWidget(
                      icon: Icons.thumb_up, color: Colors.purple),
                      onTap: () {
                        
                      },
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }
}

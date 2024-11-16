import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:italky2/data storage/local storage/settings_saver.dart';

class AccountSettings extends StatelessWidget {
  const AccountSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Account Settings"),
        ),
        body: ListView(
          children: [
            SettingsGroup(
              title: "language",
              children: [
                DropDownSettingsTile(
                  title: "Language",
                  settingKey: SettingCache.selectLanguageKey,
                  selected: 1,
                  values: const <int, String>{
                    1: "English",
                    2: "French",
                    3: "Spanish",
                  },
                ),
              ],
            ),
            SettingsGroup(
              title: "Privacy",
              children: [
                SwitchSettingsTile(
                  title: "Hide Phone Number",
                  settingKey: SettingCache.phoneKey,
                ),
                SwitchSettingsTile(
                  title: "Hide email address",
                  settingKey: SettingCache.emailAddressKey,
                ),
              ],
            ),
            SettingsGroup(
              title: "Security",
              children: [
                TextInputSettingsTile(
                  title: "Recovery email",
                  settingKey: SettingCache.recoveryEmailKey,
                  initialValue: "none",
                ),
                TextInputSettingsTile(
                  title: "Recovery phone number",
                  settingKey: SettingCache.recoveryPhoneKey,
                  initialValue: "none",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

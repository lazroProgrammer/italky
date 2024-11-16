//main flutter packages
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
 import 'package:flutter_localizations/flutter_localizations.dart';
 import 'package:italky2/app_Localization.dart';

//project files
import 'package:italky2/widget_tree.dart';
import 'firebase_options.dart';
//to initialize local cache using shared preferences
import 'package:italky2/data storage/local storage/simple_preferences.dart';

//for firebase initialization
import 'package:firebase_core/firebase_core.dart';

//for initialising settings UI package
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

//to have the cache key
import 'package:italky2/data storage/local storage/settings_saver.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Settings.init(cacheProvider: SharePreferenceCache());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //vertical orientation for the app
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await SimplePreferences.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool signedIn = false;

  @override
  Widget build(BuildContext context) {
    return ValueChangeObserver(
      cacheKey: SettingCache.nightModeKey,
      defaultValue: false,
      builder: (context, isDarkMode, __) => MaterialApp(
        title: 'italky',
        debugShowCheckedModeBanner: false,
        theme: isDarkMode
            ? ThemeData.dark().copyWith(
                appBarTheme: AppBarTheme(
                color: Colors.purple.shade700,
              ))
            : ThemeData.light().copyWith(
                appBarTheme: const AppBarTheme(
                color: Colors.purple,
              )),
        home: const WidgetTree(),
        
        supportedLocales: const [ Locale('en'), Locale('fr'), Locale('ar')],
        localizationsDelegates:const [AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,],
        localeResolutionCallback: (deviceLocale, supportedLocales){
          if(deviceLocale!= null && supportedLocales.contains(deviceLocale)){
              return deviceLocale;
          }
          return supportedLocales.first;
        },

      ),
    );
  }
}

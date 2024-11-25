import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chatt/screens/home_screen.dart';
// import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_notification_channel/notification_importance.dart';
import 'package:flutter_notification_channel/flutter_notification_channel.dart';
import '../helper/themes.dart';
import '../screens/splash_screen.dart';
import '../providers/text_type_provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

//initializing SharedPreferences globally!
SharedPreferences? sharedPrefs;
Future<void> main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  //initializing firebase
  // await _initializeFirebase();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print("\n\nFirebase initialiazed................");


// ...



  //instance of sharedPreferences
  //before runApp()
  sharedPrefs = await SharedPreferences.getInstance();
  runApp(MyApp());
}

//global MediaQuery object to access device height and width
late Size mq;

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => TextTypeProvider(selectedTextType: 'Sen')),
      ],
      child: Consumer<TextTypeProvider>(
        builder: (_, value, __) {
          return MaterialApp(
            // darkTheme: ThemeData.dark(),
              debugShowCheckedModeBanner: false,
              title: 'AKR Chat App',
              theme: ThemeData(
                // fontFamily: 'Boogaloo',s
                //using sharedPrefs to remember user text theme choice
                fontFamily: value.getselectedTextType,
                primarySwatch: Colors.deepOrange,
                appBarTheme: AppBarTheme(
                  // centerTitle: true,
                    elevation: 1,
                    iconTheme: IconThemeData(color: Colors.black),
                    titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      fontFamily: value.getselectedTextType,
                    ),
                    backgroundColor: Colors.white),
                textTheme: Themes.myTextTheme,
              ),
              // home: HomeScreen());
              home: SplashScreen());
        },
      ),
    );
  }
}

_initializeFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // var result = await FlutterNotificationChannel.registerNotificationChannel(
  //     description: 'For showing message notifications',
  //     id: 'chats',
  //     importance: NotificationImportance.IMPORTANCE_HIGH,
  //     name: 'Chats',
  //   );
  // print("========> Notification channel result : $result");
}

class TextThemeClass {
  static String? textType = sharedPrefs!.getString('textType') ?? null;
}

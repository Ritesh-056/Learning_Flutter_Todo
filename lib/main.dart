import 'dart:async';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_app/provider/generic_function_provider.dart';
import 'package:flutter_app/provider/password_field_checker.dart';
import 'package:flutter_app/screens/sign_up.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'const.dart';
import 'showDetails/showTask.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

//flutter packages importing
import 'package:firebase_core/firebase_core.dart';
import 'screens/login_page.dart';

var auth = FirebaseAuth.instance;
BuildContext? mContext;

// this is main methods for
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => PasswordVisibility()),
      ChangeNotifierProvider(create: (context) => GenericHelperProvider()),
    ],
    child: LoginDesign(),
  ));
}

class LoginDesign extends StatelessWidget {
  double iconSize = 100;
  int durationTime = 3000;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: colorsName,
        iconTheme: new IconThemeData(color: colorsName),
        fontFamily: 'Monotype Coursiva',
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: colorsName), //3, //3
      ),
      home: loadHome(),
    );
  }

  Widget loadHome() {
    return SafeArea(
      child: Scaffold(
        body: AnimatedSplashScreen(
          duration: durationTime,
          splash: new Image.asset('assets/Spinner.gif'),
          splashTransition: SplashTransition.slideTransition,
          backgroundColor: text_color_white,
          splashIconSize: iconSize,
          nextScreen: auth.currentUser?.uid == null
              ? LoginPage()
              : TodoHome(),
        ),
      ),
    );
  }
}

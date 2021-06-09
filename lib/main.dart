import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:teachme/Screens/WelcomeScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(
            seconds: 5,
            navigateAfterSeconds: new AfterSplash(),
            title: new Text(
              'TeachMe',
              style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                  letterSpacing: 2.0,
                  fontSize: 40.0),
            ),
            gradientBackground: LinearGradient(
              colors: [Colors.white, Colors.blue[200]],
            ),
            styleTextUnderTheLoader: new TextStyle(),
            photoSize: 100.0,
            onClick: () => print("Flutter Egypt"),
            loaderColor: Colors.red));
  }
}

class AfterSplash extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Oxygen'),
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
    );
  }
}

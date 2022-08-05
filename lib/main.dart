import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:frankie_s/ui/homepage.dart';
import 'package:frankie_s/ui/signin.dart';
import 'package:frankie_s/ui/splashscreen.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../Model/foodModel.dart';
import 'Model/cartlistbloc.dart';
import 'Model/model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        //add yours BLoCs controlles
        Bloc((i) => CartListBloc()),
        //Bloc((i) => ColorBloc()),
      ],
      dependencies: [],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => Model()),
        ],
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: SplashScreen(),
          routes: <String, WidgetBuilder>{
            '/SignIn': (BuildContext context) => const SignInPage(),
            '/HomePage': (BuildContext context) => HomePage(),
            '/Splashscreen': (BuildContext context) => const SplashScreen(),
            /*'/WelcomePage':(BuildContext context)=> const WelcomePage(),
          '/SplashScreen':(BuildContext context)=> const SplashScreen(),
          '/Login':(BuildContext context)=> const Login(),
          '/SignUp':(BuildContext context)=> const SignUp(),*/
          },
        ),
      ),
    );
  }
}

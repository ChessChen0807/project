import 'package:flutter/material.dart';
import 'package:project/routePage.dart';
import 'package:project/trending.dart';
import 'landing_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'ApplicationState.dart';
import 'httpRequest.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(ChangeNotifierProvider(
      create: (context) => ApplicationState(),
    builder: ((context, child) => const MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: AuthenticationWrapper()
    );
  }
}

class AuthenticationWrapper extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return CircularProgressIndicator();
          }else{
            if(snapshot.hasData){
              print("User is logged in");
              return const RoutePage();
            }else{
              print("User needs to log in");
              return LandingPage(name: 'Login / Sign Up');
            }
          }
        }
    );
  }
}

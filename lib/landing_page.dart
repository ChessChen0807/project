//importing necessary libraries for landing page
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//:TODO Add the auth_service.dart

class LandingPage extends StatefulWidget{
  const LandingPage({Key? key, required this.name}) : super(key: key);

  final String name;

  @override
  _LandingPageState createState() => _LandingPageState();
}

//type underscore to make classes private, private classes cannot be accessed in other file.

class _LandingPageState extends State<LandingPage>{
  //_autho an instance of FirebaseAUth which gives us access to firebase auth functions.
  late FirebaseAuth _auth;

  //Text controller for email, username, and password
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //Set an empty string to hold error messages
  String _errorMessage = '';

  //Function to log the user in using their email and password
  void _login(){


  }
}
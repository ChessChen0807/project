//importing necessary libraries for landing page
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//:TODO Add the auth_service.dart

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key, required this.name}) : super(key: key);

  final String name;

  @override
  _LandingPageState createState() => _LandingPageState();
}

//type underscore to make classes private, private classes cannot be accessed in other file.

class _LandingPageState extends State<LandingPage> {

  late StreamSubscription<User?> user;
  //_autho an instance of FirebaseAUth which gives us access to firebase auth functions.
  late FirebaseAuth _auth;

  //Text controller for email, username, and password
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isSigningUp = true;

  //Set an empty string to hold error messages
  String _errorMessage = '';

  //Function to log the user in using their email and password
  void _login() {
    //Refreshing the screen
    setState(() {
      _errorMessage = ''; //This line resets errormessgaes
    });

    //hold user text data
    String _email = _emailController.text;
    String _password = _passwordController.text;
    String _username = _usernameController.text;

    //Set an empty function that runs when this page opens
    @override
    void initState(){
      super.initState();
      user = FirebaseAuth.instance.authStateChanges().listen((user) {
        if(user == null){ //Are not loggged in
          print("User is signed out");
        }else{
          print("User is logged in");
          //TODO: Navigate to the home page
        }
      });
    }


    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: _email, password: _password)
        .then((value) {
      //code that runs if login is successful
      //TODO: store token and data
      //TODO: Push to home page
    }).catchError((error) {
      //Code that runs if unsuccessful
      setState(() {
        _errorMessage = 'Failed to sign in ${error.toString()}';
      });
    });
  }

  //go back to previous page
  void _goBack() {
    Navigator.pop(context);
  }

  //Function of sign the user up if they do not have an account
  void _signup() {
    //Reset the error message
    setState(() {
      _errorMessage = '';
    });

    //Get the text from the text controllers
    String email = _emailController.text;
    String password = _passwordController.text;

    //Firebase signup
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((userCredential) async {
      //Check if username is allowed
      //TODO: call save user data function
      Future<bool> usernameAllowed = false as Future<bool>;

      if (await usernameAllowed) {
        //TODO: Store the token data
        //TODO: Change the page
      } else {
        _auth = FirebaseAuth.instance;
        final user = _auth.currentUser;
        await user?.delete();
      }
    }).catchError((onError) {
      //User failed to sign up
      setState(() {
        _errorMessage = 'Failed to sign up ${onError.toString()}';
      });
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            title: Text('Login / Sign up'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //Error message text
                Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
                if(isSigningUp)
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                  ),
                ),
                if(isSigningUp)
                const SizedBox(height: 16.0),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password'
                  ),
                ),
                const SizedBox(height: 16.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Login and sign up button
                        ElevatedButton(
                            onPressed: () {
                              if (isSigningUp) {
                                //User is trying to sign up
                                _signup();
                              } else {
                                _login();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                              Theme.of(context).colorScheme.primary,
                              minimumSize: const Size(250, 50),
                            ),
                            child: Text(
                              isSigningUp ? 'Sign Up' : 'Login',
                              style:const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              )
                            )
                        ),
                      ],
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: (){
                          if(isSigningUp){
                            setState(() {
                              isSigningUp = false;
                            });
                          }else{
                            setState(() {
                              isSigningUp = true;
                            });
                          }
                        },
                        child: Text(
                          isSigningUp ? 'Or Login' : 'Or Sign Up'
                        ),
                      )
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

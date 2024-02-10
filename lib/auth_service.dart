import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

//Handle all of login storage
class AuthService{

  //Initialize all of login storage
  final FirebaseAuth auth = FirebaseAuth.instance;
  final storage = const FlutterSecureStorage();

  //Function to store tokens for login
  //TODO: Function to store taken for login

  //Function to log the user out
  Future<void> logout() async {

  }
}
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
  try{
    //Sign them out of firebase
    await auth.signOut();
    //Remove the token
    //TODO: Remove token if necessary
  } catch (e){
    print(e);
  }
  }

  //Fetching the user's id for future use.
  Future<String?> getUserUID() async{
    final User? user = auth.currentUser;
    return user?.uid;
}
}
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HttpPage extends StatefulWidget {
  @override
  _HttpPageState createState() => _HttpPageState();
}

class _HttpPageState extends State<HttpPage> {

  String _responseData = "";

  //Function for fetching data from our api
  Future<void> fetchData(String path) async {
  //declare url
    var url = Uri.parse('https://chess-opening-analyzer.onrender.com');

    try {
      // http GET request
      var response = await http.get(url);

      //check if response was successful
      if (response.statusCode == 200){
        setState((){
          _responseData = response.body;
        });
      } else {
        print("Request failed with status: ${response.statusCode}");
      }
    }catch (e) {
      print("error: $e");
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    fetchData('/get_opening_name'); // test to run function
    return Scaffold(
      appBar: AppBar(
        title: Text('HTTP Request Example'),
      ),
      body: Center(
        child: Text(_responseData) //display response from api
      )
    );
  }
}
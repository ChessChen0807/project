import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HttpPage extends StatefulWidget {
  @override
  _HttpPageState createState() => _HttpPageState();
}

class _HttpPageState extends State<HttpPage> {

  String _inputData = "";
  String _responseData = "";
  TextEditingController _textController = TextEditingController();
  List<ChatMessage> _message = <ChatMessage>[];

  void _handleSubmitted(String text){
    if(_textController.text.isNotEmpty){
      _textController.clear();

      ChatMessage message = ChatMessage(message: text,
          isUserMessage: true
      );
      setState(() {
        _message.insert(0, message);
      });
      fetchData(text);
    }
  }

  //Function for fetching data from our api
  Future<void> fetchData(String path) async {
    //declare url
    var url = Uri.parse('https://chess-opening-analyzer.onrender.com/$path');

    try {
      // http GET request
      var response = await http.get(url);

      //check if response was successful
      if (response.statusCode == 200) {
        ChatMessage message = ChatMessage(message: response.body, isUserMessage: false);

        setState(() {
          _responseData = response.body;
          _message.insert(0, message);
        });
      } else {
        print("Request failed with status: ${response.statusCode}");
      }
    } catch (e) {
      print("error: $e");
    }
  }

  Widget _buildTextComposer(){
    return IconTheme(
        data: IconThemeData(),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: <Widget>[
              Container(
                child: Flexible(
                  child: TextField(
                    controller: _textController,
                    onSubmitted: _handleSubmitted,
                    decoration: InputDecoration.collapsed(hintText: 'Send a message'),
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  child: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () => _handleSubmitted(_textController.text),
                  )
              )
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Chess GPT'),
        ),
        body: Column(
          children: <Widget>[
            Flexible(
                child: ListView.builder(
                  itemBuilder: (_, int index) => _message[index],
                  itemCount: _message.length,
                ),
            ),
            Text("To contact ChessGPT, use the following instructions:\n"
               "get_opening_adive/<opening_name>\n"
               "top_n_opening_name/<int:number>\n"
               "victory_status_by_opening_name/<opening_name>"),
            Divider(height: 1.0,),
            _buildTextComposer() // use the _buildTextComposer
          ],
        ));
  }

}

class ChatMessage extends StatelessWidget {
  final String message;
  final bool isUserMessage;

  ChatMessage({required this.message, required this.isUserMessage});


  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: isUserMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  isUserMessage ? 'Me' : 'Chess GPT',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5.0),
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: isUserMessage
                        ? Colors.blue.withOpacity(0.3)
                        : Colors.grey.withOpacity(0.3),
                  ),
                  child: Text(message),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

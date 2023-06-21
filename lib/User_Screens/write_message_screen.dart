import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop_app/shared/custom_widgets.dart';
import 'package:coffee_shop_app/shared/database.dart';
import 'package:flutter/material.dart';

class WriteMessageScreen extends StatefulWidget {
  const WriteMessageScreen({Key? key}) : super(key: key);

  @override
  _WriteMessageScreenState createState() => _WriteMessageScreenState();
}

class _WriteMessageScreenState extends State<WriteMessageScreen> {
  var textController = TextEditingController();

  List<String> messages = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          TextField(
            controller: textController,
            maxLines: 6,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'write a message so we can improve our app.',
              labelStyle: TextStyle(color: Colors.white),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1),
              ),
              fillColor: Colors.white,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(20),
              color: Colors.brown[800],
            ),
            child: MaterialButton(
              onPressed: () {
                setState(() {
                  messages.add(textController.text);
                  Database.addMessage(message: '${textController.text}');
                });
              },
              child: Text(
                'Send Message',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('reviews').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                messages = snapshot.data!.docs.map((document) {
                  return document['message'].toString();
                }).toList();

                return myConditionalBuilder(
                  condition: (snapshot.hasData),
                  builder: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) =>
                        messageItem(messages[messages.length - (index + 1)]),
                    separatorBuilder: (BuildContext context, int index) =>
                        myDivider(),
                    itemCount: messages.length,
                  ),
                  fallback: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget messageItem(String message) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        message,
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }

  Widget myDivider() => Divider(
        thickness: 2,
        height: 25,
      );
}

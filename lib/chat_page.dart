import 'package:firebase_auth/firebase_auth.dart';
import 'package:five_dollar_lunch/add_food_page.dart';
import 'package:five_dollar_lunch/details_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  TextEditingController chatController = TextEditingController();

  List messages = [];

  @override
  void initState() {
    super.initState();
    // loadAllFoodItemsFromDb();
    loadAllMessagesFirebase();
    FirebaseFirestore.instance
        .collection("chatgroups")
        .doc("0lPMvYiOx5K56u12RFRW")
        .snapshots().listen((event) {
            print("event happening");
            print(event);
            loadAllMessagesFirebase();
        });
  }

  void loadAllMessagesFirebase() {
    messages = [];
    FirebaseFirestore.instance
        .collection("chatgroups")
        .doc("0lPMvYiOx5K56u12RFRW")
        .get()
        .then((querySnapshot) {
      print("Getting the messages: ");
      print(querySnapshot.get("message"));

      for (var chatRecord in querySnapshot.get("message")) {
        messages.add(chatRecord);
      }
      setState(() {});
    }).catchError((error) {
      print("Failed to get the food items from FB");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Group Chat"), actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.refresh),
          tooltip: 'Refresh',
          onPressed: () {
            loadAllMessagesFirebase();
          },
        ),
      ]),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(5),
                itemCount: messages.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Center(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Container(
                              height: 50,
                              child: messages[index]['uid'] == FirebaseAuth.instance.currentUser?.uid ?
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 90,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('${messages[index]['text']}'),
                                        Text(
                                            '${new DateTime.fromMicrosecondsSinceEpoch(messages[index]['time'] * 1000)}',
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.grey
                                          ),
                                        ),
                                        Text(
                                          '${messages[index]['uid']}',
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.grey
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                      flex: 10,
                                      child: Image.network(
                                        'https://icons.veryicon.com/png/o/miscellaneous/two-color-icon-library/user-286.png',
                                        // fit: BoxFit.fill,
                                      )),
                                ],
                              ) :
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                      flex: 10,
                                      child: Image.network(
                                        'https://icons.veryicon.com/png/o/miscellaneous/two-color-icon-library/user-286.png',
                                        // fit: BoxFit.fill,
                                      )),
                                  Expanded(
                                    flex: 90,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('${messages[index]['text']}'),
                                        Text(
                                          '${new DateTime.fromMicrosecondsSinceEpoch(messages[index]['time'] * 1000)}',
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.grey
                                          ),
                                        ),
                                        Text(
                                          '${messages[index]['uid']}',
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.grey
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ) ),
                        ),
                      ),
                    ),
                    onTap: () {
                      print("Clicked on " + index.toString() + " item");
                      print(messages[index]);
                      var food = messages[index];
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FoodDetailsPage(
                                  foodItem: food,
                                )),
                      );
                    },
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(5),
              child: Row(
                children: [
                  Expanded(
                    flex: 75,
                    child: TextField(
                      controller: chatController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Type your message ...',
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 25,
                    child: Container(
                      margin: EdgeInsets.only(left: 5),
                      child: ElevatedButton(
                          onPressed: () {
                            FirebaseFirestore.instance.collection("chatgroups").doc("0lPMvYiOx5K56u12RFRW").update(
                              {
                                "message" : FieldValue.arrayUnion([{
                                  "text" : chatController.text.toString(),
                                  "uid" : FirebaseAuth.instance.currentUser?.uid,
                                  "time" : DateTime.now().millisecondsSinceEpoch,
                                }])
                              }
                            ).then((value) {
                              print("Added the message");
                            }).catchError((error) {
                              print("Failed to add the message");
                            });
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          child: Text("Send")
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

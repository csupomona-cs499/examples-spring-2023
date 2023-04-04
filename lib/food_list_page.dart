import 'package:five_dollar_lunch/add_food_page.dart';
import 'package:five_dollar_lunch/details_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class FoodListPage extends StatefulWidget {
  const FoodListPage({Key? key}) : super(key: key);

  @override
  State<FoodListPage> createState() => _FoodListPageState();
}

class _FoodListPageState extends State<FoodListPage> {
  List foodItems = [];

  @override
  void initState() {
    super.initState();
    // loadAllFoodItemsFromDb();
    loadAllFoodItemsFromFirebase();
  }

  void loadAllFoodItemsFromFirebase() {
    FirebaseFirestore.instance
        .collection("foodlist")
        .get()
        .then((querySnapshot) {
      print("Getting the items: ");
      for (var docSnapshot in querySnapshot.docs) {
        print('${docSnapshot.id} => ${docSnapshot.data()}');
        foodItems.add(docSnapshot.data());
      }
      setState(() {});
    }).catchError((error) {
      print("Failed to get the food items from FB");
    });
  }

  void loadAllFoodItemsFromDb() {
    http
        .get(Uri.parse(
            'https://transparentmonumentalprediction.sunyu912.repl.co/list'))
        .then((value) {
      print("the request is sent successfully");
      // print(value.body.toString());
      foodItems = jsonDecode(value.body);
      print(foodItems);
      setState(() {});
    }).catchError((error) {
      print("the request is failed");
    });
    print("next line");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Food List Page"), actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.add),
          tooltip: 'Show Snackbar',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddFoodPage()),
            );
          },
        ),
      ]),
      body: Center(
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: foodItems.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Center(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: 100,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                flex: 30,
                                child: Image.network(
                                  foodItems[index]['imageUrl'],
                                  fit: BoxFit.fill,
                                )),
                            Expanded(
                              flex: 70,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('${foodItems[index]['name']}'),
                                  Text('${foodItems[index]['description']}'),
                                  Text('${foodItems[index]['rating']}'),
                                ],
                              ),
                            )
                          ],
                        )),
                  ),
                ),
              ),
              onTap: () {
                print("Clicked on " + index.toString() + " item");
                print(foodItems[index]);
                var food = foodItems[index];
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
    );
  }
}

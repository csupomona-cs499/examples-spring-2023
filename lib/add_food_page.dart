import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:five_dollar_lunch/food_list_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddFoodPage extends StatefulWidget {
  const AddFoodPage({Key? key}) : super(key: key);

  @override
  State<AddFoodPage> createState() => _AddFoodPageState();
}

class _AddFoodPageState extends State<AddFoodPage> {

  TextEditingController nameController = TextEditingController();
  TextEditingController ratingController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Add a New Food"),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Name',
              ),
            ),
            TextField(
              controller: ratingController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Rating',
              ),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Description',
              ),
            ),
            ElevatedButton(
                onPressed: (){
                  FirebaseFirestore.instance.collection("foodlist").add(
                    {
                      "name" : nameController.text.toString(),
                      "rating" : ratingController.text.toString(),
                      "description" : descriptionController.text.toString(),
                      "imageUrl" : "https://cdn1.iconfinder.com/data/icons/project-management-and-development/512/15_food_items_milk_items_coffee-512.png"
                    }
                  ).then((value) {
                    print("Added the food");
                  }).catchError((error) {
                    print("Failed to add the food");
                  });
                },
                child: Text('Add')
            ),
          ],
        ),
      ),
    );
  }
}

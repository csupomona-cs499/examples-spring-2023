import 'package:five_dollar_lunch/chat_page.dart';
import 'package:five_dollar_lunch/food_list_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Login"),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Username',
              ),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Password',
              ),
            ),
            ElevatedButton(
                onPressed: (){
                  FirebaseAuth.instance.signInWithEmailAndPassword(email: usernameController.text.toString(), password: passwordController.text.toString())
                      .then((value) {
                     print("Successfully signed in");
                     Navigator.push(
                       context,
                       MaterialPageRoute(builder: (context) => const ChatPage()),
                     );
                  }).catchError((error) {
                    print("Failed to sign in " + error.toString());
                  });
                },
                child: Text('Login')
            ),
            ElevatedButton(
                onPressed: (){
                  var username = usernameController.text.toString();
                  var password = passwordController.text.toString();
                  print("Username: " + username);
                  print("Password: " + password);

                  FirebaseAuth.instance.createUserWithEmailAndPassword(email: username, password: password)
                        .then((value) {
                          print("Successfully signed up.");
                          print(value.user?.uid.toString());
                        })
                        .catchError((error) {
                          print("Failed to signup" + error.toString());
                        });
                },
                child: Text('Signup')
            ),
          ],
        ),
      ),
    );
  }
}

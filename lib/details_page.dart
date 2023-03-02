import 'package:flutter/material.dart';

class FoodDetailsPage extends StatefulWidget {
  FoodDetailsPage({Key? key, dynamic this.foodItem}) : super(key: key);

  dynamic foodItem;

  @override
  State<FoodDetailsPage> createState() => _FoodDetailsPageState();
}

class _FoodDetailsPageState extends State<FoodDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              Expanded(
                flex: 30,
                child: Container(
                  margin: EdgeInsets.all(50),
                  child: Image(
                    image: NetworkImage(widget.foodItem['imageUrl'].toString()),
                  ),
                ),
              ),
              Expanded(
                flex: 10,
                child: Column(
                  children: [
                    Divider(
                      height: 20,
                      thickness: 5,
                      indent: 100,
                      endIndent: 100,
                      color: Colors.blue,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () { },
                        ),
                        Text("1"),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () { },
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 50,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                                alignment: Alignment.center,
                                child: Text(widget.foodItem['name'].toString())
                            )
                        ),
                        Expanded(
                            child: Container(
                                alignment: Alignment.center,
                                child: Text("\$10.00")
                            )
                        )
                      ],
                    ),
                    Expanded(
                      flex: 30,
                      child: Row(
                        children: [
                          Expanded(
                              child: Container(
                                  alignment: Alignment.center,
                                  child: Text(widget.foodItem['rating'].toString())
                              )
                          ),
                          Expanded(
                              child: Container(
                                  alignment: Alignment.center,
                                  child: Text("300 Calories")
                              )
                          ),
                          Expanded(
                              child: Container(
                                  alignment: Alignment.center,
                                  child: Text("30-40 mins")
                              )
                          )
                        ],
                      ),
                    ),
                    Text(
                      "Details",
                      style: TextStyle(
                        fontSize: 25
                      ),
                    ),
                    Text(
                        widget.foodItem['description'].toString(),
                        maxLines: 5
                    ),
                    Text(
                      "Ingrediants",
                      style: TextStyle(
                          fontSize: 25
                      ),
                    ),
                    Expanded(
                      flex: 50,
                      child: Row(
                        children: [
                          Expanded(
                            child: Image(
                              image: NetworkImage('https://i.pinimg.com/originals/b9/9d/89/b99d89b52f8fdbb286cff6085fc95381.png'),
                            ),
                          ),
                          Expanded(
                            child: Image(
                              image: NetworkImage('https://i.pinimg.com/originals/b9/9d/89/b99d89b52f8fdbb286cff6085fc95381.png'),
                            ),
                          ),
                          Expanded(
                            child: Image(
                              image: NetworkImage('https://i.pinimg.com/originals/b9/9d/89/b99d89b52f8fdbb286cff6085fc95381.png'),
                            ),
                          ),
                          Expanded(
                            child: Image(
                              image: NetworkImage('https://i.pinimg.com/originals/b9/9d/89/b99d89b52f8fdbb286cff6085fc95381.png'),
                            ),
                          ),
                          Expanded(
                            child: Image(
                              image: NetworkImage('https://i.pinimg.com/originals/b9/9d/89/b99d89b52f8fdbb286cff6085fc95381.png'),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 10,
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Add'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


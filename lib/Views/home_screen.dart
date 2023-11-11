import 'dart:convert';
import 'dart:developer';
import 'package:food_app/Model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_app/Views/recipeview.dart';
import 'package:food_app/Views/search.dart';

import 'package:http/http.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //search clr function
  void clearTextField() {
    setState(() {
      searchcontroller.clear();
    });
  }

  bool isloading = true;
  List<RecipeModel> recipeList = <RecipeModel>[];
  TextEditingController searchcontroller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List recipecatList = [
    {
      "imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db",
      "heading": "Chilli Food"
    },
    {
      "imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db",
      "heading": "Chilli Food"
    },
    {
      "imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db",
      "heading": "Chilli Food"
    },
    {
      "imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db",
      "heading": "Chilli Food"
    }
  ];
  getRecipe(String query) async {
    String url =
        'https://api.edamam.com/search?q=$query&app_id=ebb6041c&app_key=3c33ad913ab23b8554082bfb5fdd78b5';
    Response response = await get(Uri.parse(url));

    Map data = jsonDecode(response.body);
    //log(response.body.toString());
    data["hits"].forEach((element) {
      RecipeModel recipeModel = RecipeModel();
      recipeModel = RecipeModel.fromMap(element["recipe"]);
      recipeList.add(recipeModel);
      print(recipeList);
      setState(() {
        isloading = false;
      });
      log(recipeList.toString());
    });
    recipeList.forEach((Recipe) {});
  }

  @override
  void initState() {
    super.initState();
    getRecipe('Ladoo');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color.fromARGB(255, 83, 24, 24),
                Color.fromARGB(255, 0, 0, 0),

                // Color(0xff213A50),
                // Color(0xff071938),
              ])),
            ),
            //search bar
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 10),
                        height: 55,
                        width: 390,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if ((searchcontroller.text)
                                        .replaceAll(" ", "") ==
                                    "") {
                                  print('Blank Screen');
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Search(searchcontroller.text)));
                                }
                                setState(() {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  // searchcontroller.clear();
                                });
                                // clearTextField();
                              },
                              child: Container(
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.blueAccent,
                                    size: 33,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: TextField(
                                controller: searchcontroller,
                                focusNode: _focusNode,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Searching Food...'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'WHAT DO YOU WANT COOK TODAY?',
                            style: TextStyle(color: Colors.white, fontSize: 35),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'LET,S COOK SOMETHING NEW!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: isloading
                        ? const SpinKitDoubleBounce(
                            color: Colors.amber,
                            size: 70.0,
                          )
                        : ListView.builder(
                            keyboardDismissBehavior:
                                ScrollViewKeyboardDismissBehavior.onDrag,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: recipeList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RecipeView(
                                                recipeList[index].appurl,
                                              )));
                                },
                                child: Card(
                                  elevation: 0.0,
                                  margin: const EdgeInsets.all(8),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          recipeList[index].appimgUrl,
                                          fit: BoxFit.fill,
                                          width: double.infinity,
                                          height: 270,
                                        ),
                                      ),
                                      Positioned(
                                          left: 0,
                                          bottom: 0,
                                          right: 0,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              left: 0,
                                              right: 0,
                                            ),
                                            child: Container(
                                                decoration: const BoxDecoration(
                                                    color: Colors.black26),
                                                child: Center(
                                                  child: Text(
                                                    recipeList[index].applabel,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                )),
                                          )),
                                      Positioned(
                                          height: 40,
                                          width: 80,
                                          right: 0,
                                          child: Container(
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10))),
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Icon(Icons
                                                      .local_fire_department),
                                                  Text(recipeList[index]
                                                      .appcalories
                                                      .toString()
                                                      .substring(0, 6)),
                                                ],
                                              ),
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              );
                            }),
                  ),
                  Container(
                      height: 100,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: recipecatList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Search(
                                                recipecatList[index]["heading"],
                                              )));
                                },
                                child: Card(
                                  margin: const EdgeInsets.all(20),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  elevation: 0.0,
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: Image.network(
                                          recipecatList[index]["imgUrl"],
                                          fit: BoxFit.cover,
                                          height: 250,
                                          width: 200,
                                        ),
                                      ),
                                      Positioned(
                                          left: 0,
                                          right: 0,
                                          bottom: 0,
                                          top: 0,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 10),
                                            decoration: const BoxDecoration(
                                                color: Colors.black26),
                                            child: Column(
                                              children: [
                                                Text(
                                                  recipecatList[index]
                                                      ["heading"],
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                )
                                              ],
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:food_app/Model/model.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_app/Views/recipeview.dart';
import 'package:http/http.dart';

class Search extends StatefulWidget {
  String query;
  Search(this.query);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool isloading = true;
  List<RecipeModel> recipeList = <RecipeModel>[];
  //hiding keyboard
  FocusNode _focusNode = FocusNode();
  TextEditingController searchcontroller = TextEditingController();
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
    getRecipe(widget.query);
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
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Search(searchcontroller.text)));
                                }
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
                  Container(
                    child: isloading
                        ? const Center(
                            child: SpinKitDoubleBounce(
                              color: Colors.amber,
                              size: 70.0,
                            ),
                          )
                        : ListView.builder(
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:food_app/Model/model.dart';

class RecipeModel {
  late String applabel;
  late String appimgUrl;
  late double appcalories;
  late String appurl;
  RecipeModel(
      {this.applabel = 'Label',
      this.appcalories = 0.00,
      this.appimgUrl = 'imag',
      this.appurl = 'url'});
  factory RecipeModel.fromMap(Map recipe) {
    return RecipeModel(
      applabel: recipe['label'],
      appcalories: recipe['calories'],
      appimgUrl: recipe['image'],
      appurl: recipe['url'],
    );
  }
}

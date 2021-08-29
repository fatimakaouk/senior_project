import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:senior_project/classes/article.dart';
import 'package:senior_project/classes/disease.dart';
import 'package:senior_project/classes/insect.dart';
import 'package:senior_project/classes/note.dart';
import 'package:senior_project/classes/plant.dart';
import 'package:senior_project/classes/savedPlant.dart';
import 'package:senior_project/constants.dart';

class PlantService {
  Future<List<Plant>> getAllPlants() async {
    List<Plant> list;
    var response = await http.post(
      Uri.parse(host + "/getPlants"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 201) {
      var plants = json.decode(response.body)['plants'];
      list = Plant.getAllPlants(plants);
      return list;
    } else {
      Fluttertoast.showToast(
          msg: "Unexpected error has occured",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: kPrimaryColor,
          textColor: kPrimaryLightColor,
          fontSize: 16.0);
      return null;
    }
  }

  Future<List<SavedPlant>> getAllSavedPlants(int userid) async {
    List<SavedPlant> list;
    var response = await http.post(Uri.parse(host + "/getSavedPlants"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, int>{
          'userid': userid,
        }));
    if (response.statusCode == 201) {
      var plants = json.decode(response.body)['plants'];
      list = SavedPlant.getAllPlants(plants);
      return list;
    } else {
      Fluttertoast.showToast(
          msg: "Unexpected error has occured",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: kPrimaryColor,
          textColor: kPrimaryLightColor,
          fontSize: 16.0);
      return null;
    }
  }

  Future<Plant> getPlant(int idplant) async {
    Plant plant;
    var response = await http.post(Uri.parse(host + "/getPlant"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, int>{
          'plantid': idplant,
        }));
    if (response.statusCode == 201) {
      var result = json.decode(response.body)['plant'];
      plant = Plant.fromJson(result);
      return plant;
    } else {
      Fluttertoast.showToast(
          msg: "Unexpected error has occured",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: kPrimaryColor,
          textColor: kPrimaryLightColor,
          fontSize: 16.0);
      return null;
    }
  }

  Future<List<Article>> getArticles() async {
    List<Article> articles;
    var response = await http.post(
      Uri.parse(host + "/getArticles"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 201) {
      var articlesJson = json.decode(response.body)['articles'];
      articles = Article.getArticles(articlesJson);
      return articles;
    } else {
      Fluttertoast.showToast(
          msg: "Unexpected error has occured",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: kPrimaryColor,
          textColor: kPrimaryLightColor,
          fontSize: 16.0);
      return null;
    }
  }

  Future<List<Insect>> getRelatedInsects(int idplant) async {
    List<Insect> list;
    var response = await http.post(Uri.parse(host + "/getRelatedInsects"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, int>{
          'idplant': idplant,
        }));
    if (response.statusCode == 201) {
      var insectsJson = json.decode(response.body)['insects'];
      list = Insect.getInsects(insectsJson);
      return list;
    } else {
      Fluttertoast.showToast(
          msg: "Unexpected error has occured",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: kPrimaryColor,
          textColor: kPrimaryLightColor,
          fontSize: 16.0);
      return null;
    }
  }

  Future<List<Article>> getRelatedArticles(int idplant) async {
    List<Article> list;
    var response = await http.post(Uri.parse(host + "/getRelatedInsects"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, int>{
          'idplant': idplant,
        }));
    if (response.statusCode == 201) {
      var articlesJson = json.decode(response.body)['articles'];
      list = Article.getArticles(articlesJson);
      return list;
    } else {
      Fluttertoast.showToast(
          msg: "Unexpected error has occured",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: kPrimaryColor,
          textColor: kPrimaryLightColor,
          fontSize: 16.0);
      return null;
    }
  }

  Future<List<Disease>> getRelatedDiseases(int idplant) async {
    List<Disease> list;
    var response = await http.post(Uri.parse(host + "/getRelatedInsects"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, int>{
          'idplant': idplant,
        }));
    if (response.statusCode == 201) {
      var diseasesJson = json.decode(response.body)['diseases'];
      list = Disease.getDiseases(diseasesJson);
      return list;
    } else {
      Fluttertoast.showToast(
          msg: "Unexpected error has occured",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: kPrimaryColor,
          textColor: kPrimaryLightColor,
          fontSize: 16.0);
      return null;
    }
  }

  Future<bool> addToGarden(addedName, plantid, userid) async {
    var response = await http.post(Uri.parse(host + "/addToGarden"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'addedName': addedName,
          'plantid': plantid,
          'userid': userid,
        }));
    if (response.statusCode == 201) {
      //Map<String, dynamic> user = json.decode(response.body)['result'];
      return true;
    } else {
      Fluttertoast.showToast(
          msg: "Unexpected error has occured",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: kPrimaryColor,
          textColor: kPrimaryLightColor,
          fontSize: 16.0);
      return false;
    }
  }

  //TODO : create the schedule before adding note

  Future<bool> addNote(
      int idplant, String description, String imagePath,DateTime dateTime, int reminder, int scheduleid) async {}

  Future<int> addSchedule(
      DateTime startDate, int frequencyInterval, DateTime timeOfDay, DateTime endDate) async {}

  Future<List<Note>> getNotes(int savedplantid) async {

  }
}

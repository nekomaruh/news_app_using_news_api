import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_app/src/models/category_model.dart';
import 'package:news_app/src/models/news_models.dart';
import 'package:http/http.dart' as http;

final _URL_NEWS = 'https://newsapi.org/v2';
final _APIKEY= '2a8e9f6606f44d33af58536dd9721a18';

class NewsService with ChangeNotifier{
   List<Article> headLines = [];
   List<Category> categories = [
     Category(FontAwesomeIcons.building, 'business'),
     Category(FontAwesomeIcons.tv, 'entertainment'),
     Category(FontAwesomeIcons.addressCard, 'general'),
     Category(FontAwesomeIcons.vials, 'science'),
     Category(FontAwesomeIcons.volleyballBall, 'sports'),
     Category(FontAwesomeIcons.memory, 'technology')
   ];


   NewsService(){
     this.getTopHeadlines();
   }

   getTopHeadlines() async {
     print('cargando headlines...');
     final url = '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=ca';
     final respuesta = await http.get(url);

     final newsResponse = newsResponseFromJson(respuesta.body);

     this.headLines.addAll(newsResponse.articles);
     notifyListeners();

   }
}
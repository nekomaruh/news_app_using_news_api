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

   String _selectedCategory = 'business';

   Map<String, List<Article>> categoryArticles = {};


   NewsService(){
     this.getTopHeadlines();
     categories.forEach((item){
       this.categoryArticles[item.name] = new List();
     });
     this.getArticlesByCategory(this._selectedCategory);
   }

   get selectedCategory => this._selectedCategory;

   set selectedCategory(String valor){
     this._selectedCategory = valor;
     getArticlesByCategory(valor);
     notifyListeners();
   }

   List<Article> get getArticulosCategoriaSeleccionada => this.categoryArticles[this.selectedCategory];

   getTopHeadlines() async {
     final url = '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=us';
     final respuesta = await http.get(url);
     final newsResponse = newsResponseFromJson(respuesta.body);
     this.headLines.addAll(newsResponse.articles);
     notifyListeners();
   }

  getArticlesByCategory(String category) async {
    if(this.categoryArticles[category].length>0) return this.categoryArticles[category];
    final url = '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=us&category=$category';
    final respuesta = await http.get(url);
    final response = newsResponseFromJson(respuesta.body);
    this.categoryArticles[category].addAll(response.articles);
    notifyListeners();
  }

}
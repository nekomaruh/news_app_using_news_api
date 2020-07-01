import 'package:flutter/material.dart';
import 'package:news_app/src/models/category_model.dart';
import 'package:news_app/src/services/news_service.dart';
import 'package:news_app/src/theme/tema.dart';
import 'package:news_app/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return SafeArea(
          child: Scaffold(
          body: Column(
            children:[
              _ListaCategorias(),
              newsService.getArticulosCategoriaSeleccionada.length==0?
              Expanded(child: Center(child: CircularProgressIndicator(),)):
              Expanded(child: ListaNoticias(noticias: newsService.getArticulosCategoriaSeleccionada))
            ]
          ),
          

      ),
    );
  }
}

class _ListaCategorias extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final categories = Provider.of<NewsService>(context).categories;

    return Container(
      height: 80,
      child: ListView.builder(
        itemCount: categories.length,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, int index){
          return Container(
            width: 110,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children:[
                  _CategoryButton(categoria: categories[index]),
                  SizedBox(height: 5,),
                  Text('${categories[index].name[0].toUpperCase()}${categories[index].name.substring(1)}',)
                ]
              ),
            ),
          );
        }),
    );
  }
}

class _CategoryButton extends StatelessWidget {

  final Category categoria;
  const _CategoryButton({this.categoria});

  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context);

    return GestureDetector(
      onTap: (){
        newsService.selectedCategory = categoria.name;
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          shape: BoxShape.circle,
        ),
        child: Icon(categoria.icon, color: this.categoria.name == newsService.selectedCategory?
        miTema.accentColor: Colors.black54,)),
    );
  }
}
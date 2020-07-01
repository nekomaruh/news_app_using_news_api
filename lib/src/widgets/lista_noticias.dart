import 'package:flutter/material.dart';
import 'package:news_app/src/models/news_models.dart';
import 'package:news_app/src/theme/tema.dart';

class ListaNoticias extends StatelessWidget {
  final List<Article> noticias;
  const ListaNoticias({this.noticias});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: noticias.length,
      itemBuilder: (_, int index){
      return _Noticia(index: index, noticia: this.noticias[index],);
    });
  }
}

class _Noticia extends StatelessWidget {
  final Article noticia;
  final int index;

  const _Noticia({@required this.noticia, @required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 10,),
        _TarjetaTopBar(noticia: noticia, index: index,),
        _TarjetaTitulo(noticia: noticia),
        _TarjetaImagen(noticia: noticia),
        _TarjetaBody(noticia: noticia),
        _TarjetaBotones(),
        SizedBox(height: 10,),
        Divider(),
      ],
    );
  }
}

class _TarjetaBotones extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          RawMaterialButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            fillColor: miTema.accentColor,
            child: Icon(Icons.star_border, color: Colors.white,),
            onPressed: (){},),
            SizedBox(width: 10,),
          RawMaterialButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            fillColor: Colors.blue,
            child: Icon(Icons.more, color: Colors.white,),
            onPressed: (){},),
            SizedBox(width: 10,)
        ],
      )
    );
  }
}

class _TarjetaBody extends StatelessWidget {
  final Article noticia;
  const _TarjetaBody({this.noticia});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:15, vertical: 10),
      child: Text(noticia.description != null? noticia.description : '',),
    );
  }
}

class _TarjetaImagen extends StatelessWidget {
  final Article noticia;
  const _TarjetaImagen({this.noticia});
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        child: noticia.urlToImage==null? AssetImage('assets/img/no-image.png') : FadeInImage(
          placeholder: AssetImage('assets/img/giphy.gif'),
          image: NetworkImage(noticia.urlToImage),
      ),
        ),
    );
  }
}

class _TarjetaTitulo extends StatelessWidget {
  final Article noticia;
  const _TarjetaTitulo({this.noticia});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Text(noticia.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
    );
  }
}

class _TarjetaTopBar extends StatelessWidget {
  
  final Article noticia;
  final int index;
  const _TarjetaTopBar({this.noticia, this.index});
  

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: <Widget>[
           Text('${ index + 1}. ', style: TextStyle(color: miTema.accentColor),),
           Text('${noticia.source.name}. ',)
        ],
      ),
    );
  }
}
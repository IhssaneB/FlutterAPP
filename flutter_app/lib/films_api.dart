import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(ListMovie());
}

class ListMovie extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyList(title: ''),
    );
  }
}


class MyList extends StatefulWidget {
  MyList({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _MyList createState() => _MyList();

}

class Todo {
  final String title;
  final String description;

  Todo(this.title, this.description);
}

class _MyList extends State<MyList> {
  final String apiUrl = "https://api.themoviedb.org/3/movie/popular?api_key=17ee5559a57177a6d913c48d075db2e8";
  final String imageUrl = "https://image.tmdb.org/t/p/w500/";
  final String tvpop = "https://api.themoviedb.org/3/tv/popular?api_key=17ee5559a57177a6d913c48d075db2e8";
  final String best = "https://api.themoviedb.org/3/movie/top_rated?api_key=17ee5559a57177a6d913c48d075db2e8";



  Future<List<dynamic>> fetchPopTV() async {

    var resultpoptv = await http.get(tvpop);
    return json.decode(resultpoptv.body)['results'];

  }
  Future<List<dynamic>> fetchBest() async {

    var resultbest = await http.get(best);
    return json.decode(resultbest.body)['results'];

  }

  Future<List<dynamic>> fetchPopFilm() async {

    var result = await http.get(apiUrl);
    return json.decode(result.body)['results'];

  }

  String _title(dynamic film){
    return film['original_title'];

  }

  String _name(dynamic film){
    return film['name'];

  }
  String lienimg(dynamic film){
    return film['poster_path'];

  }

  String _overview(dynamic film){
    return film['overview'];
  }

  String _id(Map<dynamic, dynamic> film){
    return film['id'].toString();
  }
  double _vote_average(Map<dynamic, dynamic> film){
    return film['vote_average'];
  }

  double roundDouble(double value, int places){
    double mod = pow(10.00, places);
    return ((value * mod).round().toDouble() / mod);
  }

  @override
  Widget build(BuildContext context) {

    Widget text1 = new Container(
        margin: EdgeInsets.symmetric(vertical: 2),
        height: 20,
        width: 20,
        child: new Text(
          "Popular Movies",
          style: TextStyle(color:Colors.white),
        )
    );


    Widget horizontalList1 = new Container(
      padding: EdgeInsets.symmetric(horizontal: 3.0, vertical: 10.0),
      height: MediaQuery.of(context).size.height * 0.35,
      child: FutureBuilder<List<dynamic>>(
        future: fetchPopFilm(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                    return new GestureDetector( //You need to make my child interactive
                      onTap: () {
                        print(_id(snapshot.data[index]));
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(titre : _title(snapshot.data[index]), resume : _overview(snapshot.data[index]), img : imageUrl + lienimg(snapshot.data[index]),
                          note : roundDouble(_vote_average(snapshot.data[index]),2)/2, genres: _id(snapshot.data[index]))),
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Image.network(
                          imageUrl + lienimg(snapshot.data[index]),
                        ),
                    ),

                  );
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );


    Widget text2 = new Container(
        margin: EdgeInsets.symmetric(vertical: 2),
        height: 20,
        width: 20,
        child: new Text(
          "Popular TV Shows",
          style: TextStyle(color:Colors.white),
        )
    );


    Widget horizontalList2 = new Container(
      padding: EdgeInsets.symmetric(horizontal: 3.0, vertical: 10.0),
      height: MediaQuery.of(context).size.height * 0.35,
      child: FutureBuilder<List<dynamic>>(
        future: fetchPopTV(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return new GestureDetector( //You need to make my child interactive
                    onTap: () {
                      print(_id(snapshot.data[index]));
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(titre : _name(snapshot.data[index]), resume : _overview(snapshot.data[index]), img : imageUrl + lienimg(snapshot.data[index]),
                          note : roundDouble(_vote_average(snapshot.data[index]),2)/2, genres: _id(snapshot.data[index]))),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Image.network(
                        imageUrl + lienimg(snapshot.data[index]),
                      ),
                    ),

                  );
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );


    Widget text3 = new Container(
        margin: EdgeInsets.symmetric(vertical: 2),
        height: 20,
        width: 20,
        child: new Text(
          "Best Movies",
          style: TextStyle(color:Colors.white),
        )
    );


    Widget horizontalList3 = new Container(
      padding: EdgeInsets.symmetric(horizontal: 3.0, vertical: 10.0),
      height: MediaQuery.of(context).size.height * 0.35,
      child: FutureBuilder<List<dynamic>>(
        future: fetchBest(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return new GestureDetector( //You need to make my child interactive
                      onTap: () {
                        print(_id(snapshot.data[index]));
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(titre : _title(snapshot.data[index]), resume : _overview(snapshot.data[index]), img : imageUrl + lienimg(snapshot.data[index]),
                            note : roundDouble(_vote_average(snapshot.data[index]),2)/2, genres: _id(snapshot.data[index]))),
                        );
                      },
                  child : Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Image.network(
                      imageUrl + lienimg(snapshot.data[index]),
                    ),
                  ));
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );


    return new Scaffold(
      backgroundColor: Colors.black,
      body: new Center(
        child: new Container(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              text1,
              horizontalList1,
              text2,
              horizontalList2,
              text3,
              horizontalList3,
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
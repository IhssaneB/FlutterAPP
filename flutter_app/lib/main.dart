import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:cupertino_back_gesture/cupertino_back_gesture.dart';
import 'package:like_button/like_button.dart';



void main() {runApp(MyApp());}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Demo'),
    );

  }
}

class StarDisplay extends StatelessWidget {
  final double value;
  const StarDisplay({Key key, this.value = 0.00})
      : assert(value != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < value ? Icons.star : Icons.star_border,
        );
      }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title,this.titre,this.resume,this.img, this.note, this.genres}) : super(key: key);

  final String titre;
  final String resume;
  final String img;
  final String title;
  final String genres;
  final double note;




  @override
  _MyHomePageState createState() => _MyHomePageState();
}




class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    String genre = "https://api.themoviedb.org/3/movie/"+widget.genres+"?api_key=17ee5559a57177a6d913c48d075db2e8";
    String cast = "https://api.themoviedb.org/3/movie/"+widget.genres+"/casts?api_key=17ee5559a57177a6d913c48d075db2e8";


    Future<List<dynamic>> fetchGenre() async {
      var resultGenre = await http.get(genre);
      return json.decode(resultGenre.body)['genres'];

    }
    Future<List<dynamic>> fetchCast() async {
      var resultCast = await http.get(cast);
      return json.decode(resultCast.body)['cast'];

    }

    String _id(dynamic film){
      return film['id'];

    }
    String _name(dynamic film){
      return film['name'];

    }

    return Scaffold(
      extendBodyBehindAppBar: true,


      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.3),
        elevation: 10.0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon:Icon(Icons.arrow_back, color: Colors.white,)

    )
      ),

      body: Stack(
        children:[
          Image.network(widget.img,
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter,
          ),

          Container(

            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: [0.45,0.65],
                    colors: [Colors.black, Colors.transparent]
                )
            ),
            child: Column(
              children: [

                Padding(
                  padding: EdgeInsets.only(top: 350),
                  child: Text(
                    widget.titre,
                        style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(),
                    child: IconTheme(
                      data: IconThemeData(
                        color: Colors.amber,
                        size: 15,
                      ),
                      child: StarDisplay(value: widget.note),
                    ),
                ),
                SizedBox(
                  width: 20,
                  height: 20,
                ),

                FutureBuilder<List<dynamic>>(
                  future: fetchGenre(),
                  builder: (BuildContext context, AsyncSnapshot snapshot1) {
                    if (snapshot1.hasData) {

                      return SizedBox(
                          height: 40.0,
                          child: new ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot1.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return new SizedBox(
                              child: Text(
                                _name(snapshot1.data[index])+", ",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            );
                          }));

                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                SizedBox(
                  child: Text(
                  "Casting : ",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),

                ),

                FutureBuilder<List<dynamic>>(
                  future: fetchCast(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return SizedBox(
                          height: 40.0,
                          child: new ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return new Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    _name(snapshot.data[index])+",  ",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              }));


                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),

                SizedBox(
                  width: 20,
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 0),
                  child: Text(
                    widget.resume, overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                    style: TextStyle(
                      height: 1,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),


                SizedBox(
                  width: 20,
                  height: 50,
                ),

                LikeButton(
                  size: 40,
                  circleColor:
                  CircleColor(start: Color(0xffb30000), end: Color(0xffff0000)),
                  bubblesColor: BubblesColor(
                    dotPrimaryColor: Color(0xffffd700),
                    dotSecondaryColor: Color(0xffffff00),
                  ),

                  likeBuilder: (bool isLiked) {
                    return Icon(
                      Icons.favorite,
                      color: isLiked ? Colors.redAccent : Colors.grey,
                      size: 40,
                    );
                  },
                  likeCount: 68,
                  countBuilder: (int count, bool isLiked, String text) {
                    Widget result;

                    return result;
                  },
                ),
              ],
            ),
          )
        ],
        fit: StackFit.expand,
      ),

    );
  }
}
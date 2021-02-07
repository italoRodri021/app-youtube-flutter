import 'package:app_youtube_flutter/bloc/favorite_bloc.dart';
import 'package:app_youtube_flutter/bloc/video_bloc.dart';
import 'package:app_youtube_flutter/delegates/data_search.dart';
import 'package:app_youtube_flutter/model/video.dart';
import 'package:app_youtube_flutter/tiles/video_tile.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import 'favorites_screen.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final bloc = BlocProvider.of<VideosBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 25.0,
          child: Image.asset("images/ic_youtube.png"),
        ),
        elevation: 0,
        backgroundColor: Colors.black,
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: StreamBuilder<Map<String, Video>>(
              initialData: {},
              stream: BlocProvider.of<FavoriteBloc>(context).outFav,
              builder: (context, snnapshot){
                if(snnapshot.hasData) return Text("${snnapshot.data.length}");
                else return Container();
              }
            ),
          ),
          IconButton(icon: Icon(Icons.star),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>Favorites()));
              }
          ),
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                String result = await showSearch(
                    context: context, delegate: DataSearch());
                if (result != null) bloc.inSearch.add(result);
              }
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: StreamBuilder(
        stream: BlocProvider.of<VideosBloc>(context).outVideos,
        builder: (context, snapshot) {

          if(snapshot.hasData)
          return ListView.builder(
              itemBuilder: (context, index){

                if(index < snapshot.data.length){
                  return VideoTile(snapshot.data[index]); 
                }else if (index > 1){
                  bloc.inSearch.add(null);
                  return Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.red)),
                  );
                }else{
                  return Container();
                }
              },
            itemCount: snapshot.data.length + 1,
          );
        else
          return Container();
          },
      ),
    );
  }
}

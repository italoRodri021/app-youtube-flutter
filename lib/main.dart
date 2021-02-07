import 'package:app_youtube_flutter/bloc/favorite_bloc.dart';
import 'package:app_youtube_flutter/bloc/video_bloc.dart';
import 'package:app_youtube_flutter/screens/home_screen.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import 'api/api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: VideosBloc(context),
        child: BlocProvider(
          bloc: FavoriteBloc(),
          child: MaterialApp(
            title: "YouTube",
            debugShowCheckedModeBanner: false,
            home: Home(),
          ),
        )
    );
  }
}

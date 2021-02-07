import 'dart:async';
import 'file:///C:/Users/italo/AndroidStudioProjects/app_youtube_flutter/lib/api/api.dart';
import 'package:app_youtube_flutter/model/video.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/src/widgets/framework.dart';

class VideosBloc implements BlocBase {
  Api api;
  List<Video> videos;

  final StreamController<List<Video>> _videoController = StreamController<List<Video>>();
  Stream get outVideos => _videoController.stream;

  final StreamController<String> _seachController = StreamController<String>();
  Sink get inSearch => _seachController.sink;

  VideosBloc(BuildContext context) {
    api = Api();

    _seachController.stream.listen(_search);
  }

  void _search(String search) async {

    if(search != null){
      _videoController.sink.add([]);
      videos = await api.search(search);
    }else{
      videos += await api.nextPage();
    }
      _videoController.sink.add(videos);
  }

  @override
  void dispose() {
    _videoController.close();
    _seachController.close();
  }
}

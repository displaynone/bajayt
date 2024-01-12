import 'package:bajayt/redux/app_state.dart';
import 'package:bajayt/src/views/videos/list_videos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class SearchVideos extends StatefulWidget {
  const SearchVideos({super.key});

  @override
  State<SearchVideos> createState() => _SearchVideosState();
}

class _SearchVideosState extends State<SearchVideos> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, bool>(
      converter: (store) => store.state.loading,
      builder: (context, loading) {
        var content = loading
            ? Container(
                padding: const EdgeInsets.all(32),
                child: const CircularProgressIndicator(
                  color: Colors.white70,
                ))
            : const ListVideos();

        return content;
      },
    );
  }
}

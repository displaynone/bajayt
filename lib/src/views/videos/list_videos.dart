import 'package:bajayt/redux/app_state.dart';
import 'package:bajayt/src/views/videos/video_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class ListVideos extends StatefulWidget {
  const ListVideos({super.key});

  @override
  State<ListVideos> createState() => _ListVideosState();
}

class _ListVideosState extends State<ListVideos> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<Video>>(
      converter: (store) => store.state.searchListVideos,
      builder: (context, videos) {
        if (videos.isEmpty) {
          return const Text('Vacio');
        }

        return Expanded(
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                constraints: const BoxConstraints(maxWidth: 1024),
                child: LayoutBuilder(builder: (context, constraints) {
                  int crossAxisCount = constraints.maxWidth < 560 ? 2 : 3;

                  return AlignedGridView.count(
                      itemCount: videos.length,
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 32,
                      mainAxisSpacing: 32,
                      itemBuilder: (context, index) {
                        return VideoItem(video: videos[index]);
                      });
                })));
      },
    );
  }
}

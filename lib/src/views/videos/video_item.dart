import 'package:bajayt/src/views/videos/downloader_dialog.dart';
import 'package:flutter/material.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class VideoItem extends StatefulWidget {
  const VideoItem({super.key, required this.video});

  final Video video;

  @override
  State<VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  void _showDownloadOptions(BuildContext context) {
    final yt = YoutubeExplode();

    yt.videos.streamsClient.getManifest(widget.video.id).then((manifest) {
      final videoStreams = manifest.muxed;
      final audioStreams = manifest.audioOnly;

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return DownloaderDialog(
              videoStreams: videoStreams,
              audioStreams: audioStreams,
              title: widget.video.title);
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 120 / 90,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(5), // Ajusta el radio aquí
            child: Container(
                constraints: const BoxConstraints(minHeight: 200),
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.white10, blurStyle: BlurStyle.outer)
                    ],
                    image: DecorationImage(
                        image: NetworkImage(
                          widget.video.thumbnails.highResUrl,
                        ),
                        fit: BoxFit.cover)),
                child: Container(
                    decoration: const BoxDecoration(color: Colors.black38),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                widget.video.title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    fontSize: 16),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              )),
                          Container(
                              alignment: AlignmentDirectional.topEnd,
                              child: IconButton(
                                  onPressed: () =>
                                      _showDownloadOptions(context),
                                  icon: const Icon(Icons.download,
                                      size: 40, color: Colors.white70))),
                        ])))));
  }
}

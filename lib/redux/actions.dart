import 'dart:io';

import 'package:bajayt/redux/app_state.dart';
import 'package:redux/redux.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import 'package:process_run/process_run.dart' as pr;

class UpdateSearchString {
  final String searchString;

  UpdateSearchString(this.searchString);
}

class AddYoutubeVideo {
  final SearchVideo video;

  AddYoutubeVideo(this.video);
}

class UpdateDownloadPercentage {
  final double percentage;
  final String url;
  final String title;

  UpdateDownloadPercentage(
      {required this.percentage, required this.url, required this.title});
}

class UpdateSearchListVideos {
  final List<Video> listVideos;

  UpdateSearchListVideos(this.listVideos);
}

class UpdateLoading {
  final bool loading;

  UpdateLoading(this.loading);
}

class DownloadVideoAction {
  final StreamInfo streamInfo;
  final String filePath;

  DownloadVideoAction(this.streamInfo, this.filePath);
}

Future<void> downloadVideo(
    Store<AppState> store, StreamInfo streamInfo, String filePath) async {
  var yt = YoutubeExplode();
  var stream = yt.videos.streamsClient.get(streamInfo);

  var file = File(filePath);
  var fileStream = file.openWrite();

  int totalBytes = streamInfo.size.totalBytes;
  int downloadedBytes = 0;

  // await stream.pipe(fileStream);
  await for (var data in stream) {
    fileStream.add(data);
    downloadedBytes += data.length;

    double progress = downloadedBytes / totalBytes;
    store.dispatch(UpdateDownloadPercentage(
        url: streamInfo.url.toString(), percentage: progress, title: filePath));
  }

  await fileStream.flush();
  await fileStream.close();

  yt.close();

  if (streamInfo is! MuxedStreamInfo) {
    String command = 'ffmpeg -i "$filePath" -vn "$filePath.mp3"';
    List<ProcessResult> result = await pr.run(command, verbose: true);
    if (result[0].exitCode != 0) {
      throw 'Conversion error: ${result[0].stderr}';
    }
  }
}

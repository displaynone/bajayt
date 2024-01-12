import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class StreamDownloadPercentage {
  String url;
  String title;
  double percentage;

  StreamDownloadPercentage(
      {required this.url, required this.percentage, required this.title});

  StreamDownloadPercentage clone() {
    return StreamDownloadPercentage(
        url: url, percentage: percentage, title: title);
  }
}

class AppState {
  final String searchString;
  final List<SearchVideo> downloadVideos;
  final List<Video> searchListVideos;
  final List<StreamDownloadPercentage> downloadPercentage;
  final bool loading;

  AppState({
    this.searchString = '',
    this.downloadVideos = const [],
    this.searchListVideos = const [],
    this.downloadPercentage = const [],
    this.loading = false,
  });

  // Método para actualizar el estado
  AppState copyWith({
    String? searchString,
    List<SearchVideo>? downloadVideos,
    List<Video>? searchListVideos,
    List<StreamDownloadPercentage>? downloadPercentage,
    bool? loading,
  }) {
    return AppState(
      searchString: searchString ?? this.searchString,
      downloadVideos: downloadVideos ?? this.downloadVideos,
      searchListVideos: searchListVideos ?? this.searchListVideos,
      downloadPercentage: downloadPercentage ?? this.downloadPercentage,
      loading: loading ?? this.loading,
    );
  }
}

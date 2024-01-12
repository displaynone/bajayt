import 'package:bajayt/redux/actions.dart';
import 'package:bajayt/redux/app_state.dart';

AppState appReducer(AppState state, dynamic action) {
  if (action is UpdateSearchString) {
    return state.copyWith(searchString: action.searchString);
  } else if (action is AddYoutubeVideo) {
    return state.copyWith(
        downloadVideos: List.from(state.downloadVideos)..add(action.video));
  } else if (action is UpdateDownloadPercentage) {
    List<StreamDownloadPercentage> percentages =
        state.downloadPercentage.map((element) => element.clone()).toList();
    if (percentages.where((element) => element.url == action.url).isEmpty) {
      percentages.add(StreamDownloadPercentage(
          url: action.url, percentage: action.percentage, title: action.title));
    } else {
      percentages
          .where((element) => element.url == action.url)
          .forEach((element) {
        element.percentage = action.percentage;
      });
    }
    return state.copyWith(downloadPercentage: percentages);
  } else if (action is UpdateSearchListVideos) {
    return state.copyWith(searchListVideos: action.listVideos);
  } else if (action is UpdateLoading) {
    return state.copyWith(loading: action.loading);
  } else if (action is DownloadVideoAction) {
    return state;
  }

  return state;
}

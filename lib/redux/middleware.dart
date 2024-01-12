import 'dart:async';

import 'package:async/async.dart';
import 'package:bajayt/redux/actions.dart';
import 'package:bajayt/redux/app_state.dart';
import 'package:redux/redux.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class SearchMiddleware implements MiddlewareClass<AppState> {
  final YoutubeExplode api;

  Timer? _timer;
  CancelableOperation<Store<AppState>>? _operation;

  SearchMiddleware(this.api);

  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) {
    if (action is UpdateSearchString) {
      _timer?.cancel();
      _operation?.cancel();

      _timer = Timer(const Duration(milliseconds: 250), () {
        if (action.searchString.isNotEmpty && !store.state.loading) {
          store.dispatch(UpdateLoading(true));

          _operation = CancelableOperation.fromFuture(api
              .search(action.searchString)
              .then((result) {
            store.dispatch(UpdateLoading(false));
            return store..dispatch(UpdateSearchListVideos(result.toList()));
          }).catchError((Object e, StackTrace s) =>
                  store..dispatch(UpdateLoading(false))));
        }
      });
    }

    next(action);
  }
}

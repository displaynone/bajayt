import 'package:bajayt/redux/app_state.dart';
import 'package:bajayt/redux/middleware.dart';
import 'package:bajayt/redux/redurecrs.dart';
import 'package:bajayt/src/views/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
// import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  final store = Store<AppState>(
    appReducer,
    initialState: AppState(),
    middleware: [
      // The following middleware both achieve the same goal: Load search
      // results from github in response to SearchActions.
      //
      // One is implemented as a normal middleware, the other is implemented as
      // an epic for demonstration purposes.

      SearchMiddleware(YoutubeExplode()).call,
      // EpicMiddleware<SearchState>(SearchEpic(GithubClient())),
    ],
  );

  App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store,
        child: MaterialApp(
          title: 'Baja YT',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.green,
            fontFamily: 'Inter',
          ),
          home: const HomePage(title: 'Baja YouTube'),
        ));
  }
}

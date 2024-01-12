import 'package:bajayt/src/views/home/download_status.dart';
import 'package:bajayt/src/views/home/search_result.dart';
import 'package:bajayt/src/views/home/search_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF5C94B3), // Color en formato ARGB hexadecimal
              Color(0xFF152135),
            ],
          ),
        ),
        child: const Center(
            child: Column(children: <Widget>[
          SearchBarWidget(),
          SearchVideos(),
          DownloadStatusWidget()
        ])),
      ),
    );
  }
}

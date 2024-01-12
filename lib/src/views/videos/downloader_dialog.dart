import 'package:bajayt/redux/actions.dart';
import 'package:bajayt/redux/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:path_provider/path_provider.dart';
import 'package:redux/redux.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class DownloaderDialogItem {
  bool isSelected;
  MuxedStreamInfo? videoStream;
  AudioOnlyStreamInfo? audioStream;

  DownloaderDialogItem(
      {required this.isSelected, this.videoStream, this.audioStream});
}

class DownloaderDialog extends StatefulWidget {
  const DownloaderDialog(
      {super.key,
      required this.videoStreams,
      required this.audioStreams,
      required this.title});

  final List<MuxedStreamInfo> videoStreams;
  final List<AudioOnlyStreamInfo> audioStreams;
  final String title;

  @override
  State<DownloaderDialog> createState() => _DownloaderDialogState();
}

class _DownloaderDialogState extends State<DownloaderDialog> {
  List<DownloaderDialogItem> isSelected = [];

  @override
  void initState() {
    super.initState();
    isSelected = [
      ...widget.videoStreams.map((stream) =>
          DownloaderDialogItem(videoStream: stream, isSelected: false)),
      ...widget.audioStreams.map((stream) =>
          DownloaderDialogItem(audioStream: stream, isSelected: false))
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: const RoundedRectangleBorder(),
      title: Text('Descarga ${widget.title}', maxLines: 2),
      children: <Widget>[
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Selecciona los formatos que deseas descargar',
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 16),
                  const SizedBox(height: 16),
                  SizedBox(
                      height: 260,
                      width: 400,
                      child: ListView.builder(
                          itemCount: isSelected.length,
                          itemBuilder: (context, index) {
                            final stream = (isSelected[index].videoStream ??
                                isSelected[index].audioStream) as StreamInfo;
                            String title = stream is MuxedStreamInfo
                                ? '🎞️ ${stream.qualityLabel} (${stream.size}) - ${stream.container}'
                                : '🎵 ${stream.bitrate} (${stream.size}) - ${stream.container}';
                            return CheckboxListTile(
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                value: isSelected[index].isSelected,
                                onChanged: (value) {
                                  setState(() => isSelected[index].isSelected =
                                      !isSelected[index].isSelected);
                                },
                                title: Text(title));
                          })),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 8),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color(0xFF5C94B3))),
                              child: const Text('Descargar',
                                  style: TextStyle(color: Colors.white)),
                              onPressed: () {
                                isSelected
                                    .where((element) => element.isSelected)
                                    .forEach((stream) {
                                  getDownloadsDirectory()
                                      .then((downloadDirectory) {
                                    if (downloadDirectory != null) {
                                      StreamInfo downloadableStream =
                                          (stream.videoStream ??
                                              stream.audioStream) as StreamInfo;
                                      Store<AppState> store =
                                          StoreProvider.of<AppState>(context);
                                      store.dispatch(downloadVideo(
                                          store,
                                          downloadableStream,
                                          '${downloadDirectory.path}/${widget.title}_${downloadableStream.qualityLabel}_${downloadableStream.hashCode}.${downloadableStream.container}'));
                                    }
                                  });
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white)),
                              child: const Text('Cancelar',
                                  style: TextStyle(
                                    color: Color(0xFF152135),
                                  )),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ]))
                ])),
      ],
    );
  }
}

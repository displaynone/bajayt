import 'package:bajayt/redux/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class DownloadStatusWidget extends StatefulWidget {
  const DownloadStatusWidget({super.key});

  @override
  State<DownloadStatusWidget> createState() => _DownloadStatusWidgetState();
}

class _DownloadStatusWidgetState extends State<DownloadStatusWidget> {
  bool expanded = true;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          if (state.downloadPercentage.isEmpty) {
            return const SizedBox();
          }
          return SizedBox(
              height: expanded ? 250 : 40,
              child: Stack(children: <Widget>[
                Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                        height: expanded ? 250 : 40,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16))),
                        padding: const EdgeInsets.only(
                            top: 0, left: 32, right: 32, bottom: 0),
                        child: Column(
                          children: <Widget>[
                            IconButton(
                                onPressed: () =>
                                    setState(() => expanded = !expanded),
                                icon: expanded
                                    ? const Icon(Icons.arrow_downward)
                                    : const Icon(Icons.arrow_upward)),
                            !expanded
                                ? const SizedBox()
                                : SizedBox(
                                    width: double.infinity,
                                    height: 178,
                                    child: ListView.builder(
                                      itemCount:
                                          state.downloadPercentage.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(state
                                                  .downloadPercentage[index]
                                                  .title),
                                              LinearProgressIndicator(
                                                value: state
                                                    .downloadPercentage[index]
                                                    .percentage,
                                                backgroundColor:
                                                    Colors.grey[200],
                                                valueColor:
                                                    const AlwaysStoppedAnimation<
                                                        Color>(Colors.blue),
                                              ),
                                              const SizedBox(
                                                height: 16,
                                              ),
                                            ]);
                                      },
                                    ),
                                  )
                          ],
                        )))
              ]));
        });
  }
}

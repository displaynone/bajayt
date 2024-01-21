import 'package:bajayt/redux/actions.dart';
import 'package:bajayt/redux/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 32, right: 32, top: 32),
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            margin: const EdgeInsets.only(bottom: 32),
            constraints: const BoxConstraints(maxWidth: 768),
            decoration: BoxDecoration(
              color: Colors.white, // Fondo blanco
              borderRadius: BorderRadius.circular(25), // Radio del borde
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: <Widget>[
                Image.asset(
                  'assets/images/logo.png',
                  width: 32,
                ),
                Expanded(
                    child: StoreConnector<AppState, AppState>(
                        converter: (store) => store.state,
                        builder: (context, count) {
                          return TextField(
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!.search,
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 10),
                            ),
                            onChanged: (value) {
                              StoreProvider.of<AppState>(context)
                                  .dispatch(UpdateSearchString(value));
                            },
                          );
                        })),
                const Icon(Icons.search),
              ],
            )));
  }
}

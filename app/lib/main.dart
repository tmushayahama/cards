import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cards_repository_simple/cards_repository_simple.dart';
import 'package:cards_app_core/cards_app_core.dart';
import 'package:flutter_cards/localization.dart';
import 'package:flutter_cards/blocs/blocs.dart';
import 'package:flutter_cards/models/models.dart' as App;
import 'package:flutter_cards/screens/screens.dart';

void main() {
  // BlocSupervisor oversees Blocs and delegates to BlocDelegate.
  // We can set the BlocSupervisor's delegate to an instance of `SimpleBlocDelegate`.
  // This will allow us to handle all transitions and errors in SimpleBlocDelegate.
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(CardsApp());
}

class CardsApp extends StatelessWidget {
  final cardsBloc = CardsBloc(
    cardsRepository: const CardsRepositoryFlutter(
      fileStorage: const FileStorage(
        '__flutter_bloc_app__',
        getApplicationDocumentsDirectory,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: cardsBloc,
      child: MaterialApp(
        title: FlutterBlocLocalizations().appTitle,
        theme: ArchSampleTheme.theme,
        localizationsDelegates: [
          ArchSampleLocalizationsDelegate(),
          FlutterBlocLocalizationsDelegate(),
        ],
        routes: {
          ArchSampleRoutes.home: (context) {
            return HomeScreen(
              onInit: () => cardsBloc.dispatch(LoadCards()),
            );
          },
          ArchSampleRoutes.addCard: (context) {
            return AddEditScreen(
              key: ArchSampleKeys.addCardScreen,
              onSave: (task, note) {
                cardsBloc.dispatch(
                  AddCard(App.Card(task, note: note)),
                );
              },
              isEditing: false,
            );
          },
        },
      ),
    );
  }
}

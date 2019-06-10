import 'package:flutter/material.dart';
import 'package:cards_app_core/cards_app_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cards/blocs/blocs.dart';
import 'package:flutter_cards/widgets/widgets.dart';
import 'package:flutter_cards/localization.dart';
import 'package:flutter_cards/models/models.dart';

class HomeScreen extends StatefulWidget {
  final void Function() onInit;

  HomeScreen({@required this.onInit}) : super(key: ArchSampleKeys.homeScreen);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TabBloc _tabBloc = TabBloc();
  FilteredCardsBloc _filteredCardsBloc;
  StatsBloc _statsBloc;

  @override
  void initState() {
    widget.onInit();
    _filteredCardsBloc = FilteredCardsBloc(
      cardsBloc: BlocProvider.of<CardsBloc>(context),
    );
    _statsBloc = StatsBloc(
      cardsBloc: BlocProvider.of<CardsBloc>(context),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _tabBloc,
      builder: (BuildContext context, AppTab activeTab) {
        return BlocProviderTree(
          blocProviders: [
            BlocProvider<TabBloc>(bloc: _tabBloc),
            BlocProvider<FilteredCardsBloc>(bloc: _filteredCardsBloc),
            BlocProvider<StatsBloc>(bloc: _statsBloc),
          ],
          child: Scaffold(
            appBar: AppBar(
              title: Text(FlutterBlocLocalizations.of(context).appTitle),
              actions: [
                FilterButton(visible: activeTab == AppTab.cards),
                ExtraActions(),
              ],
            ),
            body: activeTab == AppTab.cards ? FilteredCards() : Stats(),
            floatingActionButton: FloatingActionButton(
              key: ArchSampleKeys.addCardFab,
              onPressed: () {
                Navigator.pushNamed(context, ArchSampleRoutes.addCard);
              },
              child: Icon(Icons.add),
              tooltip: ArchSampleLocalizations.of(context).addCard,
            ),
            bottomNavigationBar: TabSelector(
              activeTab: activeTab,
              onTabSelected: (tab) => _tabBloc.dispatch(UpdateTab(tab)),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _statsBloc.dispose();
    _filteredCardsBloc.dispose();
    _tabBloc.dispose();
    super.dispose();
  }
}

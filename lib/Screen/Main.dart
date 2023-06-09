import '../Provider/NavProvider.dart';
import '../Widgets/floatingMusicPlayer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavProvider>(context);
    final _page = navProvider.page;
    var _activeIndex = navProvider.activeIndex;
    return Scaffold(
      body: _page[_activeIndex]['page'],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _activeIndex,
        destinations: [
          ..._page
              .map(
                (e) => NavigationDestination(
                  icon: Icon(e['icon']),
                  selectedIcon: Icon(e['active_icon']),
                  label: e['name'],
                ),
              )
              .toList(),
        ],
        onDestinationSelected: (value) {
          navProvider.changeIndex(value);
        },
      ),
      floatingActionButton: _page[_activeIndex]['is_have_music_player'] ? FloatingMusicPlayer() : Container(),
    );
  }
}

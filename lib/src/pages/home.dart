import 'package:flutter/material.dart';
import 'package:ytmusic/src/services.dart';
import 'package:ytmusic/src/widgets/playlist_manager.dart';

import '../widgets/side_menu.dart';

/// Página inicial.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SideMenu(
      title: Text(local(context).homePageTitle),
      child: PlaylistManager(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ytmusic/src/services.dart';
import 'package:ytmusic/src/widgets/body_progress.dart';
import 'package:ytmusic/src/widgets/playlists_view.dart';
import 'package:ytmusic/src/ytmusic_api/dart_ytmusic_api.dart';

class AddPlaylistPage extends StatelessWidget {
  const AddPlaylistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Playlist'),
      ),
      body: const AddPlaylistForm(),
    );
  }
}

class AddPlaylistForm extends StatefulWidget {
  const AddPlaylistForm({super.key});

  @override
  State<AddPlaylistForm> createState() => _AddPlaylistFormState();
}

class _AddPlaylistFormState extends State<AddPlaylistForm> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  Future<PlaylistFull?>? _playlist;
  final List<PlaylistFull> _list = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _list.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _playlist,
      builder: (BuildContext context, AsyncSnapshot<PlaylistFull?> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            final play = snapshot.data as PlaylistFull;
            if (!_list.contains(play)) {
              _list.add(play);
            }
            SchedulerBinding.instance.addPostFrameCallback((tm) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Playlist successfully added.'),
                  backgroundColor: Colors.green,
                ),
              );
            });
          } else {
            SchedulerBinding.instance.addPostFrameCallback((tm) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('The playlist was not found or an error occurred while retrieving it. Check if the URL or playlist ID is correct.'),
                  backgroundColor: Colors.red,
                ),
              );
            });
          }
        }
        return BodyProgress(
          state: snapshot.connectionState,
          child: AddPlayListBody(
            formKey: _formKey,
            playLists: _list,
            onPressed: _addPlayList,
          ),
        );
      },
    );
  }

  void _addPlayList() {
    final isValid = _formKey.currentState?.saveAndValidate() ?? false;
    if (isValid) {
      setState(() {
        _playlist = Services.music.addPlaylist(_formKey.currentState!.fields['playlist_id']!.value!.toString());
      });
    }
  }
}

class AddPlayListBody extends StatelessWidget {
  const AddPlayListBody({
    super.key,
    this.onPressed,
    required this.playLists,
    required GlobalKey<FormBuilderState> formKey,
  }) : _formKey = formKey;

  final List<PlaylistFull> playLists;
  final VoidCallback? onPressed;
  final GlobalKey<FormBuilderState> _formKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FormBuilder(
          key: _formKey,
          initialValue: const {
            'playlist_id': 'PLqUpluuk47ROmVDynnfNsuYUuCQIumqLE',
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: FormBuilderTextField(
                  name: 'playlist_id',
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter the playlist ID or URL',
                  ),
                  validator: FormBuilderValidators.required(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Align(
                  alignment: Alignment.center,
                  child: FilledButton.icon(
                    onPressed: onPressed,
                    label: const Text('Add'),
                    icon: const Icon(Icons.add),
                  ),
                ),
              ),
            ],
          ),
        ),
        PlaylistsView(playLists: playLists),
      ],
    );
  }
}

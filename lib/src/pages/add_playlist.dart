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
        title: Text(local(context).addPlaylistPageTitle),
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
  bool _changed = false;

  @override
  void dispose() {
    _changed = false;
    _list.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Future.delayed(Duration.zero, () {
            if (context.mounted) {
              Navigator.pop(context, _changed);
            }
          });
        }
      },
      child: FutureBuilder(
        future: _playlist,
        builder: (BuildContext context, AsyncSnapshot<PlaylistFull?> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final play = snapshot.data as PlaylistFull;
              if (!_list.contains(play)) {
                _list.add(play);
                _changed = true;
              }
              SchedulerBinding.instance.addPostFrameCallback((tm) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(local(context).playlistAdded),
                    backgroundColor: Colors.green,
                  ),
                );
              });
            } else {
              SchedulerBinding.instance.addPostFrameCallback((tm) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(local(context).playlistNotFoundOrError),
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
      ),
    );
  }

  void _addPlayList() {
    final isValid = _formKey.currentState?.saveAndValidate() ?? false;
    if (isValid) {
      setState(() {
        _playlist = Services.music
            .addPlaylist(_formKey.currentState!.fields['playlist_id']!.value!.toString()) //
            .then((val) {
          if (val != null) {
            _formKey.currentState?.reset();
          }
          return val;
        });
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: FormBuilderTextField(
                  name: 'playlist_id',
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: local(context).enterPlaylistId,
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
                    label: Text(local(context).addLabel),
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

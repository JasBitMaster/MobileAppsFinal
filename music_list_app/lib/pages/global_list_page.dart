import 'package:flutter/material.dart';
import 'package:music_list_app/pages/opening_page.dart';

import '../model/track.dart';
import '../services/my_controller.dart';
import '../utils/date_time_converter.dart';
import 'user_list_page.dart';

class GlobalListPage extends StatefulWidget {
  @override
  _GlobalListPageState createState() => _GlobalListPageState();
}

class _GlobalListPageState extends State<GlobalListPage> {
  List<Track> _tracks = [];

  @override
  void initState() {
    super.initState();
    _getTracks();
  }

  Future<void> _getTracks() async {
    MyController.getTracks().then((value) {
      setState(() {
        _tracks = value;
      });
    });
  }

  var _listAscendingTitle = true;
  var _listAscendingArtist = true;
  var _listAscendingAlbum = true;
  var _listAscendingRuntime = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              ListTile(
                title: Text('Log out'),
                onTap: () {
                  MyController.signOut();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => OpeningPage()),
                      (route) => false);
                },
              ),
              ListTile(
                title: Text('Sort - Title'),
                onTap: () {
                  _listAscendingTitle = !_listAscendingTitle;
                  final direction = _listAscendingTitle ? -1 : 1;
                  setState(() {
                    _tracks.sort((a, b) => a.compareToTitle(b) * direction);
                  });
                  Navigator.of(context).pop();
                },
                trailing: Icon(
                  _listAscendingTitle
                      ? Icons.arrow_upward
                      : Icons.arrow_downward,
                  color: Theme.of(context).buttonColor,
                ),
              ),
              ListTile(
                title: Text('Sort - Artist'),
                onTap: () {
                  _listAscendingArtist = !_listAscendingArtist;
                  final direction = _listAscendingArtist ? -1 : 1;
                  setState(() {
                    _tracks.sort((a, b) => a.compareToArtist(b) * direction);
                  });
                  Navigator.of(context).pop();
                },
                trailing: Icon(
                  _listAscendingArtist
                      ? Icons.arrow_upward
                      : Icons.arrow_downward,
                  color: Theme.of(context).buttonColor,
                ),
              ),
              ListTile(
                title: Text('Sort - Album'),
                onTap: () {
                  _listAscendingAlbum = !_listAscendingAlbum;
                  final direction = _listAscendingAlbum ? -1 : 1;
                  setState(() {
                    _tracks.sort((a, b) => a.compareToAlbum(b) * direction);
                  });
                  Navigator.of(context).pop();
                },
                trailing: Icon(
                  _listAscendingAlbum
                      ? Icons.arrow_upward
                      : Icons.arrow_downward,
                  color: Theme.of(context).buttonColor,
                ),
              ),
              ListTile(
                title: Text('Sort - Runtime'),
                onTap: () {
                  _listAscendingRuntime = !_listAscendingRuntime;
                  final direction = _listAscendingRuntime ? -1 : 1;
                  setState(() {
                    _tracks.sort((a, b) => a.compareToRuntime(b) * direction);
                  });
                  Navigator.of(context).pop();
                },
                trailing: Icon(
                  _listAscendingRuntime
                      ? Icons.arrow_upward
                      : Icons.arrow_downward,
                  color: Theme.of(context).buttonColor,
                ),
              ),
            ],
          ),
        ),
      ),
      body: ReorderableListView(
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            var val = _tracks.removeAt(oldIndex ~/ 2);
            _tracks.insert(newIndex ~/ 2, val);
          });
        },
        children: _tracks
            .map(_toWidget)
            .map((e) => [e, Divider(key: UniqueKey())])
            .expand((e) => e)
            .toList(),
      ),
      appBar: AppBar(
        title: Text('Global List'),
        actions: [
          if (_tracks.any((e) => e.isSelected))
            IconButton(
              icon: Icon(Icons.add_circle),
              onPressed: () {
                setState(() {
                  var _addTracks =
                      _tracks.where((e) => e.isSelected == true).toList();
                  _addTracks.forEach((e) {
                    MyController.addUserTrack(e);
                  });
                });
              },
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Icon(Icons.home),
      ),
    );
  }

  Widget _toWidget(Track t) {
    return CheckboxListTile(
      key: ValueKey(t),
      title: Text(
        t.title,
        style: TextStyle(fontSize: 24),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("\n" + "By: " + t.artist),
          Text("From: " + t.album),
          Text("Runtime: " + toTimeSeconds(t.runtime)),
        ],
      ),
      secondary: Icon(Icons.drag_handle, color: Colors.black),
      value: t.isSelected,
      onChanged: (bool value) => setState(() {
        t.isSelected = value;
      }),
    );
  }
}

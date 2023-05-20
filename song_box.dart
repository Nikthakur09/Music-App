import 'package:flutter/material.dart';
import 'package:music_app/modules/Songs/Models/song.dart';
import 'package:music_app/modules/Songs/service/song_service.dart';

import '../../Player/musicplayer.dart';

class SongBox extends StatelessWidget {
  final String singerName;
  SongBox({super.key, required this.singerName});

  SongService songService = SongService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: songService.getSongs(singerName),
      builder: (context, snap) {
        if (!snap.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snap.hasError) {
          return const Text('Something went wrong');
        }
        List<Song> songs = snap.data!;
        return ListView.builder(
            itemCount: songs.length,
            itemBuilder: (context, int index) {
              Song song = songs[index];
              return Container(
                color:  Colors.white,
                child: InkWell(
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ct) => MusicPlayer(
                                song: song,
                              )));
                    },
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [Icon(Icons.add), Icon(Icons.more_horiz)],
                    ),
                    selectedTileColor: Colors.blue,
                    title: Text(
                      song.trackName!,
                      style: TextStyle(color: Colors.black),
                    ),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image(
                        image: NetworkImage(song.photo!),
                        fit: BoxFit.fill,
                      ),
                    ),
                    subtitle: Text(
                      song.artistName!,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              );
            });
      },
    );
  }
}

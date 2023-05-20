import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../Songs/Models/song.dart';

class MusicPlayer extends StatefulWidget {
  Song song;
  MusicPlayer({required this.song});

  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  bool _isPlaying = false;
  late AudioPlayer audioPlayer;
  Duration? _duration;
  Duration? _position;
  get _durationText => _duration?.toString()?.split('.')?.first ?? '';
  get _positionText => _position?.toString()?.split('.')?.first ?? '';
  @override
  void initState() {
    _initAudioPlayer();
    playAudio(widget.song.previewUrl);

    super.initState();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  void _initAudioPlayer() {
    audioPlayer = AudioPlayer();

    audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        _duration = duration;
      });
    });
    audioPlayer.onPlayerStateChanged.listen((event) {
      if (event == PlayerState.completed) {
        setState(() {
          _isPlaying = false;
        });
      }
    });

    audioPlayer.onPositionChanged.listen((p) => setState(() {
          _position = p;
        }));
  }

  playAudio(path) async {
    await audioPlayer.play(UrlSource(path));

    setState(() {
      _isPlaying = true;
    });
  }

  pauseAudio() async {
    await audioPlayer.pause();

    setState(() {
      _isPlaying = false;
    });
  }

  stopAudio() async {
    await audioPlayer.stop();

    setState(() {
      _isPlaying = false;
    });
  }

  resumeAudio() async {
    await audioPlayer.resume();

    setState(() {
      _isPlaying = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              color: Colors.blueGrey,
              height: height * 0.40,
              width: double.infinity,
              child: Stack(
                children: [
                  Stack(children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 5),
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          fit: BoxFit.fitHeight,
                          image: NetworkImage(widget.song.photo!),
                        ),
                      ),
                    ),
                  ]),
                ],
              ),
            ),

            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.all(1.0),
                  child: Stack(
                    children: [
                      Slider(
                        onChanged: (v) {
                          final Position = v * _duration!.inMilliseconds;
                          audioPlayer
                              .seek(Duration(milliseconds: Position.round()));
                        },
                        value: (_position != null &&
                                _duration != null &&
                                _position!.inMilliseconds > 0 &&
                                _position!.inMilliseconds <
                                    _duration!.inMilliseconds)
                            ? _position!.inMilliseconds /
                                _duration!.inMilliseconds
                            : 0.0,
                      ),
                    ],
                  ),
                ),
                Text(
                  _position != null
                      ? '${_positionText ?? ''}                                                                                       ${_durationText ?? ''}'
                      : _duration != null
                          ? _durationText
                          : '',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            AnimatedOpacity(
              opacity: _isPlaying ? 1.0 : 0.0,
              duration: Duration(seconds: 1),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              textAlign: TextAlign.center,
              "${widget.song.trackName}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              "${widget.song.trackName}",
              style: TextStyle(color: Colors.white),
            ), //at right position
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    color: Colors.white,
                    Icons.volume_off,
                    size: 30,
                  ),
                  onPressed: () async {
                    await audioPlayer.setVolume(0.0);
                  },
                ),
                CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 50,
                  child: IconButton(
                    alignment: Alignment.center,
                    icon: Icon(
                      color: Colors.white,
                      _isPlaying ? Icons.pause : Icons.play_arrow,
                      size: 35,
                    ),
                    onPressed: () {
                      if (_isPlaying == true) {
                        pauseAudio();
                      } else {
                        resumeAudio();
                      }
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(
                    color: Colors.white,
                    Icons.stop,
                    size: 30,
                  ),
                  onPressed: () {
                    stopAudio();
                  },
                ),
                IconButton(
                  icon: Icon(
                    color: Colors.white,
                    Icons.volume_up,
                    size: 30,
                  ),
                  onPressed: () async {
                    await audioPlayer.setVolume(1.0);
                  },
                ),
              ],
            ),
            // Center(
            //   child: ElevatedButton(
            //     child: Text('Add to PlayList'),
            //     onPressed: () {},
            //   ),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [],
            ),
          ],
        ),
      ),
    );
  }
}

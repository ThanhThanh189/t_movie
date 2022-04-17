import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerScreen extends StatefulWidget {
  const TrailerScreen({
    required this.url,
    Key? key,
  }) : super(key: key);
  final String url;

  @override
  State<TrailerScreen> createState() => _TrailerScreenState();
}

class _TrailerScreenState extends State<TrailerScreen> {
  late YoutubePlayerController _youtubeController;

  void _runYoutubePlayer() {
    _youtubeController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.url)!,
      flags: const YoutubePlayerFlags(
        enableCaption: false,
        isLive: false,
        autoPlay: true,
      ),
    );
  }

  @override
  void initState() {
    _runYoutubePlayer();
    super.initState();
  }

  @override
  void deactivate() {
    _youtubeController.pause();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _youtubeController,
        onEnded: (value) {
          _youtubeController.value.isFullScreen
              ? _youtubeController.toggleFullScreenMode()
              : null;
          Navigator.of(context).pop();
        },
      ),
      builder: (context, player) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              player,
            ],
          ),
        );
      },
    );
  }
}

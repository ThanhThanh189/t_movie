import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket/blocs/video/video_event.dart';
import 'package:movie_ticket/blocs/video/video_state.dart';
import 'package:movie_ticket/data/repositories/film_repository.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  FilmRepository filmRepository = FilmRepositoryImp();
  final YoutubePlayerController _youtubeController = YoutubePlayerController(
    initialVideoId: YoutubePlayer.convertUrlToId("8fqv_n6YxWI")!,
    flags: const YoutubePlayerFlags(
      enableCaption: false,
      isLive: false,
      autoPlay: true,
    ),
  );
  VideoBloc() : super(VideoState()) {
    on<VideoEvent>((event, emit) async {
      if (event is StartedVideoEvent) {
        final listVideo = await filmRepository.getListVideo(event.id);
        emit.call(state.update(videoUrl: listVideo?.first.key));
      }
    });
  }
}

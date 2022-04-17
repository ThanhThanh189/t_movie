class VideoState {
  String? videoUrl;
  VideoState({
    this.videoUrl,
  });

  VideoState update({
    String? videoUrl,
  }) {
    return VideoState(
      videoUrl: videoUrl ?? this.videoUrl,
    );
  }
}

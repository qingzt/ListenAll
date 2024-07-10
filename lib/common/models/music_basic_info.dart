class BasicMusicInfo {
  final String title;
  final String artist;
  final String album;

  BasicMusicInfo({
    required this.title,
    required this.artist,
    required this.album,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BasicMusicInfo &&
        other.title == title &&
        other.artist == artist &&
        other.album == album;
  }

  @override
  int get hashCode => title.hashCode ^ artist.hashCode ^ album.hashCode;
}

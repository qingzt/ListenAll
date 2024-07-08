class MusicBasicInfo {
  final String title;
  final String artist;
  final String album;

  MusicBasicInfo({
    required this.title,
    required this.artist,
    required this.album,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MusicBasicInfo &&
        other.title == title &&
        other.artist == artist &&
        other.album == album;
  }

  @override
  int get hashCode => title.hashCode ^ artist.hashCode ^ album.hashCode;
}

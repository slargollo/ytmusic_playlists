import '../types.dart';
import '../utils/filters.dart';
import '../utils/traverse.dart';

final String emptyArtistName = '(unknown artist)';
final String emptyArtistId = emptyArtistName.hashCode.toString();

final String emptyAlbumName = '(unknown album)';
final String emptyAlbumId = emptyAlbumName.hashCode.toString();

class PlaylistParser {
  static PlaylistFull parse(dynamic data, String playlistId) {
    final artist = traverse(data, ["tabs", "straplineTextOne"]);

    final tracks = <PlaylistTrack>[];
    final jsonTracks = traverseList(data, ["twoColumnBrowseResultsRenderer", "contents", "flexColumns", "musicResponsiveListItemFlexColumnRenderer"]);
    final jsonInfo = traverseList(data, ["twoColumnBrowseResultsRenderer", "contents", "fixedColumns", "musicResponsiveListItemFixedColumnRenderer"]);
    final videoCount = int.tryParse(traverseList(data, ["tabs", "secondSubtitle", "text"]).elementAt(2).split(" ").first.replaceAll(",", "")) ?? 0;

    if (videoCount > 0) {
      for (int i = 0; i < videoCount * 3; i += 3) {
        tracks.add(PlaylistTrack(
          playlistId: playlistId,
          title: traverseString(jsonTracks[i], ["runs", "text"]) ?? "",
          videoId: traverseString(jsonTracks[i], ["runs", "videoId"]) ?? "",
          artist: ArtistBasic(
            artistId: traverseString(jsonTracks[i + 1], ["runs", "browseId"]) ?? emptyArtistId,
            name: traverseString(jsonTracks[i + 1], ["runs", "text"]) ?? emptyArtistName,
          ),
          album: AlbumBasic(
            albumId: traverseString(jsonTracks[i + 2], ["runs", "browseId"]) ?? emptyAlbumId,
            name: traverseString(jsonTracks[i + 2], ["runs", "text"]) ?? emptyAlbumName,
          ),
          length: traverseString(jsonInfo[i ~/ 3], ["runs", "text"]) ?? "",
        ));
      }
    }

    return PlaylistFull(
      type: "PLAYLIST",
      playlistId: playlistId,
      name: traverseString(data, ["tabs", "title", "text"]) ?? '',
      artist: ArtistBasic(
        name: traverseString(artist, ["text"]) ?? '',
        artistId: traverseString(artist, ["browseId"]),
      ),
      videoCount: videoCount,
      thumbnails: traverseList(data, ["tabs", "thumbnails"]).map((item) => ThumbnailFull.fromMap(item)).toList(),
      tracks: tracks,
    );
  }

  static PlaylistDetailed parseSearchResult(dynamic item) {
    final columns = traverseList(item, ["flexColumns", "runs"]).expand((e) => e is List ? e : [e]).toList();

    // No specific way to identify the title
    final title = columns[0];
    final artist = columns.firstWhere(
      isArtist,
      orElse: () => columns.length > 2
          ? columns[3]
          : AlbumBasic(
              albumId: '',
              name: '',
            ),
    );

    return PlaylistDetailed(
      type: "PLAYLIST",
      playlistId: traverseString(item, ["overlay", "playlistId"]) ?? '',
      name: traverseString(title, ["text"]) ?? '',
      artist: ArtistBasic(
        name: traverseString(artist, ["text"]) ?? '',
        artistId: traverseString(artist, ["browseId"]),
      ),
      thumbnails: traverseList(item, ["thumbnails"]).map((item) => ThumbnailFull.fromMap(item)).toList(),
    );
  }

  static PlaylistDetailed parseArtistFeaturedOn(dynamic item, ArtistBasic artistBasic) {
    return PlaylistDetailed(
      type: "PLAYLIST",
      playlistId: traverseString(item, ["navigationEndpoint", "browseId"]) ?? '',
      name: traverseString(item, ["runs", "text"]) ?? '',
      artist: artistBasic,
      thumbnails: traverseList(item, ["thumbnails"]).map((item) => ThumbnailFull.fromMap(item)).toList(),
    );
  }

  static PlaylistDetailed parseHomeSection(dynamic item) {
    final artist = traverse(item, ["subtitle", "runs"]);

    return PlaylistDetailed(
      type: "PLAYLIST",
      playlistId: traverseString(item, ["navigationEndpoint", "playlistId"]) ?? '',
      name: traverseString(item, ["runs", "text"]) ?? '',
      artist: ArtistBasic(
        name: traverseString(artist, ["text"]) ?? '',
        artistId: traverseString(artist, ["browseId"]),
      ),
      thumbnails: traverseList(item, ["thumbnails"]).map((item) => ThumbnailFull.fromMap(item)).toList(),
    );
  }
}

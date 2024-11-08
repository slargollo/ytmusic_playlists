import '../types.dart';
import '../utils/traverse.dart';
import 'album_parser.dart';
import 'artist_parser.dart';
import 'playlist_parser.dart';
import 'song_parser.dart';
import 'video_parser.dart';

class SearchParser {
  static SearchResult? parse(dynamic item) {
    final flexColumns = traverseList(item, ["flexColumns"]);
    final type = traverseList(flexColumns[1], ["runs", "text"]).firstOrNull as String?;

    final parsers = {
      "Song": SongParser.parseSearchResult,
      "Video": VideoParser.parseSearchResult,
      "Artist": ArtistParser.parseSearchResult,
      "EP": AlbumParser.parseSearchResult,
      "Single": AlbumParser.parseSearchResult,
      "Album": AlbumParser.parseSearchResult,
      "Playlist": PlaylistParser.parseSearchResult,
    };

    if (parsers.containsKey(type)) {
      final parsedResult = parsers[type]!(item);
      if (parsedResult is SearchResult) {
        return parsedResult;
      }
    } else {
      return null;
    }
    return null;
  }
}

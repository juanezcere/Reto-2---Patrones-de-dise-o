import 'package:flutter/foundation.dart';
import '../../domain/entities/artist.dart';
import '../../domain/usecases/create_artist.dart';
import '../../domain/usecases/get_artists.dart';

class ArtistNotifier extends ChangeNotifier {
  final GetArtistsUseCase _getArtists;
  final CreateArtistUseCase _createArtist;

  ArtistNotifier({
    required GetArtistsUseCase getArtists,
    required CreateArtistUseCase createArtist,
  })  : _getArtists = getArtists,
        _createArtist = createArtist;

  bool isLoading = false;
  List<Artist> artists = [];
  String? error;
  bool created = false;

  Future<void> loadArtists() async {
    isLoading = true;
    error = null;
    created = false;
    notifyListeners();

    (await _getArtists()).fold(
      (f) => error = f.message,
      (data) => artists = data,
    );

    isLoading = false;
    notifyListeners();
  }

  Future<void> addArtist(String name, String email) async {
    isLoading = true;
    error = null;
    created = false;
    notifyListeners();

    (await _createArtist(name, email)).fold(
      (f) => error = f.message,
      (_) => created = true,
    );

    isLoading = false;
    notifyListeners();
  }

  void resetFlags() {
    error = null;
    created = false;
  }
}

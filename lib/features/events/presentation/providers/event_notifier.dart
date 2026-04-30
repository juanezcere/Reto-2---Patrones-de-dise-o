import 'package:flutter/foundation.dart';
import '../../domain/entities/event.dart';
import '../../domain/usecases/create_event.dart';
import '../../domain/usecases/get_artist_events.dart';

class EventNotifier extends ChangeNotifier {
  final GetArtistEventsUseCase _getArtistEvents;
  final CreateEventUseCase _createEvent;

  EventNotifier({
    required GetArtistEventsUseCase getArtistEvents,
    required CreateEventUseCase createEvent,
  })  : _getArtistEvents = getArtistEvents,
        _createEvent = createEvent;

  bool isLoading = false;
  List<Event> events = [];
  String? error;
  bool created = false;

  Future<void> loadEvents(int artistId) async {
    isLoading = true;
    error = null;
    created = false;
    notifyListeners();

    (await _getArtistEvents(artistId)).fold(
      (f) => error = f.message,
      (data) => events = data,
    );

    isLoading = false;
    notifyListeners();
  }

  Future<void> addEvent({
    required String title,
    required String date,
    required String location,
    required int artistId,
  }) async {
    isLoading = true;
    error = null;
    created = false;
    notifyListeners();

    (await _createEvent(
            title: title, date: date, location: location, artistId: artistId))
        .fold(
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

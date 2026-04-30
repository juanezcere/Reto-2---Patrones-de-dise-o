import 'package:flutter/foundation.dart';
import '../../domain/entities/booking.dart';
import '../../domain/usecases/create_booking.dart';
import '../../domain/usecases/get_event_bookings.dart';

class BookingNotifier extends ChangeNotifier {
  final GetEventBookingsUseCase _getEventBookings;
  final CreateBookingUseCase _createBooking;

  BookingNotifier({
    required GetEventBookingsUseCase getEventBookings,
    required CreateBookingUseCase createBooking,
  })  : _getEventBookings = getEventBookings,
        _createBooking = createBooking;

  bool isLoading = false;
  List<Booking> bookings = [];
  String? error;
  bool created = false;

  Future<void> loadBookings(int eventId) async {
    isLoading = true;
    error = null;
    created = false;
    notifyListeners();

    (await _getEventBookings(eventId)).fold(
      (f) => error = f.message,
      (data) => bookings = data,
    );

    isLoading = false;
    notifyListeners();
  }

  Future<void> addBooking({
    required int eventId,
    required int providerId,
  }) async {
    isLoading = true;
    error = null;
    created = false;
    notifyListeners();

    (await _createBooking(eventId: eventId, providerId: providerId)).fold(
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

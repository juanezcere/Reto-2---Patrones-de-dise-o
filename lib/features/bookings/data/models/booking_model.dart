import '../../domain/entities/booking.dart';

class BookingModel extends Booking {
  const BookingModel({
    required super.id,
    required super.eventId,
    required super.providerId,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
        id: json['id'] as int,
        eventId: json['event_id'] as int,
        providerId: json['provider_id'] as int,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'event_id': eventId,
        'provider_id': providerId,
      };
}

import 'package:equatable/equatable.dart';

class Booking extends Equatable {
  final int id;
  final int eventId;
  final int providerId;

  const Booking({
    required this.id,
    required this.eventId,
    required this.providerId,
  });

  @override
  List<Object> get props => [id, eventId, providerId];
}

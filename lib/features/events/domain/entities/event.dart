import 'package:equatable/equatable.dart';

class Event extends Equatable {
  final int id;
  final String title;
  final String date;
  final String location;
  final int artistId;

  const Event({
    required this.id,
    required this.title,
    required this.date,
    required this.location,
    required this.artistId,
  });

  @override
  List<Object> get props => [id, title, date, location, artistId];
}

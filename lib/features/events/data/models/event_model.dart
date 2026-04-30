import '../../domain/entities/event.dart';

class EventModel extends Event {
  const EventModel({
    required super.id,
    required super.title,
    required super.date,
    required super.location,
    required super.artistId,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        id: json['id'] as int,
        title: json['title'] as String,
        date: json['date'] as String,
        location: json['location'] as String,
        artistId: json['artist_id'] as int,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'date': date,
        'location': location,
        'artist_id': artistId,
      };
}

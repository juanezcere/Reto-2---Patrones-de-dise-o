import '../../domain/entities/artist.dart';

class ArtistModel extends Artist {
  const ArtistModel({
    required super.id,
    required super.name,
    required super.email,
  });

  factory ArtistModel.fromJson(Map<String, dynamic> json) => ArtistModel(
        id: json['id'] as int,
        name: json['name'] as String,
        email: json['email'] as String,
      );

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'email': email};
}

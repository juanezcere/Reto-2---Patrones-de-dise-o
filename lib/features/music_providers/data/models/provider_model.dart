import '../../domain/entities/provider_entity.dart';

class ProviderModel extends ProviderEntity {
  const ProviderModel({
    required super.id,
    required super.name,
    required super.category,
    required super.contactInfo,
  });

  factory ProviderModel.fromJson(Map<String, dynamic> json) => ProviderModel(
        id: json['id'] as int,
        name: json['name'] as String,
        category: json['category'] as String,
        contactInfo: json['contact_info'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'category': category,
        'contact_info': contactInfo,
      };
}

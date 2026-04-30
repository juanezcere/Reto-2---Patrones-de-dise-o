import 'package:equatable/equatable.dart';

class ProviderEntity extends Equatable {
  final int id;
  final String name;
  final String category;
  final String contactInfo;

  const ProviderEntity({
    required this.id,
    required this.name,
    required this.category,
    required this.contactInfo,
  });

  @override
  List<Object> get props => [id, name, category, contactInfo];
}

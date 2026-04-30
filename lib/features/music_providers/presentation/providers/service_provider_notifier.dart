import 'package:flutter/foundation.dart';
import '../../domain/entities/provider_entity.dart';
import '../../domain/usecases/create_provider.dart';
import '../../domain/usecases/get_categories.dart';
import '../../domain/usecases/get_providers.dart';

class ServiceProviderNotifier extends ChangeNotifier {
  final GetCategoriesUseCase _getCategories;
  final GetProvidersUseCase _getProviders;
  final CreateProviderUseCase _createProvider;

  List<String> _categories = [];

  ServiceProviderNotifier({
    required GetCategoriesUseCase getCategories,
    required GetProvidersUseCase getProviders,
    required CreateProviderUseCase createProvider,
  })  : _getCategories = getCategories,
        _getProviders = getProviders,
        _createProvider = createProvider;

  bool isLoading = false;
  List<ProviderEntity> providers = [];
  List<String> get categories => _categories;
  String? error;
  bool created = false;

  Future<void> init() async {
    isLoading = true;
    error = null;
    created = false;
    notifyListeners();

    List<String>? cats;
    String? err;

    (await _getCategories()).fold(
      (f) => err = f.message,
      (c) => cats = c,
    );

    if (err != null) {
      error = err;
      isLoading = false;
      notifyListeners();
      return;
    }

    _categories = cats!;

    (await _getProviders()).fold(
      (f) => error = f.message,
      (data) => providers = data,
    );

    isLoading = false;
    notifyListeners();
  }

  Future<void> loadCategories() async {
    isLoading = true;
    error = null;
    notifyListeners();

    (await _getCategories()).fold(
      (f) => error = f.message,
      (cats) {
        _categories = cats;
        providers = [];
      },
    );

    isLoading = false;
    notifyListeners();
  }

  Future<void> filterByCategory(String? category) async {
    isLoading = true;
    error = null;
    notifyListeners();

    (await _getProviders(category: category)).fold(
      (f) => error = f.message,
      (data) => providers = data,
    );

    isLoading = false;
    notifyListeners();
  }

  Future<void> addProvider({
    required String name,
    required String category,
    required String contactInfo,
  }) async {
    isLoading = true;
    error = null;
    created = false;
    notifyListeners();

    (await _createProvider(
            name: name, category: category, contactInfo: contactInfo))
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

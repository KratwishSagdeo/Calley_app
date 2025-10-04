import 'package:flutter/material.dart';
// Corrected the package name in the import paths
import '../services/local_storage_service.dart';
import '../services/storage_service.dart';

class AppConfig {
  static late final StorageService storageService;
  static late final LocalStorageService localStorageService;

  static Future<void> initialize() async {
    // Initialize storage services
    storageService = StorageService();
    localStorageService = LocalStorageService();

    await storageService.init();
    await localStorageService.init();
  }
}

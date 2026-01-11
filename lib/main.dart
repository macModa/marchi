import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/network/dio_client.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Dio Client
  DioClient().initialize();
  
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

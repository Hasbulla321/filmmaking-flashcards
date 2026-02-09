import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'config/firebase_options.dart';
import 'services/card_service.dart';
import 'services/firestore_card_service.dart';
import 'services/storage_service.dart';
import 'services/local_storage_service.dart';
import 'providers/app_state.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final cardService = FirestoreCardService();
  final storageService = LocalStorageService();

  runApp(
    MultiProvider(
      providers: [
        Provider<CardService>.value(value: cardService),
        Provider<StorageService>.value(value: storageService),
        ChangeNotifierProvider<AppState>(
          create: (_) => AppState(
            cardService: cardService,
            storageService: storageService,
          )..init(),
        ),
      ],
      child: const FilmCraftApp(),
    ),
  );
}

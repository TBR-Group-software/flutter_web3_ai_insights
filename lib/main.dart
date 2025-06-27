import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web3_ai_assistant/core/theme/app_theme.dart';
import 'package:web3_ai_assistant/core/navigation/app_router.dart';

void main() {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set system UI overlay style
  AppTheme.setSystemUIOverlayStyle(true); // Default to dark theme
  
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = AppRouter.createRouter();
    
    return MaterialApp.router(
      title: 'Web3 AI Assistant',
      debugShowCheckedModeBanner: false,
      
      // Theme configuration
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark, // Default to dark theme for Web3 aesthetic
      
      // Router configuration
      routerConfig: router,
      
      // App configuration
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.noScaling, // Prevent system font scaling from breaking layout
          ),
          child: child!,
        );
      },
    );
  }
}

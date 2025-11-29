import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:therapy/logic/destruction_provider.dart';
import 'package:therapy/screens/home_screen.dart';
import 'package:therapy/theme/app_theme.dart';

void main() {
  runApp(const LetGoApp());
}

class LetGoApp extends StatelessWidget {
  const LetGoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => DestructionProvider())],
      child: MaterialApp(
        title: 'Let Go',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: const HomeScreen(),
      ),
    );
  }
}

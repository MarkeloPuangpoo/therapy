import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:therapy/logic/destruction_provider.dart';
import 'package:therapy/screens/canvas_screen.dart';
import 'package:therapy/screens/destruction_screen.dart';
import 'package:therapy/screens/aftermath_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.select((DestructionProvider p) => p.state);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: _buildScreen(state),
    );
  }

  Widget _buildScreen(AppState state) {
    switch (state) {
      case AppState.input:
        return const CanvasScreen();
      case AppState.destroying:
        return const DestructionScreen();
      case AppState.aftermath:
        return const AftermathScreen();
    }
  }
}

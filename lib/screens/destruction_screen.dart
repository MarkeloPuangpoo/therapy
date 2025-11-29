import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:therapy/logic/destruction_provider.dart';
import 'package:therapy/widgets/particle_fire.dart';
import 'package:vibration/vibration.dart';

class DestructionScreen extends StatefulWidget {
  const DestructionScreen({super.key});

  @override
  State<DestructionScreen> createState() => _DestructionScreenState();
}

class _DestructionScreenState extends State<DestructionScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _startDestructionSequence();
  }

  Future<void> _startDestructionSequence() async {
    final provider = Provider.of<DestructionProvider>(context, listen: false);

    // Haptic Feedback
    try {
      if (await Vibration.hasVibrator() ?? false) {
        if (provider.mode == DestructionMode.shred) {
          Vibration.vibrate(pattern: [0, 200, 50, 200, 50, 200]);
        } else if (provider.mode == DestructionMode.fire) {
          Vibration.vibrate(duration: 2000, amplitude: 128); // Rumble
        } else {
          Vibration.vibrate(duration: 500);
        }
      }
    } catch (e) {
      debugPrint('Vibration error: $e');
    }

    // Wait for animation to finish (approx 3 seconds)
    await Future.delayed(const Duration(seconds: 3));

    if (mounted) {
      provider.completeDestruction();
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DestructionProvider>(context);
    final text = provider.text;
    final mode = provider.mode;

    return Scaffold(
      backgroundColor: Colors.black, // Darker for destruction
      body: Center(child: _buildAnimation(mode, text)),
    );
  }

  Widget _buildAnimation(DestructionMode mode, String text) {
    Widget content = Container(
      padding: const EdgeInsets.all(24),
      constraints: const BoxConstraints(maxWidth: 600),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyLarge,
        textAlign: TextAlign.center,
      ),
    );

    switch (mode) {
      case DestructionMode.fire:
        return Stack(
          alignment: Alignment.center,
          children: [
            content
                .animate()
                .tint(color: Colors.orange, duration: 1.seconds)
                .then()
                .tint(color: Colors.black, duration: 1.seconds)
                .fadeOut(duration: 1.seconds)
                .scale(begin: const Offset(1, 1), end: const Offset(0.8, 0.8)),
            LayoutBuilder(
              builder: (context, constraints) {
                return ParticleFire(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                );
              },
            ),
          ],
        );

      case DestructionMode.shred:
        // Simulating shredding by masking (simplified for now)
        return content
            .animate()
            .slideY(
              begin: 0,
              end: 1,
              duration: 2.seconds,
              curve: Curves.easeInOut,
            )
            .fadeOut(delay: 1.5.seconds, duration: 500.ms);

      case DestructionMode.crumple:
        return content
            .animate()
            .scale(
              end: const Offset(0.01, 0.01),
              duration: 1.5.seconds,
              curve: Curves.easeInOutBack,
            )
            .rotate(end: 2, duration: 1.5.seconds)
            .fadeOut(delay: 1.seconds);

      case DestructionMode.dissolve:
        return content
            .animate()
            .blur(end: const Offset(20, 20), duration: 2.seconds)
            .fadeOut(duration: 2.seconds);
    }
  }
}

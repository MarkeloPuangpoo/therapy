import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:therapy/logic/destruction_provider.dart';

class AftermathScreen extends StatefulWidget {
  const AftermathScreen({super.key});

  @override
  State<AftermathScreen> createState() => _AftermathScreenState();
}

class _AftermathScreenState extends State<AftermathScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Provider.of<DestructionProvider>(context, listen: false).reset();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            Text(
                  "It's gone now.",
                  style: Theme.of(
                    context,
                  ).textTheme.displayLarge?.copyWith(fontSize: 24),
                )
                .animate()
                .fadeIn(duration: 1.seconds)
                .then(delay: 1.seconds)
                .fadeOut(duration: 1.seconds),
      ),
    );
  }
}

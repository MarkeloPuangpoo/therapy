import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:therapy/logic/destruction_provider.dart';
import 'package:therapy/theme/app_theme.dart';

class CanvasScreen extends StatefulWidget {
  const CanvasScreen({super.key});

  @override
  State<CanvasScreen> createState() => _CanvasScreenState();
}

class _CanvasScreenState extends State<CanvasScreen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Auto-focus after a short delay to ensure UI is ready
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DestructionProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Input Area
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                style: Theme.of(context).textTheme.bodyLarge,
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  hintText: "What's weighing on your mind right now?",
                  hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  provider.setText(value);
                },
              ),
            ),

            // "Let Go" Button
            if (provider.text.trim().isNotEmpty)
              Positioned(
                bottom: 32,
                left: 0,
                right: 0,
                child: Center(
                  child: TextButton.icon(
                    onPressed: () {
                      _focusNode.unfocus();
                      provider.startDestruction();
                    },
                    icon: const Icon(
                      Icons.local_fire_department_outlined,
                      color: AppTheme.accentDestruction,
                    ),
                    label: Text(
                      "Let Go",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.accentDestruction,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      backgroundColor: AppTheme.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ).animate().fadeIn(duration: 500.ms).moveY(begin: 10, end: 0),
                ),
              ),

            // Mode Selector (Subtle)
            Positioned(
              top: 16,
              right: 16,
              child: PopupMenuButton<DestructionMode>(
                icon: const Icon(
                  Icons.settings_outlined,
                  color: AppTheme.textSecondary,
                ),
                color: AppTheme.surface,
                onSelected: provider.setMode,
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: DestructionMode.fire,
                    child: Text(
                      'Incinerate',
                      style: TextStyle(color: AppTheme.textPrimary),
                    ),
                  ),
                  const PopupMenuItem(
                    value: DestructionMode.shred,
                    child: Text(
                      'Shred',
                      style: TextStyle(color: AppTheme.textPrimary),
                    ),
                  ),
                  const PopupMenuItem(
                    value: DestructionMode.crumple,
                    child: Text(
                      'Crumple',
                      style: TextStyle(color: AppTheme.textPrimary),
                    ),
                  ),
                  const PopupMenuItem(
                    value: DestructionMode.dissolve,
                    child: Text(
                      'Dissolve',
                      style: TextStyle(color: AppTheme.textPrimary),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:math';
import 'package:flutter/material.dart';

class ParticleFire extends StatefulWidget {
  final double width;
  final double height;

  const ParticleFire({super.key, required this.width, required this.height});

  @override
  State<ParticleFire> createState() => _ParticleFireState();
}

class _ParticleFireState extends State<ParticleFire>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<FireParticle> _particles = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
    _controller.addListener(_updateParticles);
  }

  void _updateParticles() {
    // Add new particles
    for (int i = 0; i < 3; i++) {
      _particles.add(
        FireParticle(
          position: Offset(
            widget.width * 0.5 +
                (_random.nextDouble() - 0.5) * widget.width * 0.6,
            widget.height,
          ),
          velocity: Offset(
            (_random.nextDouble() - 0.5) * 2,
            -_random.nextDouble() * 4 - 2,
          ),
          size: _random.nextDouble() * 15 + 5,
          life: 1.0,
          color: Colors.orange,
        ),
      );
    }

    // Update existing particles
    for (var i = _particles.length - 1; i >= 0; i--) {
      _particles[i].update();
      if (_particles[i].life <= 0) {
        _particles.removeAt(i);
      }
    }
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: CustomPaint(
        painter: FirePainter(_particles),
        size: Size(widget.width, widget.height),
      ),
    );
  }
}

class FireParticle {
  Offset position;
  Offset velocity;
  double size;
  double life;
  Color color;

  FireParticle({
    required this.position,
    required this.velocity,
    required this.size,
    required this.life,
    required this.color,
  });

  void update() {
    position += velocity;
    life -= 0.015;
    size *= 0.96;

    if (life < 0.4) {
      color = Colors.grey.withAlpha(128);
    } else if (life < 0.7) {
      color = Colors.redAccent;
    }
  }
}

class FirePainter extends CustomPainter {
  final List<FireParticle> particles;

  FirePainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    for (var particle in particles) {
      final paint = Paint()
        ..color = particle.color.withAlpha(
          (particle.life.clamp(0.0, 1.0) * 255).toInt(),
        )
        ..style = PaintingStyle.fill
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);

      canvas.drawCircle(particle.position, particle.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

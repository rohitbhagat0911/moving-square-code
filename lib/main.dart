import 'package:flutter/material.dart';

/// The main entry point of the application.
void main() {
  runApp(const MyApp());
}

/// The root widget of the application.
class MyApp extends StatelessWidget {
  /// Creates a [MyApp] widget.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Padding(
        padding: EdgeInsets.all(32.0),
        child: Center(
          child: SquareAnimation(),
        ),
      ),
    );
  }
}

/// A widget that animates a square moving left and right.
class SquareAnimation extends StatefulWidget {
  /// Creates a [SquareAnimation] widget.
  const SquareAnimation({super.key});

  @override
  State<SquareAnimation> createState() => _SquareAnimationState();
}

class _SquareAnimationState extends State<SquareAnimation>
    with SingleTickerProviderStateMixin {
  /// The size of the animated square.
  static const double _squareSize = 50.0;

  /// The current horizontal position of the square.
  double _position = 0.0;

  /// The maximum horizontal position the square can move to.
  late double _maxPosition;

  /// Whether the animation is currently in progress.
  bool _isAnimating = false;

  /// Controls the animation of the square.
  late AnimationController _controller;

  /// The animation that drives the square's movement.
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _controller.addListener(() {
      setState(() {
        _position = _animation.value;
      });
    });

    /// Ensures that `_maxPosition` is calculated after the first frame.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _maxPosition = MediaQuery.of(context).size.width - _squareSize - 64;
        _position = _maxPosition / 2;
      });
    });
  }

  /// Moves the square to the specified [targetPosition].
  ///
  /// If an animation is already in progress, this method returns immediately.
  void _moveSquare(double targetPosition) {
    setState(() {
      _isAnimating = true;
    });

    _animation = Tween<double>(begin: _position, end: targetPosition).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward(from: 0).whenComplete(() {
      setState(() {
        _position = targetPosition;
        _isAnimating = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _maxPosition = constraints.maxWidth - _squareSize;

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 0),
                    left: _position,
                    child: Container(
                      width: _squareSize,
                      height: _squareSize,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        border: Border.all(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: (!_isAnimating && _position > 0)
                      ? () => _moveSquare(0)
                      : null,
                  child: const Text('Left'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: (!_isAnimating && _position < _maxPosition)
                      ? () => _moveSquare(_maxPosition)
                      : null,
                  child: const Text('Right'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:ptst_app/core/constants/app_colors.dart';

/// A realistic 3D Hardcover Book widget with:
/// - Perspective 3D rotation on hover
/// - Visible spine curvature & gilded edge texture
/// - Foil stamped gold embossing for sacred title & author
/// - Silk bookmark ribbon
/// - Realistic casting shadow beneath the book
class Book3DWidget extends StatefulWidget {
  const Book3DWidget({
    super.key,
    required this.title,
    required this.author,
    this.coverColor = const Color(0xFF6B0E23),
    this.accentColor = const Color(0xFFC9A94E),
    this.width = 140,
    this.height = 200,
    this.thickness = 22,
    this.onTap,
  });

  final String title;
  final String author;
  final Color coverColor;
  final Color accentColor;
  final double width;
  final double height;
  final double thickness;
  final VoidCallback? onTap;

  @override
  State<Book3DWidget> createState() => _Book3DWidgetState();
}

class _Book3DWidgetState extends State<Book3DWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _hoverController;
  late final Animation<double> _tiltAnimation;
  late final Animation<double> _liftAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 320),
    );
    _tiltAnimation = Tween<double>(begin: -0.15, end: -0.35).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeOutCubic),
    );
    _liftAnimation = Tween<double>(begin: 0.0, end: -12.0).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  void _onEnter(PointerEnterEvent) {
    setState(() => _isHovered = true);
    _hoverController.forward();
  }

  void _onExit(PointerExitEvent) {
    setState(() => _isHovered = false);
    _hoverController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (e) => _onEnter(e),
      onExit: (e) => _onExit(e),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _hoverController,
          builder: (context, child) {
            final tiltAngle = _tiltAnimation.value;
            final liftOffset = _liftAnimation.value;

            // 3D Transform to simulate realistic isometric angled book
            final transform = Matrix4.identity()
              ..setEntry(3, 2, 0.002) // Perspective depth
              ..translate(0.0, liftOffset)
              ..rotateY(tiltAngle)
              ..rotateZ(0.03);

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              width: widget.width + widget.thickness,
              height: widget.height + 25,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.centerLeft,
                children: [
                  // ── 3D Cast Shadow ─────────────────────────────
                  Positioned(
                    bottom: 0,
                    left: 10,
                    child: Container(
                      width: widget.width * 0.95,
                      height: 18,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.elliptical(widget.width * 0.9, 14),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF280008).withOpacity(_isHovered ? 0.45 : 0.25),
                            blurRadius: _isHovered ? 24 : 12,
                            spreadRadius: _isHovered ? 4 : 1,
                            offset: Offset(_isHovered ? 14 : 6, 8),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // ── 3D Book Body with Spine & Pages ────────────
                  Transform(
                    transform: transform,
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Spine side thickness
                        Container(
                          width: widget.thickness,
                          height: widget.height,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                widget.coverColor.withRed(widget.coverColor.red ~/ 1.4),
                                widget.coverColor,
                                widget.coverColor.withRed(widget.coverColor.red ~/ 1.2),
                              ],
                            ),
                            borderRadius: const BorderRadius.horizontal(
                              left: Radius.circular(5),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 4,
                                offset: const Offset(-2, 0),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _goldSpineRibbon(),
                              RotatedBox(
                                quarterTurns: 3,
                                child: Text(
                                  widget.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: widget.accentColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ),
                              _goldSpineRibbon(),
                            ],
                          ),
                        ),

                        // Front Hardcover
                        Container(
                          width: widget.width,
                          height: widget.height,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                widget.coverColor,
                                widget.coverColor.withBlue(widget.coverColor.blue + 10),
                                widget.coverColor.withRed(math.max(0, widget.coverColor.red - 20)),
                              ],
                            ),
                            borderRadius: const BorderRadius.horizontal(
                              right: Radius.circular(6),
                            ),
                            border: Border.all(
                              color: widget.accentColor.withOpacity(0.4),
                              width: 1.2,
                            ),
                          ),
                          child: Stack(
                            children: [
                              // Inner Gold Foil Border
                              Positioned.fill(
                                child: Padding(
                                  padding: const EdgeInsets.all(7.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: widget.accentColor.withOpacity(0.65),
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ),
                              ),

                              // Sacred Lotus / Om Motif in Center
                              Positioned(
                                top: 22,
                                left: 0,
                                right: 0,
                                child: Center(
                                  child: Container(
                                    width: 44,
                                    height: 44,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: widget.accentColor.withOpacity(0.7),
                                        width: 1.5,
                                      ),
                                      gradient: RadialGradient(
                                        colors: [
                                          widget.accentColor.withOpacity(0.2),
                                          Colors.transparent,
                                        ],
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'ॐ',
                                        style: TextStyle(
                                          color: widget.accentColor,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              // Book Title
                              Positioned(
                                top: 78,
                                left: 14,
                                right: 14,
                                child: Text(
                                  widget.title,
                                  textAlign: TextAlign.center,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: AppColors.ivory,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    height: 1.3,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black.withOpacity(0.7),
                                        offset: const Offset(0, 1),
                                        blurRadius: 3,
                                      ),
                                      Shadow(
                                        color: widget.accentColor.withOpacity(0.6),
                                        offset: const Offset(0, 0),
                                        blurRadius: 8,
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // Author / Tika
                              Positioned(
                                bottom: 20,
                                left: 12,
                                right: 12,
                                child: Column(
                                  children: [
                                    Container(
                                      width: 28,
                                      height: 1,
                                      color: widget.accentColor.withOpacity(0.5),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      widget.author,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: widget.accentColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Spine Crease Reflection highlight
                              Positioned(
                                left: 0,
                                top: 0,
                                bottom: 0,
                                width: 8,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.black.withOpacity(0.35),
                                        Colors.white.withOpacity(0.15),
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              // Gilded Sheen Effect when Hovered
                              if (_isHovered)
                                Positioned.fill(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Colors.white.withOpacity(0.25),
                                          Colors.transparent,
                                          widget.accentColor.withOpacity(0.15),
                                        ],
                                        stops: const [0.0, 0.5, 1.0],
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),

                        // Page edges depth texture on the right
                        Container(
                          width: 8,
                          height: widget.height - 8,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFFF7F2E7),
                                Color(0xFFE2D6BE),
                                Color(0xFFF7F2E7),
                              ],
                            ),
                            borderRadius: const BorderRadius.horizontal(
                              right: Radius.circular(2),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 3,
                                offset: const Offset(2, 0),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(
                              16,
                              (index) => Container(
                                height: 0.8,
                                color: const Color(0xFFC4B598).withOpacity(0.6),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Hanging Silk Bookmark
                  Positioned(
                    top: widget.height - 18,
                    left: widget.thickness + 24,
                    child: Container(
                      width: 10,
                      height: 28,
                      decoration: BoxDecoration(
                        color: widget.accentColor,
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(3),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 3,
                            offset: const Offset(1, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _goldSpineRibbon() {
    return Container(
      width: widget.thickness * 0.7,
      height: 3,
      decoration: BoxDecoration(
        color: widget.accentColor,
        borderRadius: BorderRadius.circular(1),
      ),
    );
  }
}

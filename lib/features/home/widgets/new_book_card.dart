import 'package:flutter/material.dart';
import 'package:ptst_app/shared/widgets/book_3d_widget.dart';

/// New book card rendered as an isometric 3D Hardcover Book with
/// realistic spine, gold leaf embossing, page ridges, and hover tilt lift!
class NewBookCard extends StatelessWidget {
  const NewBookCard({
    super.key,
    required this.title,
    required this.author,
    this.gradientColors,
    this.onTap,
  });

  final String title;
  final String author;
  final List<Color>? gradientColors;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    // Pick unique royal hardcover colors
    Color coverColor = const Color(0xFF6B0E23); // Royal maroon
    if (title.contains('समयसार')) {
      coverColor = const Color(0xFF4A102A); // Deep burgundy
    } else if (title.contains('सिद्धांत')) {
      coverColor = const Color(0xFF1E3A2B); // Sacred forest emerald
    }

    return Book3DWidget(
      title: title,
      author: author,
      coverColor: coverColor,
      onTap: onTap,
    );
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';

class AsymmetricTopCard extends StatefulWidget {
  final String imagePath;
  final String productName;
  final String brand;
  final double price;
  final VoidCallback onFavoriteToggle;
  final double height;

  //final double width;

  const AsymmetricTopCard(
      {Key? key,
        required this.imagePath,
        required this.productName,
        required this.brand,
        required this.price,
        required this.onFavoriteToggle,
        required this.height})
      : super(key: key);

  @override
  State<AsymmetricTopCard> createState() => _AsymmetricTopCardState();
}
class _AsymmetricTopCardState extends State<AsymmetricTopCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: AsymmetricTopRectangleClipper(),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
        child: Container(
          //width: 200,
          height: widget.height,
          decoration: BoxDecoration(
              color: const Color(0xFF4B6EAF),
              borderRadius: BorderRadius.circular(0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(64), // 25% opacity
                  offset: Offset(4, 4), // x = 4, y = 4
                  blurRadius: 4, // Assumed blur radius
                ),
              ],
              gradient: LinearGradient(colors: [
                Color(0xD0363E51),
                Color(0xD0191E26),
              ])),
          child: CustomPaint(
            painter: ClipperTopBorderPainter(),
            child: Stack(
              children: [
                // Product image
                Positioned(
                  top: 20,
                  left: 0,
                  right: 0,
                  height: 120,
                  child: Center(
                    child: Image.asset(
                      widget.imagePath,
                      errorBuilder: (context, error, stackTrace) {
                        // Fallback to a placeholder if the image doesn't load
                        return Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.abc,
                            size: 80,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // Favorite icon
                Positioned(
                  top: 15,
                  right: 15,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                      widget.onFavoriteToggle();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),

                // Product details
                Positioned(
                  left: 20,
                  bottom: 20,
                  right: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.productName,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.brand,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '\$ ${widget.price.toStringAsFixed(0)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AsymmetricTopRectangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // The left side is shifted down by 10 pixels
    final leftShift = 40.0;

    final curve = 20.0;

    // Top-left (shifted down)
    path.moveTo(0, curve);

    path.arcToPoint(Offset(curve, 0), radius: Radius.circular(20));

    // Top-right
    path.lineTo(size.width - curve, 0);

    path.arcToPoint(Offset(size.width, curve), radius: Radius.circular(20));

    // Bottom-right
    path.lineTo(size.width, size.height - leftShift - curve);

    path.arcToPoint(Offset(size.width - curve, size.height - leftShift),
        radius: Radius.circular(20));
    // Bottom-left (shifted down)
    path.lineTo(0 + curve, size.height);

    path.arcToPoint(Offset(0, size.height - 20), radius: Radius.circular(20));

    // Close the path
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}


class ClipperTopBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();

    // The left side is shifted down by 10 pixels
    final leftShift = 40.0;

    final curve = 20.0;

    // Top-left (shifted down)
    path.moveTo(0, curve);

    path.arcToPoint(Offset(curve, 0), radius: Radius.circular(20));

    // Top-right
    path.lineTo(size.width - curve, 0);

    path.arcToPoint(Offset(size.width, curve), radius: Radius.circular(20));

    // Bottom-right
    path.lineTo(size.width, size.height - leftShift - curve);

    path.arcToPoint(Offset(size.width - curve, size.height - leftShift),
        radius: Radius.circular(20));
    // Bottom-left (shifted down)
    path.lineTo(0 + curve, size.height);

    path.arcToPoint(Offset(0, size.height - 20), radius: Radius.circular(20));

    // Close the path
    path.close();

    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..color = Color(0xFF191E26);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

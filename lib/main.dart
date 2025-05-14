import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'AsymmetricTopCard.dart';
import 'background_custom_clipper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Asymmetric Product Card',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: ProductCardDemo(),
    );
  }
}

class ProductCardDemo extends StatefulWidget {
  ProductCardDemo({Key? key}) : super(key: key);

  @override
  State<ProductCardDemo> createState() => _ProductCardDemoState();
}

class _ProductCardDemoState extends State<ProductCardDemo> {
  final List<Map<String, dynamic>> categories = [
    {'icon': Icons.apps, 'label': 'All', 'isSelected': true},
    {
      'icon': Icons.battery_charging_full,
      'label': 'Electric',
      'isSelected': false
    },
    {'icon': Icons.directions_bike, 'label': 'Urban', 'isSelected': false},
    {'icon': Icons.landscape, 'label': 'Mountain', 'isSelected': false},
    {'icon': Icons.sports_motorsports, 'label': 'Racing', 'isSelected': false},
  ];

  final List<Map<String, dynamic>> products = [
    {
      'id': 1,
      'name': 'Road Bike',
      'brand': 'PEUGEOT - LR01',
      'price': 1999.99,
      'image': 'assets/products/cobi.png',
      'type': 'bike',
      'discount': null,
    },
    {
      'id': 2,
      'name': 'Road Helmet',
      'brand': 'SMITH - Trade',
      'price': 120.00,
      'image': 'assets/products//eb.png',
      'type': 'accessory',
      'discount': null,
    },
    {
      'id': 3,
      'name': 'Carbon Race Bike',
      'brand': 'TREK - Domane',
      'price': 4500.00,
      'image': 'assets/products/mikkel.png',
      'type': 'bike',
      'discount': null,
    },
    {
      'id': 4,
      'name': 'Modern E-Bike',
      'brand': 'SPECIALIZED - Turbo',
      'price': 3299.99,
      'image': 'assets/products/robert.png',
      'type': 'bike',
      'discount': 30,
    },
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                ClipPath(
                  clipper: BackgroundRightClipper(),
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFF37B6E9), Color(0xFF4B4CED)])),
                  ),
                ),
                ClipPath(
                  clipper: BackgroundLeftClipper(),
                  child: Container(
                    decoration: BoxDecoration(color: Color(0xFF242C3B)
/*                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFF37B6E9), Color(0xFF4B4CED)])*/
                        ),
                  ),
                )
              ],
            ),
          ),
          SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ListView(
                shrinkWrap: true,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: AsymmetricTopCard(
                      imagePath: 'assets/products/robert.png',
                      productName: 'Road Helmet',
                      brand: 'SMITH - Trade',
                      price: 120,
                      onFavoriteToggle: () {
                        debugPrint('Favorite toggled');
                      },
                      height: 250,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        categories.length,
                        (index) {
                          final double verticalOffset = -index * 10.0;
                          return Transform.translate(
                            offset: Offset(0, verticalOffset),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: CategoryButton(
                                icon: categories[index]['icon'],
                                label: categories[index]['label'],
                                isSelected: index == currentIndex,
                                onTap: () {
                                  setState(() {
                                    currentIndex = index;
                                  });
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    //height: 500,
                    padding: EdgeInsets.all(20),
                    child: MasonryGridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      itemCount: products.length * 3,
                      itemBuilder: (context, index) {
                        double height = index % 2 == 0 ? 300 : 300;
                        print("index $index $height");
                        Map<String, dynamic> product = products[index % 4];
                        return Container(
                          margin: index == 0 && index % 2 == 0
                              ? EdgeInsets.only(top: 30)
                              : EdgeInsets.zero,
                          child: AsymmetricProductCard(
                            imagePath: product['image'],
                            productName: product['name'],
                            brand: product['brand'],
                            price: product['price'],
                            height: height,
                            onFavoriteToggle: () {
                              debugPrint('Favorite toggled');
                            },
                          ),
                        );
                      },
                    ),
                  ),
/*
                  Container(
                      padding: const EdgeInsets.all(20.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 10,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.9,
                            crossAxisCount: 2,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20),
                        itemBuilder: (BuildContext context, int index) {
                          return AsymmetricProductCard(
                            imagePath: 'assets/helmet.png',
                            productName: 'Road Helmet',
                            brand: 'SMITH - Trade',
                            price: 120,
                            height: 200,
                            onFavoriteToggle: () {
                              debugPrint('Favorite toggled');
                            },
                          );
                        },
                      ))
*/
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ClipperBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();

    // The left side is shifted down by 10 pixels
    final leftShift = 20.0;

    final curve = 20.0;

    // Top-left (shifted down)
    path.moveTo(0, leftShift + curve);

    path.arcToPoint(Offset(leftShift, leftShift), radius: Radius.circular(20));

    // Top-right
    path.lineTo(size.width - curve, 0);

    path.arcToPoint(Offset(size.width, leftShift), radius: Radius.circular(20));

    // Bottom-right
    path.lineTo(size.width, size.height - leftShift - curve);

    path.arcToPoint(Offset(size.width - curve, size.height - leftShift),
        radius: Radius.circular(20));
    // Bottom-left (shifted down)
    path.lineTo(0 + leftShift, size.height);

    path.arcToPoint(Offset(0, size.height - 20), radius: Radius.circular(20));

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

class AsymmetricProductCard extends StatefulWidget {
  final String imagePath;
  final String productName;
  final String brand;
  final double price;
  final VoidCallback onFavoriteToggle;
  final double height;

  //final double width;

  const AsymmetricProductCard(
      {Key? key,
      required this.imagePath,
      required this.productName,
      required this.brand,
      required this.price,
      required this.onFavoriteToggle,
      required this.height})
      : super(key: key);

  @override
  State<AsymmetricProductCard> createState() => _AsymmetricProductCardState();
}

class _AsymmetricProductCardState extends State<AsymmetricProductCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: AsymmetricRectangleClipper(),
      child: BackdropFilter(
        enabled: true,
        filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 4.0),
        child: Container(
          //width: 200,
          height: widget.height,
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
              color: const Color(0xFF4B6EAF),
              borderRadius: BorderRadius.circular(0),
              gradient: LinearGradient(colors: [
                Color(0xEF363E51),
                Color(0xEF191E26),
              ])),
          child: CustomPaint(
            painter: ClipperBorderPainter(),
            child: Stack(
              children: [
                // Product image
                Positioned(
                  top: 20,
                  left: 0,
                  right: 0,
                  height: 120,
                  child: Center(
                    child: /*SvgPicture.asset(
                      widget.imagePath,
                      semanticsLabel: 'hi',
                      colorFilter:
                          const ColorFilter.mode(Colors.red, BlendMode.srcIn),
                      height: 100,
                      width: 100,
                    )*/
                        Image.asset(
                      widget.imagePath,
                      /*                    errorBuilder: (context, error, stackTrace) {
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
                      }*/
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

// Custom clipper for asymmetric corners
class AsymmetricRectangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // The left side is shifted down by 10 pixels
    final leftShift = 20.0;

    final curve = 20.0;

    // Top-left (shifted down)
    path.moveTo(0, leftShift + curve);

    path.arcToPoint(Offset(leftShift, leftShift), radius: Radius.circular(20));

    // Top-right
    path.lineTo(size.width - curve, 0);

    path.arcToPoint(Offset(size.width, leftShift), radius: Radius.circular(20));

    // Bottom-right
    path.lineTo(size.width, size.height - leftShift - curve);

    path.arcToPoint(Offset(size.width - curve, size.height - leftShift),
        radius: Radius.circular(20));
    // Bottom-left (shifted down)
    path.lineTo(0 + leftShift, size.height);

    path.arcToPoint(Offset(0, size.height - 20), radius: Radius.circular(20));

    // Close the path
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class CategoryButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryButton({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF34C8E8), Color(0xFF4E4AF2)])
              : LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF363E51), Color(0xFF191E26)]),
          color: isSelected
              ? const Color(0xFF4B6EAF) /*const Color(0xFF4B89DC)*/
              : const Color(0xFF262F45),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.white,
            size: isSelected ? 28 : 24,
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// void main() {
//   runApp(const HelmetCardApp());
// }

// class HelmetCardApp extends StatelessWidget {
//   const HelmetCardApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Helmet Card',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         scaffoldBackgroundColor: const Color(0xFF1D2331),
//         fontFamily: 'SF Pro Display',
//         useMaterial3: true,
//       ),
//       home: const HelmetCardDemo(),
//     );
//   }
// }

// class HelmetCardDemo extends StatefulWidget {
//   const HelmetCardDemo({super.key});

//   @override
//   State<HelmetCardDemo> createState() => _HelmetCardDemoState();
// }

// class _HelmetCardDemoState extends State<HelmetCardDemo> {
//   bool isFavorite = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Helmet Card Shape', style: TextStyle(color: Colors.white)),
//         backgroundColor: const Color(0xFF1D2331),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(24.0),
//           child: HelmetCard(
//             isFavorite: isFavorite,
//             onFavoriteToggle: () {
//               setState(() {
//                 isFavorite = !isFavorite;
//               });
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

// class HelmetCard extends StatelessWidget {
//   final bool isFavorite;
//   final VoidCallback onFavoriteToggle;

//   const HelmetCard({
//     super.key,
//     required this.isFavorite,
//     required this.onFavoriteToggle,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 200,
//       height: 240,
//       child: Stack(
//         children: [
//           // Custom shaped card
//           ClipPath(
//             clipper: HelmetCardClipper(),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: const Color(0xFF3C5AA8),
//                 gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: [
//                     const Color(0xFF3C5AA8),
//                     const Color(0xFF2A3F7D),
//                   ],
//                 ),
//               ),
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 80), // Space for the helmet image
//                   const Spacer(),
//                   Text(
//                     'Road Helmet',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.white.withOpacity(0.7),
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   const Text(
//                     'SMITH - Trade',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   const Text(
//                     '\$ 120',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           // Helmet image
//           Positioned(
//             top: 20,
//             left: 0,
//             right: 0,
//             child: Image.asset(
//               'assets/helmet.png',
//               height: 110,
//               fit: BoxFit.contain,
//               // For demo purposes, we'll use a placeholder if image not available
//               errorBuilder: (context, error, stackTrace) {
//                 return Container(
//                   height: 110,
//                   decoration: const BoxDecoration(
//                     color: Colors.white,
//                     shape: BoxShape.circle,
//                   ),
//                   child: const Center(
//                     child: Icon(
//                       Icons.sports_motorsports,
//                       size: 60,
//                       color: Color(0xFF3C5AA8),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),

//           // Favorite button
//           Positioned(
//             top: 16,
//             right: 16,
//             child: GestureDetector(
//               onTap: onFavoriteToggle,
//               child: Container(
//                 width: 36,
//                 height: 36,
//                 decoration: const BoxDecoration(
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(
//                   isFavorite ? Icons.favorite : Icons.favorite_border,
//                   color: Colors.white,
//                   size: 24,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class HelmetCardClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();

//     // Move to starting point (top left with some padding)
//     path.moveTo(0, size.height * 0.1);

//     // Add a curved line to top right
//     path.quadraticBezierTo(
//       size.width * 0.03, 0,
//       size.width * 0.15, 0
//     );

//     // Line to top right corner (with rounded edge)
//     path.lineTo(size.width * 0.85, 0);

//     // Curve the top right corner
//     path.quadraticBezierTo(
//       size.width * 0.97, 0,
//       size.width, size.height * 0.1
//     );

//     // Line to bottom right (with slight curve)
//     path.lineTo(size.width, size.height * 0.9);

//     // Curve the bottom right corner
//     path.quadraticBezierTo(
//       size.width, size.height,
//       size.width * 0.85, size.height
//     );

//     // Line to bottom left (with rounded edge)
//     path.lineTo(size.width * 0.15, size.height);

//     // Curve the bottom left corner
//     path.quadraticBezierTo(
//       0, size.height,
//       0, size.height * 0.9
//     );

//     // Close the path by going back to start
//     path.close();

//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => true;
// }

// // More advanced transformed card shape using Matrix4 transformations
// class HelmetCard2 extends StatelessWidget {
//   final bool isFavorite;
//   final VoidCallback onFavoriteToggle;

//   const HelmetCard2({
//     super.key,
//     required this.isFavorite,
//     required this.onFavoriteToggle,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Transform(
//       alignment: Alignment.center,
//       transform: Matrix4.identity()
//         ..setEntry(3, 2, 0.001) // Perspective
//         ..rotateY(0.05) // Slight Y rotation
//         ..rotateX(-0.02) // Slight X rotation
//         ..scale(1.0), // Maintain original size
//       child: Container(
//         width: 200,
//         height: 240,
//         decoration: BoxDecoration(
//           color: const Color(0xFF3C5AA8),
//           borderRadius: BorderRadius.circular(24),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.2),
//               offset: const Offset(0, 4),
//               blurRadius: 8,
//             ),
//           ],
//         ),
//         child: Stack(
//           children: [
//             // Content
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 80), // Space for the helmet image
//                   const Spacer(),
//                   Text(
//                     'Road Helmet',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.white.withOpacity(0.7),
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   const Text(
//                     'SMITH - Trade',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   const Text(
//                     '\$ 120',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             // Helmet image
//             Positioned(
//               top: 20,
//               left: 0,
//               right: 0,
//               child: Image.asset(
//                 'assets/helmet.png',
//                 height: 110,
//                 fit: BoxFit.contain,
//                 errorBuilder: (context, error, stackTrace) {
//                   return Container(
//                     height: 110,
//                     decoration: const BoxDecoration(
//                       color: Colors.white,
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Center(
//                       child: Icon(
//                         Icons.sports_motorsports,
//                         size: 60,
//                         color: Color(0xFF3C5AA8),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),

//             // Favorite button
//             Positioned(
//               top: 16,
//               right: 16,
//               child: GestureDetector(
//                 onTap: onFavoriteToggle,
//                 child: Container(
//                   width: 36,
//                   height: 36,
//                   decoration: const BoxDecoration(
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(
//                     isFavorite ? Icons.favorite : Icons.favorite_border,
//                     color: Colors.white,
//                     size: 24,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // import 'dart:async';
// // import 'dart:typed_data';

// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'dart:ui' as ui;

// // const kCanvasSize = 300.0;

// // void main()  {
// //   runApp(MyApp());
// // }

// // class MyApp  extends StatelessWidget {
// //    @override
// //    Widget build(BuildContext context) {
// //             return MaterialApp(
// //               home: SlantedCardDemo()
// //             );
// //           }
// // }

// // class SlantedCardDemo extends StatelessWidget {
// //   const SlantedCardDemo({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: const Color(0xFF10182F),
// //       body: Center(
// //         child: ClipPath(
// //           clipper: SlantedCornerClipper(),
// //           child: Container(
// //             width: 170,
// //             height: 220,
// //             decoration: const BoxDecoration(
// //               gradient: LinearGradient(
// //                 colors: [Color(0xFF1E2A47), Color(0xFF2A3F68)],
// //                 begin: Alignment.topLeft,
// //                 end: Alignment.bottomRight,
// //               ),
// //             ),
// //             padding: const EdgeInsets.all(12),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 const Align(
// //                   alignment: Alignment.topRight,
// //                   child: Icon(Icons.favorite_border, color: Colors.white),
// //                 ),
// //                 const SizedBox(height: 8),
// //                 Center(
// //                   child: Image.asset(
// //                     'assets/helmet.png', // Replace with your image
// //                     height: 70,
// //                     fit: BoxFit.contain,
// //                   ),
// //                 ),
// //                 const SizedBox(height: 12),
// //                 const Text(
// //                   'Road Helmet',
// //                   style: TextStyle(color: Colors.white60, fontSize: 12),
// //                 ),
// //                 const Text(
// //                   'SMITH – Trade',
// //                   style: TextStyle(
// //                       color: Colors.white,
// //                       fontWeight: FontWeight.bold,
// //                       fontSize: 14),
// //                 ),
// //                 const Text(
// //                   '\$120',
// //                   style: TextStyle(color: Colors.white, fontSize: 12),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // class SlantedCornerClipper extends CustomClipper<Path> {
// //   @override
// //   Path getClip(Size size) {
// //     const double curveRadius = 20;
// //     const double slantOffset = 30;

// //     Path path = Path();
// //     path.moveTo(0, slantOffset); // Top-left slant
// //     path.quadraticBezierTo(0, 25, slantOffset, 20);

// //     path.lineTo(size.width - curveRadius, 0);
// //     path.quadraticBezierTo(
// //         size.width, 0, size.width, curveRadius); // Top-right round

// //     path.lineTo(size.width, size.height - slantOffset); // Bottom-right slant
// //     path.quadraticBezierTo(
// //         size.width, size.height, size.width - slantOffset, size.height);

// //     path.lineTo(curveRadius, size.height);
// //     path.quadraticBezierTo(
// //         0, size.height, 0, size.height - curveRadius); // Bottom-left round

// //     path.close();
// //     return path;
// //   }

// //   @override
// //   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// // }

// // // class CustomClippedCard extends StatelessWidget {
// // //   const CustomClippedCard({super.key});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       body: Center(
// // //         child: ClipPath(
// // //           clipper: SlantedBorderClipper(),
// // //           child: Container(
// // //             width: 170,
// // //             height: 220,
// // //             padding: const EdgeInsets.all(12),
// // //             decoration: const BoxDecoration(
// // //               gradient: LinearGradient(
// // //                 colors: [Color(0xFF1E2A47), Color(0xFF2A3F68)],
// // //                 begin: Alignment.topLeft,
// // //                 end: Alignment.bottomRight,
// // //               ),
// // //             ),
// // //             child: Column(
// // //               crossAxisAlignment: CrossAxisAlignment.start,
// // //               children: [
// // //                 const Align(
// // //                   alignment: Alignment.topRight,
// // //                   child: Icon(Icons.favorite_border, color: Colors.white),
// // //                 ),
// // //                 const SizedBox(height: 8),
// // //                 Center(
// // //                   child: Image.asset(
// // //                     'assets/helmet.png', // Update with your actual asset
// // //                     height: 70,
// // //                   ),
// // //                 ),
// // //                 const SizedBox(height: 12),
// // //                 const Text(
// // //                   'Road Helmet',
// // //                   style: TextStyle(color: Colors.white60, fontSize: 12),
// // //                 ),
// // //                 const Text(
// // //                   'SMITH – Trade',
// // //                   style: TextStyle(
// // //                       color: Colors.white,
// // //                       fontWeight: FontWeight.bold,
// // //                       fontSize: 14),
// // //                 ),
// // //                 const Text(
// // //                   '\$120',
// // //                   style: TextStyle(color: Colors.white, fontSize: 12),
// // //                 ),
// // //               ],
// // //             ),
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // // class SlantedBorderClipper extends CustomClipper<Path> {
// // //   @override
// // //   Path getClip(Size size) {
// // //     const double bigRadius = 26;
// // //     const double smallRadius = 12;

// // //     final path = Path();

// // //     // Start top-left with large curve
// // //     path.moveTo(0, bigRadius);
// // //     path.quadraticBezierTo(0, 0, bigRadius, 0);

// // //     // Top-right with small curve
// // //     path.lineTo(size.width - smallRadius, 0);
// // //     path.quadraticBezierTo(
// // //         size.width, 0, size.width, smallRadius);

// // //     // Bottom-right with large curve
// // //     path.lineTo(size.width, size.height - bigRadius);
// // //     path.quadraticBezierTo(size.width, size.height,
// // //         size.width - bigRadius, size.height);

// // //     // Bottom-left with small curve
// // //     path.lineTo(smallRadius, size.height);
// // //     path.quadraticBezierTo(
// // //         0, size.height, 0, size.height - smallRadius);

// // //     path.close();
// // //     return path;
// // //   }

// // //   @override
// // //   bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
// // // }

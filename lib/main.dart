import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alcaldias/views/pagos-pendientes.view.dart';
import 'package:alcaldias/views/pagos-realizados.view.dart';
import 'package:alcaldias/views/propiedades.views.dart';
import 'package:alcaldias/views/user.login.view.dart';
import 'package:alcaldias/views/user.profile.view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: false,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Alcaldías',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            scaffoldBackgroundColor: Color(0xFFFDF5E6),
          ),
          home: const HomeScreen(),
        );
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen();

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Buenos días,';
    } else if (hour < 18) {
      return 'Buenas tardes,';
    } else {
      return 'Buenas noches,';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: BackgroundPainter(),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: WaveClipper(),
              child: Container(
                height: 150.h,
                color: Colors.orange.shade200,
              ),
            ),
          ),
          Positioned(
            top: 30.h,
            left: 20.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getGreeting(),
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  'Usuario',
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 150.h,
            left: 0,
            right: 0,
            bottom: 120.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: _buildMenuItem(
                          icon: Icons.attach_money,
                          text: 'Pagos\npendientes',
                          color: Color.fromARGB(255, 208, 225, 238),
                          onTap: () {
                            Get.to(() => PagosPendientes(
                                nombreContribuyente: 'Usuario'));
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: _buildMenuItem(
                          icon: Icons.payment,
                          text: 'Pagos\nrealizados',
                          color: Color.fromARGB(255, 208, 225, 238),
                          onTap: () {
                            Get.to(() => PagosRealizados(
                                nombreContribuyente: 'Usuario'));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: _buildMenuItem(
                    icon: Icons.location_on,
                    text: 'Mis\npropiedades',
                    color: Color.fromARGB(255, 208, 225, 238),
                    onTap: () {
                      Get.to(() => Propiedad(nombreContribuyente: 'Usuario'));
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: InvertedWaveClipper(),
              child: Container(
                height: 120.h,
                color: Colors.orange.shade200,
              ),
            ),
          ),
          Positioned(
            bottom: 20.h,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.person, color: Colors.black87),
                    onPressed: () {
                      Get.to(() => UserProfileView());
                    },
                    splashColor: Colors.grey.shade200,
                    highlightColor: Colors.grey.shade400,
                  ),
                  IconButton(
                    icon: Icon(Icons.home, color: Colors.black87),
                    onPressed: () {
                      Get.to(() => HomeScreen());
                    },
                    splashColor: Colors.grey.shade200,
                    highlightColor: Colors.grey.shade400,
                  ),
                  IconButton(
                    icon: Icon(Icons.logout, color: Colors.black87),
                    onPressed: () {
                      Get.offAll(() => Login());
                    },
                    splashColor: Colors.grey.shade200,
                    highlightColor: Colors.grey.shade400,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String text,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150.w, // Ancho ajustado para los ítems
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 6,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36.sp, color: Colors.black87),
            SizedBox(height: 10.h),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height - 40);
    path.quadraticBezierTo(
        3 / 4 * size.width, size.height - 80, size.width, size.height - 40);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class InvertedWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, 40);
    path.quadraticBezierTo(size.width / 4, 0, size.width / 2, 40);
    path.quadraticBezierTo(3 / 4 * size.width, 80, size.width, 40);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    const double hexagonSize = 50;
    const double spacing = 20;
    final double xOffset = hexagonSize * 0.75;

    for (double y = -hexagonSize;
        y < size.height + hexagonSize;
        y += hexagonSize + spacing) {
      for (double x = -hexagonSize;
          x < size.width + hexagonSize;
          x += xOffset) {
        _drawHexagon(canvas, Offset(x, y), hexagonSize, paint);
      }
    }
  }

  void _drawHexagon(Canvas canvas, Offset center, double size, Paint paint) {
    final path = Path();
    for (int i = 0; i < 6; i++) {
      final angle = (i * 60) * (3.141592653589793 / 180);
      final x = center.dx + size * cos(angle);
      final y = center.dy + size * sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

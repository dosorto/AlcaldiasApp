import 'package:alcaldias/views/user.login.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alcaldias/models/contribuyente.model.dart';
import 'package:alcaldias/controllers/user.profile.controller.dart';
import 'package:get/get.dart';

class UserProfileView extends StatelessWidget {
  final String token; // Simula obtener el token

  UserProfileView({required this.token});

  final ContribuyenteController contribuyenteController =
      ContribuyenteController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Contribuyente>(
        future: contribuyenteController.getContribuyente(token),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(
                child: Text('No se encontraron datos del contribuyente.'));
          }

          Contribuyente contribuyente = snapshot.data!;
          return Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: ClipPath(
                  clipper: WaveClipper(),
                  child: Container(
                    height: 150.h,
                    color: const Color.fromARGB(255, 71, 161, 220),
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
                      'Perfil del Usuario',
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      'Detalles del Usuario',
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
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),
                      _buildInfoCard(
                          'Identidad:', contribuyente.identidad ?? 'N/A'),
                      SizedBox(height: 15.h),
                      _buildInfoCard(
                        'Nombre:',
                        contribuyente.primerNombre != null &&
                                contribuyente.primerApellido != null
                            ? '${contribuyente.primerNombre} ${contribuyente.primerApellido}'
                            : 'N/A',
                      ),
                      _buildInfoCard(
                        'Impuesto Personal:',
                        contribuyente.impuestoPersonal != null
                            ? contribuyente.impuestoPersonal.toString()
                            : 'N/A',
                      ),
                      _buildInfoCard(
                        'Teléfono:',
                        contribuyente.telefono != null
                            ? contribuyente.telefono.toString()
                            : 'N/A',
                      ),
                      _buildInfoCard(
                        'Dirección:',
                        contribuyente.direccion != null
                            ? contribuyente.direccion.toString()
                            : 'N/A',
                      ),
                      _buildInfoCard(
                        'Email:',
                        contribuyente.email != null
                            ? contribuyente.email.toString()
                            : 'N/A',
                      ),
                    ],
                  ),
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
                    color: const Color.fromARGB(255, 71, 161, 220),
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
                        onPressed: () {},
                        splashColor: Colors.grey.shade200,
                        highlightColor: Colors.grey.shade400,
                      ),
                      IconButton(
                        icon: Icon(Icons.home, color: Colors.black87),
                        onPressed: () {
                          Navigator.pop(context);
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
          );
        },
      ),
    );
  }

  Widget _buildInfoCard(String title, String content) {
    return Container(
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: Colors.brown.shade300.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          color: Colors.black87,
          width: 1.5.w,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Text(
              content,
              style: TextStyle(
                fontSize: 18.sp,
                color: Colors.black87,
              ),
            ),
          ),
        ],
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

import 'package:alcaldias/views/pagos-pendientes.view.dart';
import 'package:alcaldias/views/propiedades.vies.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alcaldias/views/pagos-realizados.view.dart';
import 'package:alcaldias/views/user.login.view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'alcaldias',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: Login(),
        );
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150.0.h),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40.0.r),
              bottomRight: Radius.circular(40.0.r),
            ),
            child: Container(
              color: Colors.orange.shade100,
              alignment: Alignment.center,
              padding: EdgeInsets.all(16.0.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Bienvenido,",
                    style: TextStyle(
                        fontSize: 24.0.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0.h),
                  Text(
                    "Usuario", // Aquí puedes poner la variable de nombre
                    style: TextStyle(fontSize: 18.0.sp, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 16.0.w),
              child: PopupMenuButton<int>(
                icon: CircleAvatar(
                  radius: 20.0.w,
                  backgroundImage: AssetImage('assets/images/logo.png'),
                ),
                onSelected: (item) => _onSelected(context, item),
                itemBuilder: (context) => [
                  PopupMenuItem<int>(value: 0, child: Text('Perfil')),
                  PopupMenuItem<int>(value: 1, child: Text('Cerrar sesión')),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildMenuItem(
              icon: Icons.attach_money,
              text: 'Pagos pendientes',
              color: Colors.blue.shade100,
              onTap: () {
                Get.to(() => PagosPendientes(
                    nombreContribuyente:
                        'Usuario')); //Traer el id del usuario para que salga el nombre.
              },
            ),
            SizedBox(height: 16.0.h),
            _buildMenuItem(
              icon: Icons.payment,
              text: 'Pagos realizados',
              color: Colors.blue.shade100,
              onTap: () {
                Get.to(() => PagosRealizados(
                    nombreContribuyente: 'Usuario')); //Traer nombre del usuario
              },
            ),
            SizedBox(height: 16.0.h),
            _buildMenuItem(
              icon: Icons.home,
              text: 'Propiedades',
              color: Colors.blue.shade100,
              onTap: () {
                Get.to(() => Propiedad(
                    nombreContribuyente: 'Usuario')); //Traer nombre del usuario
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String text,
    required Color color,
    required VoidCallback onTap,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(16.0.w),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12.0.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(icon, size: 24.0.w, color: Colors.black54),
              SizedBox(width: 16.0.w),
              Text(
                text,
                style: TextStyle(
                  fontSize: 16.0.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        //Get.to(() => ProfileScreen(userData: userData));
        break;
      case 1:
        // cerrar sesión
        Get.offAll(() => Login());
        break;
    }
  }
}

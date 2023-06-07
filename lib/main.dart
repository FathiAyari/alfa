import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/Accueil.dart';
import 'package:flutter_application_1/screen/LoginPage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Mon application',
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isLoading = true;
  var user = GetStorage().read("user");
  @override
  void initState() {
    super.initState();
    // Temps d'attente de 3 secondes pour l'écran de chargement
    Future.delayed(Duration(seconds: 5), () {
      if (user != null) {
        Get.to(Accueil());
      } else {
        Get.to(LoginPage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitCircle(
          color: Colors.blue,
          size: 50.0,
        ),
      ),
    );
  }
}

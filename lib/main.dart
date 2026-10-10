import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart'; // File tự sinh ra bởi FlutterFire CLI
import 'services/auth_service.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';

void main() async {
  // BẮT BUỘC: Đảm bảo Flutter bindings được khởi tạo trước khi gọi Firebase
  WidgetsFlutterBinding.ensureInitialized();

  // Khởi tạo Firebase với cấu hình tự sinh từ FlutterFire CLI
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Khởi tạo Google Sign-In (bắt buộc với google_sign_in v7.x)
  await AuthService().initializeGoogleSignIn();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Buddy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1565C0)),
        useMaterial3: true,
      ),
      // StreamBuilder lắng nghe trạng thái auth:
      // - Nếu user != null (đã đăng nhập) -> HomeScreen
      // - Nếu user == null (chưa đăng nhập) -> LoginScreen
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Đang kiểm tra trạng thái -> hiện loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          // Đã đăng nhập -> vào HomeScreen
          if (snapshot.hasData) {
            return const HomeScreen();
          }

          // Chưa đăng nhập -> vào LoginScreen
          return const LoginScreen();
        },
      ),
    );
  }
}

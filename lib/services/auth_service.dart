import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart'; // Để dùng kIsWeb

/// Service xử lý toàn bộ logic Authentication.
/// Tách biệt khỏi UI để dễ bảo trì và test.
class AuthService {
  // Singleton pattern - chỉ tạo 1 instance duy nhất trong toàn app
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  // Hai đối tượng chính để xử lý auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // google_sign_in v7.x dùng singleton, không còn constructor
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  /// Lấy user hiện tại (null nếu chưa đăng nhập)
  User? get currentUser => _firebaseAuth.currentUser;

  /// Stream theo dõi trạng thái đăng nhập (dùng cho StreamBuilder ở UI)
  /// Mỗi khi user đăng nhập/đăng xuất, stream sẽ phát ra giá trị mới.
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  /// Khởi tạo GoogleSignIn — gọi 1 lần trước khi dùng (trong main.dart)
  Future<void> initializeGoogleSignIn() async {
    await _googleSignIn.initialize(
      clientId: kIsWeb ? '498748171599-8aebndc2h4trrq910jo19aikrj0shk6c.apps.googleusercontent.com' : null,
    );
  }

  /// Đăng nhập bằng Google.
  /// Trả về User nếu thành công, null nếu user huỷ bỏ.
  /// Throw Exception nếu có lỗi.
  Future<User?> signInWithGoogle() async {
    try {
      // Bước 1: Mở popup chọn tài khoản Google (v7.x dùng authenticate())
      final GoogleSignInAccount? googleUser = await _googleSignIn.authenticate();

      // User nhấn nút "Huỷ" trên popup -> trả về null
      if (googleUser == null) {
        return null;
      }

      // Bước 2: Lấy token xác thực từ Google
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Bước 3: Tạo credential cho Firebase từ idToken
      // v7.x: GoogleSignInAuthentication chỉ có idToken (không còn accessToken)
      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      // Bước 4: Đăng nhập vào Firebase bằng credential
      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      // Lỗi từ Firebase (tài khoản bị vô hiệu hoá, token hết hạn,...)
      throw Exception('Lỗi Firebase Auth: ${e.message}');
    } catch (e) {
      // Lỗi khác (mất mạng, PlatformException,...)
      throw Exception('Đăng nhập thất bại: $e');
    }
  }

  /// Đăng xuất khỏi cả Google và Firebase.
  Future<void> signOut() async {
    try {
      // Đăng xuất đồng thời cả hai để tránh trạng thái không đồng bộ
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.disconnect(),
      ]);
    } catch (e) {
      throw Exception('Đăng xuất thất bại: $e');
    }
  }
}

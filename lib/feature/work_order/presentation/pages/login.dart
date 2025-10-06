import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_intern_pdam/core/resource/data_state.dart';
import 'package:mobile_intern_pdam/core/utils/auth_storage.dart';
import 'package:mobile_intern_pdam/feature/work_order/data/data_source/remote/auth_remote_data_source.dart';
import 'package:mobile_intern_pdam/feature/work_order/presentation/pages/root_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2C4A5A), // Dark teal-blue background
              Color(0xFF1A3A4A), // Slightly darker bottom
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const SizedBox(height: 40),
                _buildWaterPattern(),
                const SizedBox(height: 40),
                _buildLoginCard(),
                const SizedBox(height: 30),
                _buildFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWaterPattern() {
    return CustomPaint(
      size: const Size(double.infinity, 200),
      painter: WaterPatternPainter(),
    );
  }

  Widget _buildLoginCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLogo(),
            const SizedBox(height: 32),
            _buildCompanyInfo(),
            const SizedBox(height: 40),
            _buildUsernameField(),
            const SizedBox(height: 24),
            _buildPasswordField(),
            const SizedBox(height: 32),
            _buildLoginButton(),
            const SizedBox(height: 20),
            _buildForgotPasswordLink(),
            const SizedBox(height: 24),
            _buildRegisterLink(),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Center(
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFF2C4A5A), width: 3),
          color: const Color(0xFF4DD0E1), // Light teal-blue
        ),
        child: const Icon(Icons.security, color: Colors.white, size: 40),
      ),
    );
  }

  Widget _buildCompanyInfo() {
    return const Column(
      children: [
        Text(
          'PDAM Surya Sembada',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C4A5A),
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8),
        Text(
          'Portal Work Order',
          style: TextStyle(fontSize: 16, color: Color(0xFF666666)),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildUsernameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Username',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF2C4A5A),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _usernameController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: 'Masukkan username',
            hintStyle: const TextStyle(color: Color(0xFFB0BEC5), fontSize: 14),
            prefixIcon: const Icon(
              Icons.person_outline,
              color: Color(0xFF4DD0E1),
              size: 20,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF4DD0E1), width: 2),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Username harus diisi';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Password',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF2C4A5A),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _passwordController,
          obscureText: !_isPasswordVisible,
          decoration: InputDecoration(
            hintText: 'Masukkan password',
            hintStyle: const TextStyle(color: Color(0xFFB0BEC5), fontSize: 14),
            prefixIcon: const Icon(
              Icons.lock_outline,
              color: Color(0xFF4DD0E1),
              size: 20,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: const Color(0xFF4DD0E1),
                size: 20,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF4DD0E1), width: 2),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Password harus diisi';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleLogin,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFFFF9800), // Orange
                Color(0xFFF44336), // Red
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: _isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : const Text(
                    'Masuk',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildForgotPasswordLink() {
    return Center(
      child: TextButton(
        onPressed: _handleForgotPassword,
        child: const Text(
          'Lupa Password?',
          style: TextStyle(
            color: Color(0xFF00897B), // Teal-green
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterLink() {
    return Center(
      child: RichText(
        text: const TextSpan(
          style: TextStyle(fontSize: 14, color: Color(0xFF666666)),
          children: [
            TextSpan(text: 'Belum punya akun? '),
            TextSpan(
              text: 'Daftar Sekarang',
              style: TextStyle(
                color: Color(0xFF00897B), // Teal-green
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          TextButton.icon(
            onPressed: _testConnection,
            icon: const Icon(Icons.network_check, color: Color(0xFF4DD0E1)),
            label: const Text(
              'Test Koneksi API',
              style: TextStyle(color: Color(0xFF4DD0E1), fontSize: 12),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            '© 2024 PDAM Surya Sembada. Semua hak dilindungi.',
            style: TextStyle(color: Color(0xFFB0BEC5), fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final authDataSource = AuthRemoteDataSource();
        final result = await authDataSource.login(
          email: _usernameController.text.trim(),
          password: _passwordController.text.trim(),
        );

        if (!mounted) return;

        if (result is DataSuccess) {
          final authResponse = result.data!;

          // Save token and user data
          if (authResponse.token != null) {
            AuthStorage.saveToken(authResponse.token!);
          }
          if (authResponse.user != null) {
            AuthStorage.saveUser(authResponse.user!);
          }

          // Show success message
          final message = authResponse.message ?? 'Login berhasil!';
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: const Color(0xFF4CAF50),
              duration: const Duration(seconds: 2),
            ),
          );

          // Navigate to main page
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const RootPage()),
          );
        } else if (result is DataFailed) {
          // Handle login failure
          String errorMessage = 'Email atau password salah';

          if (result.error is DioException) {
            final dioError = result.error as DioException;
            if (dioError.response?.data != null) {
              // Try to extract error message from response
              if (dioError.response?.data is Map) {
                errorMessage =
                    dioError.response?.data['message'] ??
                    dioError.response?.data['error'] ??
                    'Email atau password salah';
              }
            } else if (dioError.type == DioExceptionType.connectionTimeout ||
                dioError.type == DioExceptionType.receiveTimeout) {
              errorMessage = 'Koneksi timeout, periksa koneksi internet Anda';
            } else if (dioError.type == DioExceptionType.connectionError) {
              errorMessage = 'Tidak dapat terhubung ke server';
            }
          }

          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorMessage),
                backgroundColor: const Color(0xFFF44336),
                duration: const Duration(seconds: 3),
              ),
            );
          }
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Terjadi kesalahan: ${e.toString()}'),
              backgroundColor: const Color(0xFFF44336),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  void _handleForgotPassword() {
    // TODO: Implement forgot password logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Fitur lupa password akan segera tersedia'),
        backgroundColor: Color(0xFF2196F3),
      ),
    );
  }

  void _testConnection() async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Menguji koneksi ke server...'),
        backgroundColor: Color(0xFF2196F3),
        duration: Duration(seconds: 2),
      ),
    );

    try {
      final dio = Dio(
        BaseOptions(
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 5),
        ),
      );

      // Test root endpoint
      print('🧪 Testing connection to API server...');
      final response = await dio.get('http://172.30.4.100:8000/api');

      print('✅ Connection successful!');
      print('📥 Response: ${response.data}');

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('✅ Koneksi berhasil!\nStatus: ${response.statusCode}'),
          backgroundColor: const Color(0xFF4CAF50),
          duration: const Duration(seconds: 3),
        ),
      );
    } on DioException catch (e) {
      print('❌ Connection test failed!');
      print('Type: ${e.type}');
      print('Message: ${e.message}');

      String errorMsg = 'Gagal terhubung ke server';
      if (e.type == DioExceptionType.connectionTimeout) {
        errorMsg = 'Timeout - Server tidak merespon';
      } else if (e.type == DioExceptionType.connectionError) {
        errorMsg = 'Error - Tidak dapat terhubung ke http://172.30.4.100:8000';
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('❌ $errorMsg'),
          backgroundColor: const Color(0xFFF44336),
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }
}

class WaterPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF4DD0E1).withOpacity(0.3)
      ..style = PaintingStyle.fill;

    // Draw wave patterns
    final path = Path();
    path.moveTo(0, size.height * 0.7);

    // First wave
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.5,
      size.width * 0.5,
      size.height * 0.7,
    );

    // Second wave
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.9,
      size.width,
      size.height * 0.7,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);

    // Draw scattered dots
    final dotPaint = Paint()
      ..color = const Color(0xFF4DD0E1).withOpacity(0.2)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 20; i++) {
      final x = (i * 37.0) % size.width;
      final y = (i * 23.0) % size.height;
      canvas.drawCircle(Offset(x, y), 3, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

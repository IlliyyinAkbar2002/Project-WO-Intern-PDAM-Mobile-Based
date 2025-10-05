import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
          'Portal Pelanggan',
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
          'Username / Nomor Pelanggan',
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
            hintText: 'Masukkan username atau nomor pelanggan',
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
              return 'Username atau nomor pelanggan harus diisi';
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
    return const Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Text(
        '© 2024 PDAM Surya Sembada. Semua hak dilindungi.',
        style: TextStyle(color: Color(0xFFB0BEC5), fontSize: 12),
        textAlign: TextAlign.center,
      ),
    );
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate login process
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isLoading = false;
      });

      // TODO: Implement actual login logic
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login berhasil!'),
            backgroundColor: Color(0xFF4CAF50),
          ),
        );
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

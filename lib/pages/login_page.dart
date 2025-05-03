import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../main.dart';  // Only needed imports

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final emailController = TextEditingController(text: 'abc@gm.com');
  final passwordController = TextEditingController(text: '1234');
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  bool isLogin = true;
  bool isPasswordVisible = false;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        isLogin = _tabController.index == 0;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  void _handleAuth() {
    if (isLogin) {
      if (emailController.text == 'abc@gm.com' &&
          passwordController.text == '1234') {
        Get.offAll(() => const MainPage());  // Changed from HomePage to MainPage
      } else {
        Get.snackbar(
          'Error',
          'Invalid credentials',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } else {
      if (passwordController.text != confirmPasswordController.text) {
        Get.snackbar(
          'Error',
          'Passwords do not match',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }
      Get.snackbar(
        'Success',
        'Account created successfully! Please sign in.',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      _tabController.animateTo(0);
    }
  }

  void _handleGoogleSignIn() {
    Get.snackbar(
      'Google Sign In',
      'This feature will be implemented soon!',
      backgroundColor: const Color(0xFFD4AF37),
      colorText: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E1),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        // Logo and Title
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFD4AF37).withOpacity(0.2),
                                blurRadius: 20,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: const CircleAvatar(
                            radius: 45,
                            backgroundColor: Color(0xFFD4AF37),
                            child: Icon(
                              Icons.diamond_outlined,
                              size: 50,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Luxury Jewelry',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFD4AF37),
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 40),

                        // Custom Tab Bar
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: DefaultTabController(
                                length: 2,
                                child: TabBar(
                                  controller: _tabController,
                                  indicator: BoxDecoration(
                                    color: const Color(0xFFD4AF37),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  dividerColor: Colors.transparent,
                                  labelColor: Colors.white,
                                  unselectedLabelColor: const Color(0xFF666666),
                                  labelPadding: EdgeInsets.zero,
                                  padding: EdgeInsets.zero,
                                  tabs: [
                                    _buildTab(
                                      "Sign In",
                                      _tabController.index == 0,
                                    ),
                                    _buildTab(
                                      "Sign Up",
                                      _tabController.index == 1,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Form Container
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                child:
                                    isLogin
                                        ? _buildLoginForm()
                                        : _buildSignUpForm(),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // OR Divider
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.grey.shade400,
                                thickness: 1,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Text(
                                'OR',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.grey.shade400,
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // Google Sign In Button
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: Colors.grey.shade300),
                            color: Colors.white,
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: _handleGoogleSignIn,
                              borderRadius: BorderRadius.circular(25),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 24,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      child: const Icon(
                                        Icons.g_mobiledata_rounded,
                                        color: Colors.red,
                                        size: 28,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    const Text(
                                      'Continue with Google',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoginForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildTextField(
          controller: emailController,
          label: 'Email',
          icon: Icons.email,
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: passwordController,
          label: 'Password',
          icon: Icons.lock,
          isPassword: true,
        ),
        const SizedBox(height: 24),
        _buildAuthButton('Sign In'),
      ],
    );
  }

  Widget _buildSignUpForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildTextField(
          controller: nameController,
          label: 'Full Name',
          icon: Icons.person,
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: emailController,
          label: 'Email',
          icon: Icons.email,
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: passwordController,
          label: 'Password',
          icon: Icons.lock,
          isPassword: true,
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: confirmPasswordController,
          label: 'Confirm Password',
          icon: Icons.lock,
          isPassword: true,
        ),
        const SizedBox(height: 24),
        _buildAuthButton('Sign Up'),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword && !isPasswordVisible,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey.shade600),
          prefixIcon: Icon(icon, color: const Color(0xFFD4AF37)),
          suffixIcon:
              isPassword
                  ? IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: const Color(0xFFD4AF37),
                    ),
                    onPressed:
                        () => setState(
                          () => isPasswordVisible = !isPasswordVisible,
                        ),
                  )
                  : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildAuthButton(String text) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFD4AF37), Color(0xFFFFD700)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD4AF37).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _handleAuth,
          borderRadius: BorderRadius.circular(25),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTab(String text, bool isSelected) {
    return Container(
      height: 46,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: isSelected ? const Color(0xFFD4AF37) : Colors.transparent,
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF666666),
            fontSize: 15,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

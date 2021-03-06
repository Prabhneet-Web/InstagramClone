import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/resources/authMethods.dart';
import 'package:instagram_clone/screens/signUpScreen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/textFieldInput.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethod().loginUser(
        email: _emailController.text, password: _passwordController.text);
    if (res == "success") {
    } else {
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      width: double.infinity,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(child: Container(), flex: 2),
          //svg image,
          SvgPicture.asset('lib/assets/images/Instagram.svg',
              color: primaryColor, height: 64),
          const SizedBox(height: 64),
          //TextField for email,
          TextFieldInput(
              textEditingController: _emailController,
              hintText: "Enter your email",
              textInputType: TextInputType.emailAddress),
          const SizedBox(height: 24),
          //TextField for password,
          TextFieldInput(
            textEditingController: _passwordController,
            hintText: "Enter your password",
            textInputType: TextInputType.text,
            isPass: true,
          ),
          const SizedBox(height: 24),
          //Button for login,
          InkWell(
            onTap: loginUser,
            child: Container(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator(color: primaryColor))
                  : const Text("Log in"),
              width: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  color: blueColor),
            ),
          ),
          const SizedBox(height: 12),
          Flexible(child: Container(), flex: 2),
          //Transtioning for SignUp
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: const Text("Don't have an account?"),
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
              const SizedBox(width: 2),
              GestureDetector(
                onTap: () => const SignUpScreen(),
                child: Container(
                  child: const Text("Sign Up",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
              )
            ],
          )
        ],
      ),
    )));
  }
}

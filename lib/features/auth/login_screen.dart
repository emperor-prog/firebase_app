import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/custom_button.dart';
import 'package:flutter_application_1/common/custom_testfield.dart';
import 'package:flutter_application_1/features/auth/widgets/social_icon.dart';
import 'package:flutter_application_1/services/firebase_auth_methods.dart';
import 'package:flutter_application_1/utils/custom_color.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void loginWithEmail() async {
    await FirebaseAuthMethods(FirebaseAuth.instance).signInWithEmail(
        email: emailController.text,
        password: passwordController.text,
        context: context);
  }

  void signInWithGoogle() async {
    await FirebaseAuthMethods(FirebaseAuth.instance)
        .signInWithGoogle(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: CustomColor.textBlackColor,
            )),
        backgroundColor: CustomColor.appBackGroundColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Form(
            key: _loginFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Login",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter email address.";
                    } else {
                      return null;
                    }
                  },
                  labelText: 'Email',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: passwordController,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 8) {
                      return "Password must be atleast 8 characters long.";
                    } else {
                      return null;
                    }
                  },
                  isObscured: true,
                  labelText: 'Password',
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      alignment: Alignment.topRight,
                      child: Text(
                        "Forgot your password?",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_sharp,
                      color: CustomColor.appButtonColor,
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                  buttonText: 'LOGIN',
                  onPressed: () {
                    if (_loginFormKey.currentState!.validate()) {
                      loginWithEmail();
                    }
                  },
                ),
                const SizedBox(
                  height: 100,
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'Or login with social account',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialIcon(
                        onTap: signInWithGoogle,
                        url:
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/2048px-Google_%22G%22_Logo.svg.png'),
                    const SizedBox(
                      width: 10,
                    ),
                    const SocialIcon(
                        url:
                            'https://cdn-icons-png.flaticon.com/512/124/124010.png')
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

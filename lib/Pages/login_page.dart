import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/Pages/chat_page.dart';
import 'package:scholar_chat/Pages/reigster_page.dart';
import 'package:scholar_chat/constans.dart';
import 'package:scholar_chat/helper/show_sncak_bar.dart';
import 'package:scholar_chat/widgets/logo.dart';
import 'package:scholar_chat/widgets/my_button.dart';
import 'package:scholar_chat/widgets/my_button_google.dart';
import 'package:scholar_chat/widgets/or_continue_with.dart';
import 'package:scholar_chat/widgets/text_form_field_with_title.dart';

class LoginPage extends StatefulWidget {
  static String id = 'LoginPage';
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoding = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoding,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                //Space
                const SizedBox(
                  height: 10,
                ),

                //logo
                const Logo(),

                //Space
                const SizedBox(
                  height: 50,
                ),

                //Text Sign in
                const Text(
                  "Welcome Back!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontFamily: "",
                  ),
                ),

                //Space
                const SizedBox(
                  height: 5,
                ),

                //Email
                TextFormFieldWithTitle(
                  controller: emailTextController,
                  title: "Email Adress",
                  hintText: "Email Adress",
                  prefixIcon: Iconsax.user_tag,
                ),

                //Space
                const SizedBox(
                  height: 20,
                ),

                //Password
                TextFormFieldWithTitle(
                  obscureText: true,
                  controller: passwordTextController,
                  title: "Password",
                  hintText: "  Password",
                  prefixIcon: Iconsax.lock4,
                  suffixicon: Iconsax.eye_slash,
                ),

                //Forget Password?
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Forget Password?",
                        style: TextStyle(
                          color: Color(0xff8CAAB9),
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),

                // Space
                const SizedBox(
                  height: 5,
                ),
                //Button Sign in
                MyButton(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      //Show the loading indicator
                      isLoding = true;
                      //علشان يحدث الواجه ويبان مؤشر التحميل
                      setState(() {});
                      try {
                        await loginUser();
                        Navigator.pushNamed(
                          context,
                          ChatPage.id,
                          arguments: emailTextController.text,
                        );
                      } on FirebaseAuthException catch (ex) {
                        if (ex.code == 'user-not-found') {
                          showSnackBar(
                              context, "No user found for that email. :( !!");
                        } else if (ex.code == 'wrong-password') {
                          showSnackBar(context, "wrong-password");
                        } else {
                          showSnackBar(context,
                              "The password or email that you've entered is incorrect.");
                        }
                      } catch (ex) {
                        showSnackBar(context, "There was an error");
                      }
                    }
                    //colse the loading indicator
                    isLoding = false;
                    //علشان يحدث الواجه ويبان مؤشر التحميل
                    setState(() {});
                  },
                  text: "Log in",
                ),

                //Space
                const SizedBox(
                  height: 20,
                ),

                // Or continue with
                const OrContinueWith(),

                //Space
                const SizedBox(
                  height: 20,
                ),

                //google
                const MyButtonGoogle(),

                //Space
                const SizedBox(
                  height: 10,
                ),

                //Don’t have an account? Sign Up
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don’t have an account?",
                      style: TextStyle(
                        color: Color(0xff8CAAB9),
                        fontSize: 18,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RegisterPage.id);
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Color(0xffFEA92E),
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailTextController.text,
      password: passwordTextController.text,
    );
  }
}

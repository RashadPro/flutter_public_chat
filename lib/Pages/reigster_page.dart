import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:scholar_chat/Pages/login_page.dart';
import 'package:scholar_chat/constans.dart';
import 'package:scholar_chat/helper/show_sncak_bar.dart';
import 'package:scholar_chat/widgets/logo.dart';
import 'package:scholar_chat/widgets/my_button.dart';
import 'package:scholar_chat/widgets/my_button_google.dart';
import 'package:scholar_chat/widgets/text_form_field_with_title.dart';

class RegisterPage extends StatefulWidget {
  static String id = 'RegisterPage';
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoding = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Logo
                const Logo(),
                // Welcome Back!
                const Text(
                  "Create your account",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontFamily: "",
                  ),
                ),
                // Space
                const SizedBox(
                  height: 5,
                ),
                //Full Name
                const TextFormFieldWithTitle(
                  title: "Full Name",
                  hintText: "Fazil Laghari",
                  prefixIcon: Iconsax.user_tag,
                ),
                // Space
                const SizedBox(
                  height: 10,
                ),
                //Email Address
                TextFormFieldWithTitle(
                  controller: emailTextController,
                  title: "Email Adress",
                  hintText: "m.ahmed3209@su.edu.eg",
                  prefixIcon: Iconsax.user_tag,
                ),
                // Space
                const SizedBox(
                  height: 10,
                ),
                //Password
                TextFormFieldWithTitle(
                  obscureText: true,
                  controller: passwordTextController,
                  title: "Password",
                  hintText: "  • • • • • • • • • • • •",
                  prefixIcon: Iconsax.lock4,
                  suffixicon: Iconsax.eye_slash,
                ),
                const SizedBox(
                  height: 15,
                ),
                //I have read & agreed to DayTask Privacy Policy, Terms & Condition
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Iconsax.tick_square,
                          color: Color(0xffFEA92E),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "I have read & agreed to DayTask",
                          style: TextStyle(
                            color: Color(0xff8CAAB9),
                            fontSize: 15,
                            fontFamily: "Inter",
                          ),
                        ),
                        Text(
                          " Privacy Policy",
                          style: TextStyle(
                            color: Color(0xffFEA92E),
                            fontSize: 15,
                            fontFamily: "Inter",
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 28),
                      child: Text(
                        "Terms & Condition",
                        style: TextStyle(
                          color: Color(0xffFEA92E),
                          fontSize: 15,
                          fontFamily: "Inter",
                        ),
                      ),
                    )
                  ],
                ),
                // Space
                const SizedBox(
                  height: 15,
                ),
                //Login
                MyButton(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      //Show the loading indicator
                      isLoding = true;
                      //علشان يحدث الواجه ويبان مؤشر التحميل
                      setState(() {});
                      try {
                        await registerUser();
                        Navigator.pushNamed(context, LoginPage.id);
                        showSnackBar(context, "Account created :)");
                      } on FirebaseAuthException catch (ex) {
                        if (ex.code == 'weak-password') {
                          showSnackBar(context, "Weak password :/!");
                        } else if (ex.code == 'email-already-in-use') {
                          showSnackBar(context, "Email Already In Use :/!");
                        }
                      } catch (ex) {
                        showSnackBar(context, "There was an error!");
                      }
                    }
                    //colse the loading indicator
                    isLoding = false;
                    //علشان يحدث الواجه ويبان مؤشر التحميل
                    setState(() {});
                  },
                  text: "Sign Up",
                ),
                //Space
                const SizedBox(
                  height: 15,
                ),
                // Or continue with
                const Row(
                  children: [
                    //Line
                    Expanded(
                      child: Divider(
                        color: Color(0xff8CAAB9),
                      ),
                    ),
                    //Or continue with
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Or continue with",
                        style: TextStyle(
                          color: Color(0xff8CAAB9),
                          fontSize: 18,
                        ),
                      ),
                    ),
                    //Line
                    Expanded(
                        child: Divider(
                      color: Color(0xff8CAAB9),
                    )),
                  ],
                ),
                //Space
                const SizedBox(
                  height: 15,
                ),

                MyButtonGoogle(),
                //Space
                const SizedBox(
                  height: 15,
                ),
                //Don’t have an account? Sign Up
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(
                        color: Color(0xff8CAAB9),
                        fontSize: 18,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                        child: const Text(
                          "Log In",
                          style: TextStyle(
                            color: Color(0xffFEA92E),
                            fontSize: 18,
                          ),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }

  Future<void> registerUser() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailTextController.text,
      password: passwordTextController.text,
    );
  }
}

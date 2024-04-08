import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/constans.dart';
import 'package:scholar_chat/helper/show_sncak_bar.dart';
import 'package:scholar_chat/widgets/logo.dart';
import 'package:scholar_chat/widgets/my_button.dart';
import 'package:scholar_chat/widgets/text_form_field_with_title.dart';

class RegisterPagee extends StatefulWidget {
  // static String id = 'RegisterPage';

  const RegisterPagee({
    super.key,
  });

  @override
  State<RegisterPagee> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPagee> {
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
                  height: 150,
                ),

                //logo
                const Logo(),
                //Space
                const SizedBox(
                  height: 50,
                ),
                //Text Sign in
                const Text(
                  "REGISTER",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                  ),
                ),

                //Space
                const SizedBox(
                  height: 10,
                ),

                //Email
                TextFormFieldWithTitle(
                  controller: emailTextController,
                  hintText: "Email",
                ),

                //Space
                const SizedBox(
                  height: 20,
                ),

                //Password
                TextFormFieldWithTitle(
                  controller: passwordTextController,
                  hintText: "Password",
                ),

                //Space
                const SizedBox(
                  height: 30,
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
                        showSnackBar(context, "Account has created :)");
                      } on FirebaseAuthException catch (ex) {
                        if (ex.code == 'weak-password') {
                          showSnackBar(context, "Weak password :/ !!");
                        } else if (ex.code == 'email-already-in-use') {
                          showSnackBar(context, "Email Already In Use :/ !!");
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
                  text: "REGISTER",
                ),

                //don't have an account Sign Up
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Aleardy have an account?
                    TextButton(
                      onPressed: () {},
                      child: const Center(
                        child: Text(
                          "Aleardy have an account?",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    //Log In
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    )
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

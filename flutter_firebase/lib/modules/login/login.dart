import 'package:flutter/material.dart';
import 'package:flutter_firebase/core/routes/app_routes.dart';
import 'package:flutter_firebase/modules/task/views/detail_task.dart';
import 'package:flutter_firebase/modules/login/login_controller.dart';
import 'package:flutter_firebase/utils/colors.dart';
import 'package:get/get.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String email = ""; //"nurse001@example.com";
  String password = ""; //"nurse001";
  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: const BoxDecoration(
      //   image: DecorationImage(
      //       image: AssetImage("assets/images/healthcare5.png"),
      //       fit: BoxFit.cover),
      // ),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.10),
              child: Container(
                margin: EdgeInsets.only(left: 35, right: 35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Container(
                    //     margin: EdgeInsets.only(left: 35, right: 35),
                    //     height: 65,
                    //     child: Image.asset("assets/images/logo.png")),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: ColorsScheme.primaryColor,
                          borderRadius: BorderRadius.circular(8.0)),
                    ),

                    const SizedBox(height: 40),
                    Column(
                      children: [
                        TextField(
                          controller: emailController,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              hintText: "Email",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                        ),
                        const SizedBox(height: 14),
                        TextField(
                          controller: passwordController,
                          style: TextStyle(),
                          obscureText: true,
                          decoration: InputDecoration(
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              hintText: "Password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Sign in',
                              style: TextStyle(
                                  color: ColorsScheme.primaryColor,
                                  fontSize: 27,
                                  fontWeight: FontWeight.w700),
                            ),
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: ColorsScheme.primaryColor,
                              child: IconButton(
                                  color: Colors.white,
                                  onPressed: () {
                                    if (emailController.text == email &&
                                        passwordController.text == password) {
                                      LoginController().login();
                                      Get.toNamed(Routes.TASKLIST);
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.arrow_forward,
                                  )),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
                height: 300,
                child: Image.asset(
                  "assets/images/healthcare5.png",
                  fit: BoxFit.fitHeight,
                ))
          ],
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';



class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  late String UserEmail, UserPassword;

  getUserEmail(email) {
    UserEmail = email;
  }

  getUserPassword(password) {
    UserPassword = password;
  }

  LoginAccount() {
    print("Login Successful");
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('LoginData').doc(UserEmail);

    //create map
    Map<String, dynamic> students = {
      "email": UserEmail,
      "createpassword": UserPassword,
    };

    documentReference
        .set(students)
        .whenComplete(() => {print("$UserEmail Created")});

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/3.webp'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15, top: 90),
              child: const Text(
                '𝐄𝐧𝐣𝐨𝐲 𝐓𝐡𝐞 𝐖𝐚𝐲 𝐔 𝐖𝐚𝐧𝐭',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 50,
                    fontWeight: FontWeight.w900),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        margin: const EdgeInsets.only(left: 30, right: 30),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                style: const TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  hintText: "Email",
                                  border: OutlineInputBorder(

                                    borderRadius: BorderRadius.circular(10),

                                  ),
                                ),
                                onChanged: (String email) {
                                  getUserEmail(email);
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                style: const TextStyle(),
                                obscureText: true,
                                decoration: InputDecoration(
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    hintText: "Password",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),

                                onChanged: (String password) {
                                  getUserPassword(password);
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  ' LogIn',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700),
                                ),
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: const Color(0xff4c505b),
                                  child: IconButton(
                                      color: Colors.white,
                                      onPressed: () {
                                        showAlert();
                                       // Navigator.pushNamed(context, 'home');
                                        LoginAccount();
                                      },
                                      icon: const Icon(
                                        Icons.arrow_forward,
                                      )),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 60,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, 'register');
                                  },
                                  style: const ButtonStyle(),
                                  child: const Text(
                                    'Create Account',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      'Forgot Password',
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showAlert() {
    QuickAlert.show(context: context,
        title: "Login",
        text: "Login successful",
        type: QuickAlertType.success);
  }
}

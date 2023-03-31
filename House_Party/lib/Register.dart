import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';



class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);


  @override
  _MyRegisterState createState() => _MyRegisterState();

}

class _MyRegisterState extends State<MyRegister> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  late String customerName, customerEmail, customerPassword;

  getCustomerName(name) {
    customerName = name;
  }

  getCustomerEmail(email) {
    customerEmail = email;
  }

  getCustomerPassword(password) {
    customerPassword = password;
  }

  createAccount() {
    print("Account Created");
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection('SignUpData').doc(customerName);

    //create map
    Map<String, dynamic> students = {
      "name": customerName,
      "email": customerEmail,
      "createpassword": customerPassword,

    };

    documentReference
        .set(students)
        .whenComplete(() => {print("$customerName Created")});
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/1.webp'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 35, top: 10),
              child: const Text(
                'Create your\nAccount',
                style: TextStyle(color: Colors.black, fontSize: 40),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  hintText: "Name",
                                  hintStyle: const TextStyle(color: Colors.black),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                              onChanged: (String name) {
                                getCustomerName(name);
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  hintText: "Email",
                                  hintStyle: const TextStyle(color: Colors.black),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                              onChanged: (String email) {
                                getCustomerEmail(email);
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              style: const TextStyle(color: Colors.black),
                              obscureText: true,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  hintText: "Create Password",
                                  hintStyle: const TextStyle(color: Colors.black),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                              onChanged: (String password) {
                                getCustomerPassword(password);
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                                 'Sign Up',
                                style: TextStyle(
                                    color: Colors.black,

                                    fontSize: 27,
                                    fontWeight: FontWeight.w700),
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: const Color(0xff4c505b),
                                child: IconButton(
                                    color: Colors.white,
                                    onPressed: () {
                                      Navigator.pushNamed(context, 'home');
                                      createAccount();
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              OutlinedButton.icon(
                                icon: const Image(
                                  image: AssetImage('assets/logo.png'),
                                  width: 40.0,
                                ),
                                onPressed: () {
                                  _googleSignIn.signIn().then((userData) {
                                    setState(() {});
                                  }).catchError((e) {
                                    if (kDebugMode) {
                                      print(e);
                                    }
                                  });
                                },
                                label: const Text(
                                  'continue With Google',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              OutlinedButton.icon(
                                icon: const Image(
                                  image: AssetImage('assets/fb.jpg'),
                                  width: 40.0,
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, 'fb');
                                },
                                label: const Text(
                                  'continue With Facebook',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              )
                            ],
                          ),

                        ],
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
}

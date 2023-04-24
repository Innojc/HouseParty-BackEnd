import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formfield = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool passToggle = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          key: _formfield,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /*Image.asset(
                  "images/dark.jpg",
                  height: 200,
                  width: 200,
                ),*/
                const SizedBox(
                  height: 50,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.email),

                    // ***********For Eye Symbol**************

                    /*suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            passToggle = !passToggle;
                          });
                        },
                        child: Icon(passToggle
                            ? Icons.visibility
                            : Icons.visibility_off),
                      )*/
                  ),

                  // *********Validator***********
                  validator: (value) {
                    bool emailvalid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9. !#$%&' *+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value!);

                    if (value!.isEmpty) {
                      return "Enter Mail";
                    } else if (!emailvalid) {
                      return "Enter Valid Email";
                    }
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: passwordController,
                  obscureText: passToggle,
                  decoration: InputDecoration(
                      labelText: "Password",
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            passToggle = !passToggle;
                          });
                        },
                        child: Icon(passToggle
                            ? Icons.visibility
                            : Icons.visibility_off),
                      )),

                  // Validation part

                  // Validator:
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Password";
                    } else if (passwordController.text.length < 6) {
                      return "Password Length Should not be less than 6 characters";
                    }

                    bool emailvalid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9. !#$%&' *+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value);
                    if (!emailvalid) {
                      return "Enter Valid Email";
                    }
                  },
                ),
                const SizedBox(height: 60),
                InkWell(
                  onTap: () {
                    if (_formfield.currentState!.validate()) {
                      print("Success");
                      emailController.clear();
                      passwordController.clear();
                    }
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account..?",
                      style: TextStyle(fontSize: 17),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ))
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

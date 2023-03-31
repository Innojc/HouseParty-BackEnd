import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Login/login_screen.dart';

class SignUpForm extends StatelessWidget {
  SignUpForm({
    Key? key,
  }) : super(key: key);

  late String loginemail, loginpassword, loginconpassword;

  getLoginemail(email) {
    loginemail = email;
  }

  getLoginpassword(password) {
    loginpassword = password;
  }

  getLoginconPassword(conpassword) {
    loginconpassword = conpassword;
  }

  signupData() {
    print("signup sucessful");
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection('MyAdmin').doc(loginemail);

    //create map
    Map<String, dynamic> Admininfo = {
      "email": loginemail,
      "password": loginpassword,
      "conpassword": loginconpassword,
    };

    documentReference.set(Admininfo).whenComplete(() => {print("$loginemail Created")});
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email) {},
            decoration: const InputDecoration(
              hintText: "Your email",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
              onChanged: (String email) {
                getLoginemail(email);
              }),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Create password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
                onChanged: (String password) {
                  getLoginpassword(password);
                }),
          ),

          TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Confirm password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
              onChanged: (String conpassword) {
                getLoginconPassword(conpassword);
              }),
          const SizedBox(height: defaultPadding),
          ElevatedButton(
            onPressed: () {
              signupData();
            },
            child: Text("Sign Up".toUpperCase()),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
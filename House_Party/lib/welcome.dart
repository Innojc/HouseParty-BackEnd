import 'package:flutter/material.dart';

void main() {
  runApp(const welcome());
}

class welcome extends StatelessWidget {
  const welcome({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/11.webp'), fit: BoxFit.cover),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(children: [
            Container(
              padding: const EdgeInsets.only(left: 35, top: 200),
              child: const Text(
                '𝐖𝐞𝐥𝐜𝐨𝐦𝐞 𝐓𝐨 𝐇𝐨𝐮𝐬𝐞𝐏𝐚𝐫𝐭𝐲' ,
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 55,
                    fontWeight: FontWeight.w900),
              ),
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: Container(
                height: 60,
                margin: const EdgeInsets.all(80),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'login');
                  },
                  child: const Center(
                    child: Text('Get Start'),
                  ),
                ),
              ),
            )
          ])),
    );
  }
}

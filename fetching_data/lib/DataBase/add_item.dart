import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddItem extends StatefulWidget {
  const AddItem({Key? key}) : super(key: key);

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerQuantity = TextEditingController();

  GlobalKey<FormState> key = GlobalKey();

  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('hotels list');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add The Restaurant Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: key,
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextFormField(
                controller: _controllerName,
                decoration: const InputDecoration(
                    hintText: 'Enter the name of the Restaurant'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Restaurant name';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _controllerQuantity,
                decoration: const InputDecoration(
                    hintText: 'Enter the name of the Dish'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Dish';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 50),
              ElevatedButton(
                  onPressed: () async {
                    if (key.currentState!.validate()) {
                      String itemName = _controllerName.text;
                      String itemQuantity = _controllerQuantity.text;

                      //Create a Map of data
                      Map<String, String> dataToSend = {
                        'hotel_name': itemName,
                        'menu': itemQuantity
                      };

                      //Add a new item
                      _reference.add(dataToSend);
                    }
                  },
                  child: const Text('Submit'))
            ],
          ),
        ),
      ),
    );
  }
}

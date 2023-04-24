import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditItem extends StatelessWidget {
  EditItem(this.Item, {super.key}) {
    _controllerName = TextEditingController(text: Item['hotel_name']);
    _controllerQuantity =
        TextEditingController(text: Item['menu']);

    _reference = FirebaseFirestore.instance
        .collection('hotels list')
        .doc(Item['id']);
  }

  final Map Item;
  late DocumentReference _reference;

  late TextEditingController _controllerName;
  late TextEditingController _controllerQuantity;
  final GlobalKey<FormState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Restaurant Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _key,
          child: Column(
            children: [
              TextFormField(
                controller: _controllerName,
                decoration:
                    const InputDecoration(hintText: 'Enter the name of the Restaurant'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Restaurant name';
                  }

                  return null;
                },
              ),
              TextFormField(
                controller: _controllerQuantity,
                decoration:
                    const InputDecoration(hintText: 'Enter the name of the Dish'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Dish';
                  }

                  return null;
                },
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (_key.currentState!.validate()) {
                      String hotelName = _controllerName.text;
                      String menu = _controllerQuantity.text;

                      //Create the Map of data
                      Map<String,String> dataToUpdate={
                        'hotel_name':hotelName,
                        'menu':menu
                      };

                      //Call update()
                      _reference.update(dataToUpdate);
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

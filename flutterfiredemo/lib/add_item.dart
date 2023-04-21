import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddItem extends StatefulWidget {
  const AddItem({Key? key}) : super(key: key);

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  TextEditingController _controllerName = TextEditingController();

  //TextEditingController _controllerQuantity = TextEditingController();

  GlobalKey<FormState> key = GlobalKey();

  CollectionReference hotels = FirebaseFirestore.instance.collection('Hotels');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add the Hotel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: key,
          child: Column(
            children: [
              TextFormField(
                controller: _controllerName,
                decoration:
                    InputDecoration(hintText: 'Enter the name of the Hotel'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Hotel name';
                  }

                  return null;
                },
              ),
              /*TextFormField(
                controller: _controllerQuantity,
                decoration:
                    InputDecoration(hintText: 'Enter the quantity of the item'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the item quantity';
                  }

                  return null;
                },
              ),*/
              ElevatedButton(
                  onPressed: () async {
                    if (key.currentState!.validate()) {
                      String itemName = _controllerName.text;

                      //Create a Map of data
                      Map<String, String> dataToSend = {
                        'Name': itemName,
                      };

                      //Add a new item
                      hotels.add(dataToSend);
                    }
                  },
                  child: Text('Submit'))
            ],
          ),
        ),
      ),
    );
  }
}

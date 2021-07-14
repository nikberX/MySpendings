import 'package:flutter/material.dart';

class NewPurchase extends StatelessWidget {

  final titleController = TextEditingController();
  final amountController = TextEditingController();
  
  final Function onButtonPressed;

  NewPurchase(this.onButtonPressed);

  @override
  Widget build(BuildContext context) {
    return Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Title',
                      ),
                      controller: titleController,
                    ),
                    TextField(decoration: InputDecoration(
                        labelText: 'Amount',
                      ),
                      controller: amountController,
                    ),
                    FlatButton(
                      onPressed: () {onButtonPressed(titleController.text,amountController.text);},
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    )
                  ],
                ),
            ),
    );
  }
}
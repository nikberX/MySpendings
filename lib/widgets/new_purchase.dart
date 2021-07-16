import 'package:flutter/material.dart';

class NewPurchase extends StatefulWidget {

  final Function onButtonPressed;

  NewPurchase(this.onButtonPressed);

  @override
  _NewPurchaseState createState() => _NewPurchaseState();
}

class _NewPurchaseState extends State<NewPurchase> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    if (titleController.text.isEmpty || amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount < 0) {
      return;
    }
    widget.onButtonPressed(enteredTitle, enteredAmount);
    Navigator.of(context).pop();
  }

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
                      onSubmitted: (_) => submitData(),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Amount',
                      ),
                      keyboardType: TextInputType.number,
                      controller: amountController,
                      onSubmitted: (_) => submitData(),
                    ),
                    FlatButton(
                      onPressed: () => submitData(),
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
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewPurchase extends StatefulWidget {

  final Function onButtonPressed;

  NewPurchase(this.onButtonPressed);

  @override
  _NewPurchaseState createState() => _NewPurchaseState();
}

class _NewPurchaseState extends State<NewPurchase> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? _selectedDate;

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

  void _presentDatePicker() {
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(),  
      firstDate: DateTime(2020), 
      lastDate: DateTime.now()
      ).then((pickedDate) {
        if (pickedDate == null) return;

        _selectedDate = pickedDate;
      });
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
                        labelText: 'Название',
                      ),
                      controller: titleController,
                      onSubmitted: (_) => submitData(),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Стоимость',
                      ),
                      keyboardType: TextInputType.number,
                      controller: amountController,
                      onSubmitted: (_) => submitData(),
                    ),
                    Container(
                      height: 70,
                      child: Row(
                        children: <Widget>[
                          Text(
                            null == _selectedDate ? 
                            'Дата не выбрана!' 
                            : 
                            DateFormat.yMd().format(_selectedDate as DateTime)
                            ),
                          Card(
                            elevation: 2,
                            child: FlatButton(
                              onPressed: _presentDatePicker, 
                              child: Text(
                                'Выбрать дату',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                ), 
                            ),
                          )
                        ],
                      ),
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
                    ),
                  ],
                ),
            ),
    );
  }
}
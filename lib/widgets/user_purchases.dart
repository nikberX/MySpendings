import 'package:flutter/material.dart';

import '../models/purchase.dart';
import './purchase_list.dart';
import './new_purchase.dart';

class UserPurchases extends StatefulWidget {
  @override
  _UserPurchasesState createState() => _UserPurchasesState();
}



class _UserPurchasesState extends State<UserPurchases> {
  final List<Purchase> _userPurchases = [
    //Purchase(id: '1', title: 'Автобус', amount: 46.01, date:  DateTime.now()),
    //Purchase(id: '1', title: 'Ягоды', amount: 470, date:  DateTime.now()),
    //Purchase(id: '1', title: 'Лента', amount: 653, date:  DateTime.now()),
    Purchase(id: '1', title: 'ФиксПрайс', amount: 253, date:  DateTime.now()),
    //Purchase(id: '1', title: 'Ярче', amount: 200, date:  DateTime.now()),
  ];

  void _addNewPurchase(String title, String amountStr) {
    double amount;
    amount = double.parse(amountStr);
    final newPurhcase = Purchase(
      title: title, 
      amount: amount, 
      date: DateTime.now(), 
      id: (title + amount.toString()).hashCode.toString()
    );
    setState(() {
      _userPurchases.add(newPurhcase);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      NewPurchase(_addNewPurchase),
      PurchaseList(_userPurchases),
      ],
    );
  }
}
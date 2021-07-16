//packages
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//files
import '../models/purchase.dart';

class PurchaseList extends StatelessWidget {
  final List<Purchase> _purchases;

  PurchaseList(this._purchases);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      child: _purchases.isEmpty ? 
      Column( //is Empty, true
        children: <Widget>[
          Text(
            'Нет покупок',
            style: Theme.of(context).textTheme.title,
          ),
          SizedBox(height: 10,),
          Container(
            height: 200,
            child: Image.asset(
              'assets/images/waiting.png',
              fit: BoxFit.cover
              ),
          )
        ],
      ) 
      : 
      ListView.builder( // Not empty, false
        itemBuilder: (context, index) {
                  return Card(
                    child: Row(children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.yellow, width: 3,),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          '${_purchases[index].amount.toStringAsFixed(2)} Руб.',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        
                        Text(
                          _purchases[index].title,
                          style: Theme.of(context).textTheme.title,
                        ),
                        Text(
                          DateFormat('yMMMd').format(_purchases[index].date),
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xA1000000) , //black
                          ),
                        ),
                      ],
                      )
                    ],
                    )
                  );
                },
        itemCount: _purchases.length,
        ),
      );
  }
}
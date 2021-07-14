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
    return Column(
            children: _purchases.map((purchase) {
              return Card(
                child: Row(children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.yellow, width: 3,),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Text(
                      '${purchase.amount} Руб.',
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
                      purchase.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xC1000000) , //black
                      ),
                    ),
                    Text(
                      DateFormat('yMMMd').format(purchase.date),
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
            }
            ).toList(),
    );
  }
}
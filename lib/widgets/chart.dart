
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/purchase.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Purchase> recentPurchases;

  Chart(this.recentPurchases);

  List<Map<String, Object>> get groupedPurchasesValues {
    return List.generate(
      7, 
      (index) {
        
        final weekDays = DateTime.now().subtract(Duration(days: index), );

        double sumOfAmounts = 0;

        for(var i = 0; i<recentPurchases.length; i++) {
          if (
            recentPurchases[i].date.day == weekDays.day &&
            recentPurchases[i].date.month == weekDays.month &&
            recentPurchases[i].date.year == weekDays.year
          ) { 
            sumOfAmounts += recentPurchases[i].amount; 
          }//end if
        }

        return {'day' : DateFormat.E().format(weekDays).substring(0,1), 'amount' : sumOfAmounts};
      }
    ).reversed.toList();
  }

  double get _sumOfTotal {
    double sum = 0;
    for(var i = 0; i<recentPurchases.length;i++) {
      sum+=recentPurchases[i].amount;
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 6,
        margin: EdgeInsets.all(15),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: groupedPurchasesValues.map(
              (data) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                    data['day'] as String, 
                    data['amount'] as double, 
                    _sumOfTotal == 0 ? 0 : (data['amount'] as double) / _sumOfTotal),
                );
              }
            ).toList(),
          ),
        )
    );
  }
}
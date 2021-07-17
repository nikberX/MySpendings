//packages
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//files
import '../models/purchase.dart';

class PurchaseList extends StatelessWidget {
  final List<Purchase> _purchases;
  final Function onRemove;

  PurchaseList(this._purchases, this.onRemove);

  @override
  Widget build(BuildContext context) {
    return  _purchases.isEmpty ? 
      LayoutBuilder(builder: (context_, constraints) { //is Empty, true
        return Column( 
          children: <Widget>[
            Text(
              'Нет покупок',
              style: Theme.of(context).textTheme.title,
            ),
            SizedBox(height: constraints.maxHeight * 0.05,),
            Container(
              height: constraints.maxHeight * 0.6,
              child: Image.asset(
                'assets/images/waiting.png',
                fit: BoxFit.cover
                ),
            )
          ],
        );
      }) 
      : 
      ListView.builder( // Not empty, false
        itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 7, horizontal: 4),
                    child: ListTile(
                      leading: Container(
                        height: 80,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.yellow,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(4),
                          child: FittedBox(
                            child: Text('${_purchases[index].amount.toStringAsFixed(2)} руб.',
                            style: TextStyle(
                              color: Colors.green, 
                              fontWeight: FontWeight.bold,
                              fontSize: 26,
                              ),
                            )
                          ), 
                        ),
                      ),
                      title: Text(
                        '${_purchases[index].title}',
                        style: Theme.of(context).textTheme.title,
                      ),
                      subtitle: Text(DateFormat.yMMMd().format(_purchases[index].date)),
                      trailing: IconButton(
                        onPressed: () {onRemove(_purchases[index].id);}, 
                        icon: Icon(Icons.delete, color: Colors.yellow)
                      ),
                    ),
                  );
                },
        itemCount: _purchases.length,
      );
  }
}
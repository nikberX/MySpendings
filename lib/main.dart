import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import './models/purchase.dart';
import './widgets/new_purchase.dart';
import './widgets/purchase_list.dart';
import './widgets/chart.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Мои траты',
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.amber,
        accentColor: Colors.blue,
        fontFamily: 'OpenSans',
        textTheme: TextTheme(
          title: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Color(0xC1000000) , //black
          ),
        ),
        appBarTheme: AppBarTheme(
          textTheme: TextTheme(
            title: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold
            )
          )
        ),
      )
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool _showChart = false;

  final List<Purchase> _userPurchases = [
    //Purchase(id: '1', title: 'Автобус', amount: 46.01, date:  DateTime.now().subtract(Duration(days: 3))),
    //Purchase(id: '1', title: 'Ягоды', amount: 470, date:  DateTime.now().subtract(Duration(days: 2))),
    //Purchase(id: '1', title: 'Лента', amount: 653, date:  DateTime.now().subtract(Duration(days: 1))),
    //Purchase(id: '1', title: 'ФиксПрайс', amount: 253, date:  DateTime.now().subtract(Duration(days: 1))),
    //Purchase(id: '1', title: 'Ярче', amount: 200, date:  DateTime.now()),
  ];

  List<Purchase> get _recentPurchases {
    return _userPurchases.where((element) {
      var weekBefore = DateTime.now().subtract(Duration(days: 7));
      return element.date.isAfter(weekBefore);
    }).toList();
  }

  void _addNewPurchase(String title, double amount) {
    final newPurhcase = Purchase(
      title: title, 
      amount: amount, 
      date: DateTime.now(), 
      id: (title + amount.toString()).hashCode.toString()
    );
    setState(() {
      print('Purchase added!');
      _userPurchases.add(newPurhcase);
    });
  }

  void _removePurchase(String id) {
    setState(
      () {
      _userPurchases.removeWhere(
        (element) => element.id == id
      );
    });
  }

  void _startAddNewPurchase(BuildContext context) {
    showModalBottomSheet(
      context: context, 
      builder: (_) {
        return GestureDetector(
            child: NewPurchase(_addNewPurchase),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            
          );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);


    final appBar = AppBar(
        title: Text('Мои траты'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {_startAddNewPurchase(context);},
          )
        ],
    );

    final isLandscape = mediaQuery.orientation == Orientation.landscape;


    var purchaseListWidget = Container(
                height: (mediaQuery.size.height - 
                         mediaQuery.padding.top -
                         appBar.preferredSize.height) * 0.7,
                child: PurchaseList(_userPurchases,_removePurchase)
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
              if (isLandscape) Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Show chart'),
                  Switch(
                    value: _showChart, 
                    onChanged: (val) {setState(() {
                      _showChart = val;
                    });}
                  )
                ],
              ),
              if (!isLandscape) Container(
                height: (mediaQuery.size.height - 
                         mediaQuery.padding.top -
                         appBar.preferredSize.height) 
                         * 0.3,
                width: double.infinity,
                child: Card(
                  child: Chart(_recentPurchases), 
                  elevation: 0,
              )),
              if (!isLandscape) purchaseListWidget,
              if (isLandscape) _showChart  
              ? Container(
                height: (mediaQuery.size.height - 
                         mediaQuery.padding.top -
                         appBar.preferredSize.height) 
                         * 0.7,
                width: double.infinity,
                child: Card(
                  child: Chart(_recentPurchases), 
                  elevation: 0,
                ),
              )
              : purchaseListWidget
              
            ],
            ),
      ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {_startAddNewPurchase(context);},
          child: Icon(Icons.add),
        )
      );
  }
}

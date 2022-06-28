import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/widgets/chart.dart';
import 'package:flutter_application_1/pages/widgets/new_transaction.dart';
import 'package:flutter_application_1/pages/widgets/transcation_list.dart';

import './transcation.dart';

class MyCard extends StatefulWidget {
  //String titleInput;
  //String amountInput;
  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  final List<Transcation> _userTransactions = [
    /*  Transcation(
      id: 't1',
      title: 'Grapes',
      amount: 85.66,
      date: DateTime.now(),
    ),
    Transcation(
      id: 't2',
      title: 'Shoes',
      amount: 265.88,
      date: DateTime.now(),
    ),*/
  ];
  List<Transcation> get _recentTranscations {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTranscation(String txTitle, double txAmount) {
    final newTx = Transcation(
      title: txTitle,
      amount: txAmount,
      date: DateTime.now(),
      id: DateTime.now().toString(),
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTranscation(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTranscation(_addNewTranscation),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(
          'Personal Expenses',
          style: TextStyle(
              fontFamily: 'Personal Expenses',
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTranscation(context),
          ),
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Chart(_recentTranscations),
              Container(
                width: double.infinity,
                child: Card(
                  color: Colors.red,
                  child: Text('Flutter'),
                  elevation: 6,
                ),
              ),
              TransactionList(_userTransactions),
            ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.amber,
        onPressed: () => _startAddNewTranscation(context),
      ),
    );
  }
}

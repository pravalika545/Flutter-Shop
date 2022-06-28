import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../models/transcation.dart';

class TransactionList extends StatelessWidget {
  final List<Transcation> transcations;

  TransactionList(this.transcations);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child:
      
       ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            child: Row(children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.red,
                    width: 4,
                  ),
                ),
                padding: EdgeInsets.all(20),
                child:
                    Text('\$${transcations[index].amount.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.red,
                        )),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    transcations[index].title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    DateFormat.yMMMd().format(transcations[index].date),
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              )
            ]),
          );
        },
        itemCount: transcations.length,
      ),
    );
  }
}

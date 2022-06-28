import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:flutter_application_1/pages/models/transcation.dart';

class Chart extends StatelessWidget {
  final List<Transcation> recentTranscations;
  Chart(this.recentTranscations);
  List<Map<String, Object>> get groupedTranscationvalues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalsum = 0.0;
      for (var i = 0; i < recentTranscations.length; i++) {
        if (recentTranscations[i].date.day == weekDay.day &&
            recentTranscations[i].date.month == weekDay.month &&
            recentTranscations[i].date.year == weekDay.year) {
          totalsum += recentTranscations[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalsum
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(18),
      child: Row(
        children: groupedTranscationvalues.map((data) {
          return Text('${data['day']}:${data['amount']}');
        }).toList(),
      ),
    );
  }
}

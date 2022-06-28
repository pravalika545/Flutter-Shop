import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String Label;
  final double spendingAmount;
  final double spendingPcOfTotal;

  ChartBar(this.Label, this.spendingAmount, this.spendingPcOfTotal);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('\$${spendingAmount.toStringAsFixed(0)}'),
        SizedBox(height: 5,),
        Container(height: 45,
        width: 15,
        child: Stack(children: <Widget>[
          Container(decoration: BoxDecoration(border: Border.all(color:Colors.grey,width:1.0),
          color: Color.fromARGB(220, 220, 220, 1),
          borderRadius: BorderRadius.circular(10),
          ),
          ),
          FractionallySizedBox(heightFactor: spendingPcOfTotal,
          child:(
            Container(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor,
             borderRadius: BorderRadius.circular(10), ),
            )
          ),
          ),
          
        ],),
        ),
        
        SizedBox(
          height: 4,
        ),
        Text(Label),      
      ],
    );
  }
}

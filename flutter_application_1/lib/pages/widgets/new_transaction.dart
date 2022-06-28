import 'package:flutter/material.dart';

class NewTranscation extends StatefulWidget {
  final Function addTx;
  NewTranscation(this.addTx);

  @override
  _NewTranscationState createState() => _NewTranscationState();
}

class _NewTranscationState extends State<NewTranscation> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enterdeAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enterdeAmount <= 0) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enterdeAmount,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return (Card(
      elevation: 6,
      child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleController,
                onSubmitted: (_) => submitData(),
                // onChanged: (val) {
                //titleInput = val;
                // },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitData(),
                //  onChanged: (val) {
                // amountInput = val;
                //   },
              ),
              FlatButton(
                child: Text('Add Transcations'),
                textColor: Colors.pink,
                onPressed: submitData,
              ),
            ],
          )),
    ));
  }
}

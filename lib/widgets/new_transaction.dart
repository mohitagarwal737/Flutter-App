import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleControler = TextEditingController();
  final _amountControler = TextEditingController();
  DateTime _selectedDate;

  double amountInput;

  var titleInput;

  void _submitData() {
    if (_amountControler.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleControler.text;
    final enteredAmount = double.parse(_amountControler.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null)
      return;
    else {
      widget.addTx(
        enteredTitle,
        enteredAmount,
        _selectedDate,
      );
    }
    Navigator.of(context).pop();

    // _titleControler.text,
    // double.parse(_amountControler.text),
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                  controller: _titleControler,
                  onSubmitted: (_) => _submitData()
                  // onChanged: (value) {
                  //   titleInput = value;
                  // },
                  ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountControler,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
                // onChanged: (value) => amountInput = value,
              ),
              Container(
                alignment: Alignment.bottomLeft,
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(_selectedDate == null
                          ? 'No Date Choosen!'
                          : 'Picked Date: ' +
                              DateFormat.yMd().format(_selectedDate)),
                    ),
                    FlatButton(
                      color: Colors.amber,
                      onPressed: _presentDatePicker,
                      child: Text('Choose Date',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          )),
                    ),
                  ],
                ),
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                child: Text(
                  'Add Transaction',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.button.color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () => _submitData(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

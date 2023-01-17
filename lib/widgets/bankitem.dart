import 'package:com_globalboxtransactions_app/common/funtions.dart';
import 'package:com_globalboxtransactions_app/common/varsandconts.dart';
import 'package:com_globalboxtransactions_app/data/Bank.dart';
import 'package:flutter/material.dart';

class BankItem extends StatefulWidget {
  final Bank bank;

  const BankItem({required this.bank});

  @override
  _BankItemState createState() => _BankItemState();
}

class _BankItemState extends State<BankItem> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showToastInfo(widget.bank.swiftCode);

        setState(() {
          selectedBank = widget.bank;
        });
      },
      child: Container(
        margin: EdgeInsets.all(5.0),
        padding: EdgeInsets.only(top: 15, bottom: 15, left: 5, right: 5),
        decoration: BoxDecoration(
            color: Theme.of(context).secondaryHeaderColor,
            borderRadius: BorderRadius.circular(radius)
        ),
        child: Column(
          children: <Widget>[
            Text(widget.bank.name,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(height: 2,),
            Text(widget.bank.swiftCode,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
      ),
    );
  }
}
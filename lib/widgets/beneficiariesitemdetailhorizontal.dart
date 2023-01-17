import 'package:com_globalboxtransactions_app/common/varsandconts.dart';
import 'package:com_globalboxtransactions_app/data/Beneficiary.dart';
import 'package:com_globalboxtransactions_app/newtransfer_step2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BeneficiariesItemDetailHorizontal extends StatefulWidget {
  final Beneficiary beneficiary;

  const BeneficiariesItemDetailHorizontal({required this.beneficiary});

  @override
  _BeneficiariesItemDetailHorizontalState createState() => _BeneficiariesItemDetailHorizontalState();
}

class _BeneficiariesItemDetailHorizontalState extends State<BeneficiariesItemDetailHorizontal> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => NewTransfer_Step2(beneficiary:widget.beneficiary),
        ),
      ),
      child: Container(
        width: 150,
        height: 200,
        margin: EdgeInsets.all(2),
        padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
        decoration: BoxDecoration(
            color: Theme.of(context).secondaryHeaderColor,
            //borderRadius: BorderRadius.circular(radius)
        ),
        child: Center(
          child: Column(
            children: [
              Container(
                child: ClipOval(
                  child: Material(
                      color: Colors.transparent,
                      child: getImageWidget(widget.beneficiary)
                  ),
                ),
              ),
              Flexible(
                child: Center(
                  child: Text(widget.beneficiary.name,
                      style: Theme.of(context).textTheme.subtitle2,
                      overflow: TextOverflow.ellipsis),
                ),
              ),
              Flexible(
                child: Text(widget.beneficiary.numberAccount,
                    style: Theme.of(context).textTheme.subtitle1,
                    overflow: TextOverflow.ellipsis),
              ),
              Flexible(
                child: Text(widget.beneficiary.email,
                    style: Theme.of(context).textTheme.subtitle1,
                    overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getImageWidget(Beneficiary beneficiary) {
    if (beneficiary.image != "") {
      return Image.network(imageURL + beneficiary.image,
          width: 64, height: 64, fit: BoxFit.fill);
    } else {
      return Image.asset(
        'assets/images/icon_nophotopeople.png',
        width: 64,
        height: 64,
      );
    }
  }
}
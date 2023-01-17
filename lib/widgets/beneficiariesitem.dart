import 'package:com_globalboxtransactions_app/beneficiarydetail.dart';
import 'package:com_globalboxtransactions_app/common/varsandconts.dart';
import 'package:com_globalboxtransactions_app/data/Beneficiary.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class BeneficiariesItem extends StatefulWidget {
  final Beneficiary beneficiary;
  final ValueNotifier<GraphQLClient> clientVM;

  const BeneficiariesItem({required this.beneficiary, required this.clientVM});

  @override
  _BeneficiariesItemState createState() => _BeneficiariesItemState();
}

class _BeneficiariesItemState extends State<BeneficiariesItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BeneficiaryDetail(beneficiary: widget.beneficiary),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(5.0),
        padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
        decoration: BoxDecoration(
            color: Theme.of(context).secondaryHeaderColor,
            borderRadius: BorderRadius.circular(radius)),
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ClipOval(
              child: Material(
                  color: Colors.transparent,
                  child: getImageWidget(widget.beneficiary)),
            ),
            Container(
              //color: Colors.indigo,
              padding: EdgeInsets.only(left: 15),
              width: MediaQuery.of(context).size.width * 0.75,
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  Text(widget.beneficiary.name,
                      style: Theme.of(context).textTheme.bodyText1,
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getImageWidget(Beneficiary beneficiary) {
    if (beneficiary.image != "") {
      return Image.network(imageURL + beneficiary.image,
          width: 48, height: 48, fit: BoxFit.fill);
    } else {
      return Image.asset(
        'assets/images/icon_nophotopeople.png',
        width: 48,
        height: 48,
      );
      // return Icon(
      //   Icons.camera_alt,
      //   size: 48,
      //   color: Colors.grey,
      // );
    }
  }
}

// getImageWidget(Beneficiary beneficiary) {
//   if (beneficiary.image != "") {
//     return Image.network(imageURL + beneficiary.image,
//         // width: 128,
//         height: 128,
//         fit: BoxFit.scaleDown);
//   } else {
//     return Image.asset(
//       'assets/images/icon_nophotopeople.png',
//       width: 128,
//       height: 128,
//     );
//   }
// }


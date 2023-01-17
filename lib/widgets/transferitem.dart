import 'package:com_globalboxtransactions_app/common/funtions.dart';
import 'package:com_globalboxtransactions_app/common/varsandconts.dart';
import 'package:com_globalboxtransactions_app/data/Transfer.dart';
import 'package:com_globalboxtransactions_app/transferdetail.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class TransferItem extends StatefulWidget {
  final Transfer transfer;
  final ValueNotifier<GraphQLClient> clientVN;

  const TransferItem({required this.transfer, required this.clientVN});

  @override
  _TransferItemState createState() => _TransferItemState();
}

class _TransferItemState extends State<TransferItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => TransferDetail(transfer: widget.transfer),
          ),
        );
      },
      child: Container(
        //margin: EdgeInsets.all(1.0),
        padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 0),
        decoration: BoxDecoration(
            color: Theme.of(context).secondaryHeaderColor,
            border: Border.all(
                color: Colors.white24, width: 0.1, style: BorderStyle.solid)
            //borderRadius: BorderRadius.circular(radius)
            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // Container(
            //   //color: Colors.indigo,
            //   margin: EdgeInsets.only(right: 10),
            //   child: Column(
            //     children: [
            //       if (widget.transfer.status == "COMPLETED")
            //         Container(
            //             child: Image.asset(
            //           'assets/images/icon_aceptar.png',
            //           width: 24,
            //           height: 24,
            //         )
            //             // Icon(Icons.done,
            //             //   color: Colors.greenAccent,
            //             //   size: 24,)
            //             ),
            //       if (widget.transfer.status == "PENDING")
            //         Container(
            //             child: Image.asset(
            //           'assets/images/icon_pendiente.png',
            //           width: 24,
            //           height: 24,
            //         )
            //             // Icon(Icons.hourglass_bottom_rounded,
            //             //   color: Colors.blueAccent,
            //             //   size: 24,)
            //             ),
            //       if (widget.transfer.status == "REVIEWING")
            //         Container(
            //             child: Image.asset(
            //           'assets/images/icon_revision.png',
            //           width: 24,
            //           height: 24,
            //         )
            //             // Icon(Icons.search_outlined,
            //             //   color: Colors.yellowAccent,
            //             //   size: 24,)
            //             ),
            //       if (widget.transfer.status == "CANCELED")
            //         Container(
            //             child: Image.asset(
            //           'assets/images/icon_cancelar.png',
            //           width: 24,
            //           height: 24,
            //         )
            //             // Icon(Icons.not_interested_rounded,
            //             //   color: Colors.redAccent,
            //             //   size: 24,)
            //             ),
            //     ],
            //   ),
            // ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  //color: Colors.indigo,
                  //width: MediaQuery.of(context).size.width * 0.57,
                  alignment: Alignment.centerLeft,
                  child: Text(widget.transfer.beneficiary.name.toUpperCase(),
                      style: Theme.of(context).textTheme.bodyText2,
                      overflow: TextOverflow.ellipsis),
                ),
                Container(
                  //color: Colors.indigo,
                  //width: MediaQuery.of(context).size.width * 0.57,
                  alignment: Alignment.centerLeft,
                  child: Text(
                      widget.transfer.beneficiary.numberAccount.toUpperCase(),
                      style: Theme.of(context).textTheme.subtitle1,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
            Container(
              //color: Colors.indigo,
              margin: EdgeInsets.only(right: 10),
              child: Container(
                //color: Colors.indigo,
                margin: EdgeInsets.only(left: 10),
                alignment: Alignment.centerLeft,
                //width: MediaQuery.of(context).size.width * 0.20,
                child: Text(moneyFormatter(widget.transfer.amount),
                    style: Theme.of(context).textTheme.headline4,
                    overflow: TextOverflow.ellipsis),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: <Widget>[
// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
//
//
// ],
// ),
//
// Container(
// //color: Colors.indigo,
// margin: EdgeInsets.only(right: 10),
// child: Column(
// children: [
// if(widget.transfer.status == "COMPLETED") Container(
// child:
// Image.asset(
// 'assets/images/icon_aceptar.png',
// width: 24,
// height: 24,
// )
// // Icon(Icons.done,
// //   color: Colors.greenAccent,
// //   size: 24,)
// ),
// if(widget.transfer.status == "PENDING") Container(
// child: Image.asset(
// 'assets/images/icon_pendiente.png',
// width: 24,
// height: 24,
// )
// // Icon(Icons.hourglass_bottom_rounded,
// //   color: Colors.blueAccent,
// //   size: 24,)
// ),
// if(widget.transfer.status == "REVIEWING") Container(
// child:
// Image.asset(
// 'assets/images/icon_revision.png',
// width: 24,
// height: 24,
// )
// // Icon(Icons.search_outlined,
// //   color: Colors.yellowAccent,
// //   size: 24,)
// ),
// if(widget.transfer.status == "CANCELED") Container(
// child:
// Image.asset(
// 'assets/images/icon_cancelar.png',
// width: 24,
// height: 24,
// )
// // Icon(Icons.not_interested_rounded,
// //   color: Colors.redAccent,
// //   size: 24,)
// ),
// ],
// ),
// )
// ],
// ),

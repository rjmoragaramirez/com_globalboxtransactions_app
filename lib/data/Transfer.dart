import 'package:com_globalboxtransactions_app/data/Beneficiary.dart';

class Transfer{
  String id;
  String refTX;
  String refMerchant;
  String refBank;
  double amount;
  String status;
  String date;
  String note;
  Beneficiary beneficiary;
  String paymentLink;

  Transfer({
    required this.id,
    required this.refTX,
    required this.refMerchant,
    required this.refBank,
    required this.amount,
    required this.status,
    required this.date,
    required this.note,
    required this.beneficiary,
    required this.paymentLink,
  });
}
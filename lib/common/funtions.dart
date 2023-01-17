import 'package:com_globalboxtransactions_app/common/varsandconts.dart';
import 'package:com_globalboxtransactions_app/data/Bank.dart';
import 'package:com_globalboxtransactions_app/data/Beneficiary.dart';
import 'package:com_globalboxtransactions_app/data/KYCData.dart';
import 'package:com_globalboxtransactions_app/data/Transfer.dart';
import 'package:com_globalboxtransactions_app/data/UserData.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';

HttpLink getAuthLink(){
  HttpLink httpLink = new HttpLink(
      "https://api.globalboxtransactions.com/graphql/", defaultHeaders: <String, String>{
    'Authorization': 'JWT ' + userData.token,
  });

  return httpLink;
}

Map<String, dynamic> extractRepositoryData(String dataheader, Map<String, dynamic> data) {
  return data[dataheader] as Map<String, dynamic>;
}

UserData extractRepositoryUserData(String dataheader, Map<String, dynamic> data) {
  UserData userData = new UserData(
      success: data[dataheader]["success"],
      token: data[dataheader]["token"],
      refreshToken: data[dataheader]["refreshToken"],
      username: data[dataheader]["user"]["username"],
      verified: data[dataheader]["user"]["verified"],
      id: data[dataheader]["user"]["id"],
      pk: data[dataheader]["user"]["pk"],
      profileImage: data[dataheader]["user"]["profileImage"],
      email: data[dataheader]["user"]["email"]);
  return userData;
}

Beneficiary extractRepositoryDataBeneficiary(String dataheader, Map<String, dynamic> data) {
  Beneficiary beneficiary = new Beneficiary(
      id: data["id"],
      name: data["name"],
      numberAccount: data["numberAccount"],
      email: data["email"],
      phone: data["phone"],
      bank: new Bank(
          id: data["bank"]["id"],
          name: data["bank"]["name"],
          swiftCode: data["bank"]["swiftCode"]),
      image: data["image"]);
  return beneficiary;
}

Transfer extractRepositoryDataTransfer(String dataheader, Map<String, dynamic> data) {

  Transfer transfer = new Transfer(
      id: data["id"],
      refTX: data["refTX"],
      refMerchant: data["refMerchant"],
      refBank: data["refBank"],
      amount: data["amount"],
      status: data["status"],
      date: data["date"],
      note: data["note"],
      paymentLink: data["paymentLink"],
      beneficiary: new Beneficiary(
          id: data["beneficiary"]["id"],
          name: data["beneficiary"]["name"],
          numberAccount: data["beneficiary"]["numberAccount"],
          email: data["beneficiary"]["email"],
          phone: data["beneficiary"]["phone"],
          bank: new Bank(
              id: data["beneficiary"]["bank"]["id"],
              name: data["beneficiary"]["bank"]["name"],
              swiftCode: data["beneficiary"]["bank"]["swiftCode"]),
          image: data["beneficiary"]["image"])
      );

  switch(transfer.status) {
    case "D": {transfer.status = "COMPLETED";}
    break;
    case "P": {transfer.status = "PENDING";}
    break;
    case "C": {transfer.status = "CANCELED";}
    break;
    case "R": {transfer.status = "REVIEWING";}
    break;
  }

  return transfer;
}

Bank extractRepositoryDataBank(String dataheader, Map<String, dynamic> data) {

  Bank bank = new Bank(
      id: data["id"],
      name: data["name"],
      swiftCode: data["swiftCode"]
  );

  return bank;
}

String moneyFormatter(double amount){
  MoneyFormatter moneyFormatter = MoneyFormatter(amount: amount);
  return moneyFormatter.output.symbolOnLeft;
}

KYCData extractRepositoryDataKYCData(String dataheader, Map<String, dynamic> data) {
  KYCData kycData = new KYCData(
      id: data["id"],
      firtsName: data["name"],
      lastName: data["lastname"],
      nopassport: data["dni"],
      postaddress: data["postaddress"],
      postcode: data["postcode"],
      city: data["city"],
      state: data["state"],
      country: data["country"],
      phone: data["phone"],
      status: data["status"],
      imageIdentity: data["imageIdentity"],
      imageAddress: data["imageAddress"]
  );

  switch(kycData.status) {
    case "NU": {kycData.status = "Not Uploaded";}
    break;
    case "A": {kycData.status = "Approved";}
    break;
    case "P": {kycData.status = "Pending";}
    break;
    case "I": {kycData.status = "Incompleted";}
    break;
    case "NA": {kycData.status = "Not Approved";}
    break;
  }

  return kycData;
}

List extractRepositoryDataList(String dataheader, Map<String, dynamic> data) {
  return data[dataheader]["list"] as List;
}

int extractRepositoryDataCode(String dataheader, Map<String, dynamic> data) {
  int a = int.parse(data[dataheader]["code"] as String);
  return a;
}

String getTime (String date){
  final f = new DateFormat('yyyy-MM-ddThh:mm');
  return f.parse(date).toString();
}

String getActiveTime(int timeStamp){
  String _activetime = "";
  var _timeZoneOffset;

  _timeZoneOffset = DateTime.now().timeZoneOffset.inHours.toInt();

  if (_timeZoneOffset < 0) {
    _timeZoneOffset = _timeZoneOffset.abs();
  } else {
    _timeZoneOffset = _timeZoneOffset * -1;
  }

  _timeZoneOffset = _timeZoneOffset * 3600;
  timeStamp = (timeStamp.toInt() + _timeZoneOffset).toInt();
  _activetime = getTimePassedUntilDate(timeStamp, 0);

  return _activetime;
}

String getTimePassedUntilDate(int timeStampActiveTime, int timeStampInitialDate) {
  var _daysPassed;
  var _daysRest;
  var _hoursPassed;
  var _hoursRest;
  var _minsPassed;
  String _timePassed = "";

  var datetimeStampInitialDate = convertTimeStampToDateTime(timeStampInitialDate);

  var datetimeStampActiveTime = convertTimeStampToDateTime(timeStampActiveTime);
  Duration mins = datetimeStampActiveTime.difference(datetimeStampInitialDate);

  var allMins = mins.inMinutes.toInt();

  // Días que han pasado OK
  _daysPassed = allMins / 60 ~/ 24;

  //Horas que han pasado OK
  _daysRest = allMins / 60 / 24;
  _daysRest = _daysRest - _daysPassed;
  _hoursPassed = _daysRest * 24 ~/1;

  //Minutos que han pasado OK
  _hoursRest = _daysRest * 24;
  _hoursRest = _hoursRest - _hoursPassed;
  _minsPassed = _hoursRest * 60 ~/1;

  if (_daysPassed > 0) _timePassed = _daysPassed.toString() + " Days, ";

  if (_hoursPassed > 0) _timePassed = _timePassed + _hoursPassed.toString() + " Hours, ";

  if (_hoursPassed < 0) _timePassed = _timePassed + ",";

  if (_minsPassed > 0) _timePassed = _timePassed + _minsPassed.toString() + " Mins";

  _timePassed = _timePassed +  " ago...";

  return _timePassed;
}

String getTimePassedUntilNow(int timeStamp) {
  var _daysPassed;
  var _daysRest;
  var _hoursPassed;
  var _hoursRest;
  var _minsPassed;
  String _timePassed = "";

  var datetiemNow = DateTime.now();
  var datetime = convertTimeStampToDateTime(timeStamp);
  Duration mins = datetiemNow.difference(datetime);

  var allMins = mins.inMinutes.toInt();

  // Días que han pasado OK
  _daysPassed = allMins / 60 ~/ 24;

  //Horas que han pasado OK
  _daysRest = allMins / 60 / 24;
  _daysRest = _daysRest - _daysPassed;
  _hoursPassed = _daysRest * 24 ~/1;

  //Minutos que han pasado OK
  _hoursRest = _daysRest * 24;
  _hoursRest = _hoursRest - _hoursPassed;
  _minsPassed = _hoursRest * 60 ~/1;

  if (_daysPassed > 0) _timePassed = _daysPassed.toString() + " Days, ";

  if (_hoursPassed > 0) _timePassed = _timePassed + _hoursPassed.toString() + " Hours, ";

  if (_hoursPassed < 0) _timePassed = _timePassed + ",";

  if (_minsPassed > 0) _timePassed = _timePassed + _minsPassed.toString() + " Mins";

  _timePassed = _timePassed +  " ago...";

  return _timePassed;
}

DateTime convertTimeStampToDateTime(int timeStamp) {
  var dateToTimeStamp = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
  return dateToTimeStamp;
}

String convertTimeStampToHumanDate(int timeStamp) {
  var dateToTimeStamp = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
  return DateFormat('dd/MM/yyyy').format(dateToTimeStamp);
}

String convertTimeStampToHumanHour(int timeStamp) {
  var dateToTimeStamp = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
  return DateFormat('HH:mm').format(dateToTimeStamp);
}

void showToastInfo(String message) {
  Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.green,
      textColor: Colors.white, fontSize: 16.0);
  print(message);
}

void showToast(String message) {
  Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.red,
      textColor: Colors.white, fontSize: 16.0);
  print(message);
}
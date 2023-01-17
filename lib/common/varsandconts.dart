import 'package:com_globalboxtransactions_app/data/Bank.dart';
import 'package:com_globalboxtransactions_app/data/KYCData.dart';
import 'package:com_globalboxtransactions_app/data/UserData.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

//Variables Globales
int allNodes = 0;
int onlineNodes = 0;
int offlineNodes = 0;
int statusNodes = 0;
int maxNode = 0;
late UserData userData;
late KYCData kycData;
DateTime timeBackPressed = DateTime.now();

//Textos Globales
String appversion = 'v0.24';
String apptitle = 'Global Box Transactions';
String txt_user = 'Usuario';
String txt_tranfers = 'Transferencias';
String txt_selbeneficiaries = 'Seleccione un Beneficiario';
String txt_transferdetail = 'Detalle de Transferencia';
String txt_amontnote = 'Monto y Comentario';
String txt_beneficiaries = 'Beneficiarios';
String txt_beneficiarydetail = 'Detalle del Beneficiario';
String txt_addbeneficiariesstep1 = 'Datos Personales';
String txt_addbeneficiariesstep2 = 'Datos Bancarios';
String txt_addbeneficiariesstep3 = 'Avatar';
String txt_editbeneficiary = 'Modificar Beneficiario';
String txt_KYC = 'KYC';
String txt_addbeneficiarysuccess =
    'Se ha agregado un Beneficiario satisfactoriamente.';
String txt_createTransfersuccess =
    'Se ha creado una Transferencia satisfactoriamente.';
String txt_cancelTransfersuccess =
    'Se ha cancelado la Transferencia satisfactoriamente.';
String txt_updatebeneficiarysuccess =
    'Se ha modificado un Beneficiario satisfactoriamente.';
String txt_updateKYCsuccess = 'Se ha modificado su KYC satisfactoriamente.';
String txt_createKYCsuccess = 'Se ha subido su KYC satisfactoriamente.';
String txt_addbeneficiaryfail =
    'Lo sentimos, no se pudo agregar el Beneficiario. Compruebe su conexión a Internet.';
String txt_createtransferfail =
    'Lo sentimos, no se pudo crear la Transferencia. Compruebe su conexión a Internet.';
String txt_canceltransferfail =
    'Lo sentimos, no se pudo cancelar la Transferencia. Compruebe su conexión a Internet.';
String txt_updatebeneficiaryfail =
    'Lo sentimos, no se pudo modificar el Beneficiario. Compruebe su conexión a Internet.';
String txt_updateKYCfail =
    'Lo sentimos, no se pudo modificar su KYC. Compruebe su conexión a Internet.';
String txt_createKYCfail =
    'Lo sentimos, no se pudo subir su KYC. Compruebe su conexión a Internet.';
String appslogan =
    'With this platform you can send money to various countries around the world.';
String txt_kycnofound =
    'Lo sentimos, aparentemente su KYC no está subido a nuestro sistema, por favor haga click en el botón que está debajo para subir su información.';
String txt_errorServer = 'Error en el servidor';
String txt_errorUserNoAuth = 'El Token de seguridad ha expirado...';


//Constantes Globales
String queryKey = '"05+)r+a21ze8!xh"';

HttpLink httpLink =
    new HttpLink('https://api.globalboxtransactions.com/graphql/');

String serverURL = 'https://api.globalboxtransactions.com/graphql/';
String imageURL = 'https://api.globalboxtransactions.com/media/';

var radius = 40.0;
var widthcomponents = 40.0;
var paddingcomponents = 15.0;
var margingcomponents = 15.0;

//Prueba
String query = '';
late List<Bank> foundBank = [];
late List<Bank> allbanks = [];
Bank selectedBank = new Bank(id: "", name: "", swiftCode: "");

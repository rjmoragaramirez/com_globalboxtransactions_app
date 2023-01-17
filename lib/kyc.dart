import 'dart:io';

import 'package:com_globalboxtransactions_app/common/mutationsandquerys.dart';
import 'package:com_globalboxtransactions_app/common/varsandconts.dart';
import 'package:com_globalboxtransactions_app/data/KYCData.dart';
import 'package:com_globalboxtransactions_app/kycedit.dart';
import 'package:com_globalboxtransactions_app/transfers.dart';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:image_picker/image_picker.dart';

import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';

import 'common/components.dart';
import 'common/funtions.dart';

class KYC extends StatefulWidget {
  const KYC({Key? key}) : super(key: key);

  @override
  _KYCState createState() => _KYCState();
}

class _KYCState extends State<KYC> {
  var controller;

  var byteData;
  var multipartFile;
  File image = new File("");
  final picker = ImagePicker();

  KYCData kycData = new KYCData(
      id: "",
      firtsName: "",
      lastName: "",
      nopassport: "",
      postaddress: "",
      postcode: "",
      city: "",
      state: "",
      country: "",
      phone: "",
      status: "Not Uploaded",
      imageIdentity: "",
      imageAddress: "");

  bool kycnoempty = false;

  @override
  Widget build(BuildContext context) {
    httpLink = new HttpLink("https://api.globalboxtransactions.com/graphql/",
        defaultHeaders: <String, String>{
          'Authorization': 'JWT ' + userData.token,
        });

    final ValueNotifier<GraphQLClient> clientVN = ValueNotifier(
      GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(store: InMemoryStore()),
      ),
    );

    return GraphQLProvider(
      client: clientVN,
      child: WillPopScope(
        onWillPop: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => Transfers(),
            ),
          );
          return true;
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).backgroundColor,
            title: Text(
              txt_KYC,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline3,
            ),
            elevation: 0.0,
          ),
          body: Query(
            options: QueryOptions(
              document: gql(getKyc),
            ),
            builder: (result, {fetchMore, refetch}) {

              if (result.isLoading) {
                return Container(
                  child: Center(
                    child: Container(
                      decoration:
                      BoxDecoration(color: Theme.of(context).backgroundColor),
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                        strokeWidth: 2.0,
                      ),
                    ),
                  ),
                );
              }

              print("Result getKyc = " + result.data.toString());

              var code  = extractRepositoryDataCode("getKyc", result.data!);
              print("Data Respons Code Kyc = " + code.toString());

              if (code == 401) {
                print("Result getKyc Exception = " + result.exception.toString());
                return Container(
                  child: Center(
                    child: Container(
                      decoration:
                          BoxDecoration(color: Theme.of(context).backgroundColor),
                      child: Text(txt_errorUserNoAuth,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ),
                  ),
                );
              }

              if (code == 500) {
                print("Result getKyc Exception = " + result.exception.toString());
                return Container(
                  child: Center(
                    child: Container(
                      decoration:
                      BoxDecoration(color: Theme.of(context).backgroundColor),
                      child: Text(txt_errorServer,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ),
                  ),
                );
              }

              if(code == 200){
                var list = extractRepositoryDataList("getKyc", result.data!);
                print("List Count " + list.length.toString() + " KYC.");

                if (list.length == 1) {
                  kycData = extractRepositoryDataKYCData(
                    "KYCNode",
                    list[0],
                  );
                }
                print("KYC User ID = " + kycData.id);

                if (kycData.firtsName.isNotEmpty &&
                    kycData.lastName.isNotEmpty &&
                    kycData.postaddress.isNotEmpty) {
                  kycnoempty = true;
                }

                return ListView(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        if (kycnoempty)
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            margin: EdgeInsets.all(margingcomponents),
                            padding: EdgeInsets.all(paddingcomponents),
                            decoration: BoxDecoration(
                                color: Theme.of(context).secondaryHeaderColor,
                                borderRadius: BorderRadius.circular(radius)),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  //margin: EdgeInsets.only(left: 10, right: 10),
                                  //alignment: Alignment.centerLeft,
                                  //padding: EdgeInsets.symmetric(horizontal: 48),
                                  child: Column(
                                    //crossAxisAlignment: CrossAxisAlignment.,
                                    children: [
                                      Text(
                                        'Nombre',
                                        style:
                                        Theme.of(context).textTheme.subtitle1,
                                      ),
                                      Text(
                                        kycData.firtsName,
                                        style:
                                        Theme.of(context).textTheme.subtitle2,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  //margin: EdgeInsets.only(left: 10, right: 10),
                                  //alignment: Alignment.topLeft,
                                  //padding: EdgeInsets.symmetric(horizontal: 48),
                                  child: Column(
                                    //crossAxisAlignment: CrossAxisAlignment.,
                                    children: [
                                      Text(
                                        'Apellidos',
                                        style:
                                        Theme.of(context).textTheme.subtitle1,
                                      ),
                                      Text(
                                        kycData.lastName,
                                        style:
                                        Theme.of(context).textTheme.subtitle2,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  ////margin: EdgeInsets.only(left: 10, right: 10),
                                  //alignment: Alignment.topLeft,
                                  //padding: EdgeInsets.symmetric(horizontal: 48),
                                  child: Column(
                                    //crossAxisAlignment: CrossAxisAlignment.,
                                    children: [
                                      Text(
                                        'Teléfono',
                                        style:
                                        Theme.of(context).textTheme.subtitle1,
                                      ),
                                      Text(
                                        kycData.phone,
                                        style:
                                        Theme.of(context).textTheme.subtitle2,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  //margin: EdgeInsets.only(left: 10, right: 10),
                                  //alignment: Alignment.topLeft,
                                  //padding: EdgeInsets.symmetric(horizontal: 48),
                                  child: Column(
                                    //crossAxisAlignment: CrossAxisAlignment.,
                                    children: [
                                      Text(
                                        'Pasaporte o DNI',
                                        style:
                                        Theme.of(context).textTheme.subtitle1,
                                      ),
                                      Text(
                                        kycData.nopassport,
                                        style:
                                        Theme.of(context).textTheme.subtitle2,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  //margin: EdgeInsets.only(left: 10, right: 10),
                                  //alignment: Alignment.topLeft,
                                  //padding: EdgeInsets.symmetric(horizontal: 48),
                                  child: Column(
                                    //crossAxisAlignment: CrossAxisAlignment.,
                                    children: [
                                      Text(
                                        'Dirección Postal',
                                        style:
                                        Theme.of(context).textTheme.subtitle1,
                                      ),
                                      Text(
                                        kycData.postaddress,
                                        style:
                                        Theme.of(context).textTheme.subtitle2,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  //margin: EdgeInsets.only(left: 10, right: 10),
                                  //alignment: Alignment.topLeft,
                                  //padding: EdgeInsets.symmetric(horizontal: 48),
                                  child: Column(
                                    //crossAxisAlignment: CrossAxisAlignment.,
                                    children: [
                                      Text(
                                        'Ciudad',
                                        style:
                                        Theme.of(context).textTheme.subtitle1,
                                      ),
                                      Text(
                                        kycData.city,
                                        style:
                                        Theme.of(context).textTheme.subtitle2,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  //margin: EdgeInsets.only(left: 10, right: 10),
                                  //alignment: Alignment.topLeft,
                                  //padding: EdgeInsets.symmetric(horizontal: 48),
                                  child: Column(
                                    //crossAxisAlignment: CrossAxisAlignment.,
                                    children: [
                                      Text(
                                        'Estado',
                                        style:
                                        Theme.of(context).textTheme.subtitle1,
                                      ),
                                      Text(
                                        kycData.state,
                                        style:
                                        Theme.of(context).textTheme.subtitle2,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  //margin: EdgeInsets.only(left: 10, right: 10),
                                  //alignment: Alignment.topLeft,
                                  //padding: EdgeInsets.symmetric(horizontal: 48),
                                  child: Column(
                                    //crossAxisAlignment: CrossAxisAlignment.,
                                    children: [
                                      Text(
                                        'País',
                                        style:
                                        Theme.of(context).textTheme.subtitle1,
                                      ),
                                      Text(
                                        kycData.country,
                                        style:
                                        Theme.of(context).textTheme.subtitle2,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  //margin: EdgeInsets.only(left: 10, right: 10),
                                  //alignment: Alignment.topLeft,
                                  //padding: EdgeInsets.symmetric(horizontal: 48),
                                  child: Column(
                                    //crossAxisAlignment: CrossAxisAlignment.,
                                    children: [
                                      Text(
                                        'Código Postal',
                                        style:
                                        Theme.of(context).textTheme.subtitle1,
                                      ),
                                      Text(
                                        kycData.postcode,
                                        style:
                                        Theme.of(context).textTheme.subtitle2,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  //margin: EdgeInsets.only(left: 10, right: 10),
                                  //alignment: Alignment.topLeft,
                                  //padding: EdgeInsets.symmetric(horizontal: 48),
                                  child: Column(
                                    //crossAxisAlignment: CrossAxisAlignment.,
                                    children: [
                                      Text(
                                        'Estado del KYC',
                                        style:
                                        Theme.of(context).textTheme.subtitle1,
                                      ),
                                      Text(
                                        kycData.status,
                                        style:
                                        Theme.of(context).textTheme.subtitle2,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (kycnoempty)
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            margin: EdgeInsets.all(margingcomponents),
                            padding: EdgeInsets.all(paddingcomponents),
                            decoration: BoxDecoration(
                                color: Theme.of(context).secondaryHeaderColor,
                                borderRadius: BorderRadius.circular(radius)),
                            child: Column(
                              children: <Widget>[
                                if (kycData.imageAddress.isEmpty &&
                                    kycData.imageIdentity.isEmpty)
                                  Text(
                                    'Importante: Debe subir las imágenes de forma independiente.',
                                    style: Theme.of(context).textTheme.subtitle2,
                                    textAlign: TextAlign.center,
                                  ),
                                if (kycData.imageAddress.isEmpty &&
                                    kycData.imageIdentity.isEmpty)
                                  SizedBox(
                                    height: 20,
                                  ),
                                Mutation(
                                    options: MutationOptions(
                                      document: gql(updateImageIdentityKyc),
                                      update: (cache, result) {
                                        print("Result updateImageIdentityKyc = " +
                                            result!.data.toString());

                                        bool success = false;

                                        if (result.data != null) {
                                          success = extractRepositoryData(
                                              "updateImageIdentityKyc",
                                              result.data!)['success'];
                                        }

                                        print("Upload Image IdentityKyc = " +
                                            success.toString());

                                        if (success) {
                                          image = File("");
                                          showToastInfo(
                                              "Se ha subido el fichero saticfactoriamente!");
                                          SmartDialog.dismiss();
                                        }

                                        if (result.data == null) {
                                          showToast(
                                              "Lo sentimos, ha ocurrido un error al subir el fichero. "
                                                  "Compruebe su conexión a Internet.");
                                          SmartDialog.dismiss();
                                        }

                                        setState(() {});
                                      },
                                      onCompleted: (dynamic resultData) {},
                                    ),
                                    builder: (RunMutation runMutation, result) {
                                      return Container(
                                        //margin: EdgeInsets.only(left: 10, right: 10),
                                        //alignment: Alignment.centerLeft,
                                        //padding: EdgeInsets.symmetric(horizontal: 48),
                                        child: Column(
                                          //crossAxisAlignment: CrossAxisAlignment.,
                                          children: [
                                            Text(
                                              'Prueba de Identidad',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1,
                                            ),
                                            if (kycData.imageIdentity.isNotEmpty)
                                              Text(
                                                "Subida",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2,
                                              ),
                                            if (kycData.imageIdentity.isEmpty)
                                              Text(
                                                "No subida",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2,
                                              ),
                                            if (kycData.imageIdentity.isEmpty &&
                                                image.path.isEmpty)
                                              GestureDetector(
                                                  onTap: () {
                                                    selImage();
                                                  },
                                                  child: SelectImgBnt(
                                                      bntText:
                                                      "Click para seleccionar Prueba de Identidad")),
                                            if (image.path.toString().isNotEmpty &&
                                                kycData.imageIdentity.isEmpty)
                                              GestureDetector(
                                                onTap: () {
                                                  SmartDialog.showLoading(
                                                      backDismiss: false);
                                                  runMutation({
                                                    'id': kycData.id,
                                                    'file': multipartFile,
                                                  });
                                                },
                                                child: UploadImgBnt(
                                                    bntText:
                                                    "Haga clic para subir la imagen!"),
                                              )
                                          ],
                                        ),
                                      );
                                    }),
                                SizedBox(
                                  height: 10,
                                ),
                                Mutation(
                                    options: MutationOptions(
                                      document: gql(updateImageAddressKyc),
                                      update: (cache, result) {
                                        print("Result updateImageAddressKyc = " +
                                            result!.data.toString());

                                        bool success = false;

                                        if (result.data != null) {
                                          success = extractRepositoryData(
                                              "updateImageAddressKyc",
                                              result.data!)['success'];
                                        }

                                        print("Upload Image IdentityKyc = " +
                                            success.toString());

                                        if (success) {
                                          image = File("");
                                          showToastInfo(
                                              "Se ha subido el fichero saticfactoriamente!");
                                          SmartDialog.dismiss();
                                        }

                                        if (result.data == null) {
                                          showToast(
                                              "Lo sentimos, ha ocurrido un error al subir el fichero. "
                                                  "Compruebe su conexión a Internet.");
                                          SmartDialog.dismiss();
                                        }

                                        setState(() {});
                                      },
                                      onCompleted: (dynamic resultData) {},
                                    ),
                                    builder: (RunMutation runMutation, result) {
                                      return Container(
                                        //margin: EdgeInsets.only(left: 10, right: 10),
                                        //alignment: Alignment.centerLeft,
                                        //padding: EdgeInsets.symmetric(horizontal: 48),
                                        child: Column(
                                          //crossAxisAlignment: CrossAxisAlignment.,
                                          children: [
                                            Text(
                                              'Prueba de Dirección',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1,
                                            ),
                                            if (kycData.imageAddress.isNotEmpty)
                                              Text(
                                                "Subida",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2,
                                              ),
                                            if (kycData.imageAddress.isEmpty)
                                              Text(
                                                "No subida",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2,
                                              ),
                                            if (kycData.imageAddress.isEmpty &&
                                                kycData.imageIdentity.isNotEmpty &&
                                                image.path.isEmpty)
                                              GestureDetector(
                                                  onTap: () {
                                                    selImage();
                                                  },
                                                  child: SelectImgBnt(
                                                      bntText:
                                                      "Click para seleccionar Prueba de Dirección")),
                                            if (image.path.toString().isNotEmpty &&
                                                kycData.imageIdentity.isNotEmpty &&
                                                kycData.imageAddress.isEmpty)
                                              GestureDetector(
                                                onTap: () {
                                                  SmartDialog.showLoading(
                                                      backDismiss: false);
                                                  runMutation({
                                                    'id': kycData.id,
                                                    'file': multipartFile,
                                                  });
                                                },
                                                child: UploadImgBnt(
                                                    bntText:
                                                    "Haga clic para subir la imagen!"),
                                              )
                                          ],
                                        ),
                                      );
                                    }),
                              ],
                            ),
                          ),
                        if (kycnoempty)
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            margin: EdgeInsets.all(margingcomponents),
                            //padding: EdgeInsets.all(paddingcomponents),
                            decoration: BoxDecoration(
                                color: Theme.of(context).secondaryHeaderColor,
                                borderRadius: BorderRadius.circular(radius)),
                            child: Column(
                              children: <Widget>[
                                Container(
                                    child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  KYCEdit(kycData: kycData),
                                            ),
                                          );
                                        },
                                        child: PrimaryButton(
                                            bntText: "Modificar KYC"))),
                              ],
                            ),
                          ),
                        if (!kycnoempty)
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            margin: EdgeInsets.all(margingcomponents),
                            padding: EdgeInsets.all(paddingcomponents),
                            decoration: BoxDecoration(
                                color: Theme.of(context).secondaryHeaderColor,
                                borderRadius: BorderRadius.circular(radius)),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.all(margingcomponents),
                                  child: Text(
                                    txt_kycnofound,
                                    style: Theme.of(context).textTheme.subtitle2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (!kycnoempty)
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            margin: EdgeInsets.all(margingcomponents),
                            //padding: EdgeInsets.all(paddingcomponents),
                            decoration: BoxDecoration(
                                color: Theme.of(context).secondaryHeaderColor,
                                borderRadius: BorderRadius.circular(radius)),
                            child: Column(
                              children: <Widget>[
                                Container(
                                    child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  KYCEdit(kycData: kycData),
                                            ),
                                          );
                                        },
                                        child:
                                        PrimaryButton(bntText: "Subir KYC"))),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ],
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Future selImage() async {
    var pickedFile;
    pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      print("Image Path = " + image.path.toString());
      print("Image Size = " + image.lengthSync().toString() + " Bytes");

      if (image.lengthSync() < 2097152) {
        byteData = image.readAsBytesSync();
        String filename = userData.username +
            '_' +
            '${DateTime.now().year}' +
            '${DateTime.now().month}' +
            '${DateTime.now().day}' +
            '_' +
            '${DateTime.now().hour}' +
            '${DateTime.now().minute}' +
            '${DateTime.now().second}' +
            '.jpg';

        multipartFile = MultipartFile.fromBytes(
          'photo',
          byteData,
          filename: filename,
          contentType: MediaType("image", "jpg"),
        );

        setState(() {});
      } else {
        pickedFile == null;
        showToast(
            "El fichero no puede ser mayor a 2 MB, por favor intenlo otra vez");
      }
    } else {
      showToast("No ha selecionado ninguna imagen.");
    }
  }
}

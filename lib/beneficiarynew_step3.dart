import 'dart:io';
import 'package:com_globalboxtransactions_app/data/Beneficiary.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';

import 'package:com_globalboxtransactions_app/beneficiaries.dart';
import 'package:com_globalboxtransactions_app/common/components.dart';
import 'package:com_globalboxtransactions_app/common/mutationsandquerys.dart';
import 'package:com_globalboxtransactions_app/data/Bank.dart';
import 'package:com_globalboxtransactions_app/widgets/bankitem.dart';
import 'package:com_globalboxtransactions_app/widgets/transferitem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'common/funtions.dart';
import 'common/varsandconts.dart';

class BeneficiaryNew_Step3 extends StatefulWidget {
  final String id;
  final String name;
  final bool edit;
  final Beneficiary beneficiaryedit;

  BeneficiaryNew_Step3(
      {required this.id,
      required this.name,
      required this.beneficiaryedit,
      required this.edit});

  @override
  _BeneficiaryNew_Step3State createState() => _BeneficiaryNew_Step3State();
}

class _BeneficiaryNew_Step3State extends State<BeneficiaryNew_Step3> {
  final picker = ImagePicker();
  File image = new File("");
  var byteData;
  var multipartFile;

  bool localimageselected = false;

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
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          title: Text(
            txt_addbeneficiariesstep3,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline3,
          ),
          elevation: 0.0,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Stack(
                children: [
                  ClipOval(
                    child: Material(
                        color: Colors.transparent, child: getImageWidget()),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    getImage(ImageSource.gallery);
                  },
                  child: PrimaryButton(bntText: "Galería"),
                ),
                SizedBox(width: 15),
                Container(
                  child: GestureDetector(
                    onTap: () {
                      getImage(ImageSource.camera);
                    },
                    child: PrimaryButton(bntText: "Cámara"),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            if (multipartFile != null)
              Mutation(
                  options: MutationOptions(
                    document: gql(updateImageBeneficiary),
                    update: (cache, result) {
                      print("Result updateBeneficiary = " +
                          result!.data.toString());

                      bool success = false;

                      if (result.data != null) {
                        success = extractRepositoryData(
                            "updateBeneficiary", result.data!)['success'];
                      }

                      print("Upload Image updateBeneficiary = " +
                          success.toString());

                      if (success) {
                        image = File("");
                        showToastInfo(
                            "Se ha subido el fichero saticfactoriamente!");
                        SmartDialog.dismiss();
                        gotoBeneficiary();
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
                      padding: EdgeInsets.all(paddingcomponents),
                      child: GestureDetector(
                        onTap: () {
                          if (multipartFile != null) {
                            SmartDialog.showLoading(backDismiss: false);
                            runMutation({
                              'id': widget.id,
                              'file': multipartFile,
                            });
                          }
                        },
                        child: PrimaryButton(bntText: "Subir Imagen"),
                      ),
                    );
                  }),
            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.all(paddingcomponents),
              child: GestureDetector(
                onTap: () {
                  gotoBeneficiary();
                },
                child: PrimaryButton(bntText: "Omitir"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void gotoBeneficiary() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Beneficiaries(),
      ),
    );
  }

  getImage(ImageSource source) async {
    var pickedFile;

    pickedFile = await picker.getImage(source: source, imageQuality: 0);

    File? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile!.path,
        compressQuality: 60,
        maxHeight: 500,
        maxWidth: 500,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
              ]
            : [
                CropAspectRatioPreset.square,
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));

    if (pickedFile != null) {
      image = File(croppedFile!.path);
      print("Image Path = " + image.path.toString());
      print("Image Size = " + image.lengthSync().toString() + " Bytes");

      if (image.lengthSync() < 12097152) {
        byteData = image.readAsBytesSync();
        String filename = userData.username +
            '_beneficiary_' +
            widget.id +
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
        localimageselected = true;
        setState(() {});
      } else {
        pickedFile = null;
        image = File("");
        multipartFile = null;
        showToast(
            "El fichero no puede ser mayor a 2 Mb, por favor intenlo otra vez");
      }
    } else {
      showToast("No ha selecionado ninguna imagen.");
    }
  }

  Widget getImageWidget() {
      if(widget.edit && localimageselected){
        return Image.file(image, width: 256, height: 256, fit: BoxFit.cover);
      }

      if(widget.edit){
            if(widget.beneficiaryedit.image.isEmpty){
              return Image.asset(
                'assets/images/icon_nophotopeople.png',
                width: 256,
                height: 256,
              );
            } else {
              return Image.network(imageURL + widget.beneficiaryedit.image,
                  width: 256, height: 256, fit: BoxFit.cover);
            }
      } else {
        if(localimageselected){
          return Image.file(image, width: 256, height: 256, fit: BoxFit.cover);
        } else {
          return Image.asset(
            'assets/images/icon_nophotopeople.png',
            width: 256,
            height: 256,
          );
        }
      }
  }
}
import 'dart:io';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:com_globalboxtransactions_app/common/varsandconts.dart';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'common/funtions.dart';
import 'common/mutationsandquerys.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
              "Profile",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline3,
            ),
            elevation: 0.0,
          ),
          body: ListView(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Center(
                    child: Stack(
                      children: [
                        ClipOval(
                          child: Material(
                            color: Colors.transparent,
                            child: Ink.image(
                              image: NetworkImage(imageURL + userData.profileImage.toString()),
                              fit: BoxFit.cover,
                              width: 128,
                              height: 128,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 4,
                          child: ClipOval(
                                child: Mutation(
                                    options: MutationOptions(
                                      document: gql(updateImageProfile),
                                      update: (cache, result) {
                                        print(
                                            "Result updateImageProfile = " +
                                                result!.data.toString());

                                        bool success = false;

                                        if (result.data != null) {
                                          success = extractRepositoryData(
                                              "updateImageProfile",
                                              result.data!)['success'];
                                        }

                                        print("Upload Image updateImageProfile = " +
                                            success.toString());

                                        if (success) {
                                          image = File("");
                                          showToastInfo(
                                              "Se ha subido el fichero saticfactoriamente!");
                                          userData.profileImage = extractRepositoryData(
                                              "updateImageProfile",
                                              result.data!)['userNode']['profileImage'];
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
                                      return GestureDetector(
                                        onTap: () async {
                                          await getImage(ImageSource.gallery);
                                          if (multipartFile != null) {
                                            SmartDialog.showLoading(
                                                backDismiss: false);
                                            runMutation({
                                              'id': userData.pk,
                                              'file': multipartFile,
                                            });
                                          }
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          color: Theme.of(context).primaryColor,
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      );
                                    })
                          )
                        ),
                      ],
                    ),
                      ),
                  SizedBox(height: 20,),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    margin: EdgeInsets.all(margingcomponents),
                    padding: EdgeInsets.all(paddingcomponents),
                    decoration: BoxDecoration(
                        color: Theme.of(context).secondaryHeaderColor,
                        borderRadius: BorderRadius.circular(radius)
                    ),
                    child: Column(
                      children: <Widget> [
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          //alignment: Alignment.centerLeft,
                          //padding: EdgeInsets.symmetric(horizontal: 48),
                          child: Column(
                            //crossAxisAlignment: CrossAxisAlignment.,
                            children: [
                              Text('Usuario',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              Text(userData.username,
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          //alignment: Alignment.topLeft,
                          //padding: EdgeInsets.symmetric(horizontal: 48),
                          child: Column(
                            //crossAxisAlignment: CrossAxisAlignment.,
                            children: [
                              Text('KYC',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              Text('Denegado',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                    ],
                  ),
                ],
              ),
          )
      );
  }

  // Future selImage() async {
  //   var pickedFile;
  //   pickedFile = await picker.getImage(source: ImageSource.gallery);
  //
  //   if (pickedFile != null) {
  //     image = File(pickedFile.path);
  //     print("Image Path = " + image.path.toString());
  //     print("Image Size = " + image.lengthSync().toString() + " Bytes");
  //
  //     if (image.lengthSync() < 2097152){
  //       byteData = image.readAsBytesSync();
  //       String filename = userData.username + '_profile' +
  //           '_' +
  //           '${DateTime.now().year}' +
  //           '${DateTime.now().month}' +
  //           '${DateTime.now().day}' +
  //           '_' +
  //           '${DateTime.now().hour}' +
  //           '${DateTime.now().minute}' +
  //           '${DateTime.now().second}' +
  //           '.jpg';
  //
  //       multipartFile = MultipartFile.fromBytes(
  //         'photo',
  //         byteData,
  //         filename: filename,
  //         contentType: MediaType("image", "jpg"),
  //       );
  //       return multipartFile;
  //       setState(() {});
  //     } else {
  //       pickedFile == null;
  //       showToast("El fichero no puede ser mayor a 2 Mb, por favor intenlo otra vez");
  //       return null;
  //     }
  //   } else {
  //     showToast("No ha selecionado ninguna imagen.");
  //     return null;
  //   }
  // }

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
      print("Image Profile Path = " + image.path.toString());
      print("Image Profile Size = " + image.lengthSync().toString() + " Bytes");

      if (image.lengthSync() < 12097152) {
        byteData = image.readAsBytesSync();
        String filename = userData.username +
            '_profile' +
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
}


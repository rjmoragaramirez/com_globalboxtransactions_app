import 'package:com_globalboxtransactions_app/common/varsandconts.dart';
import 'package:flutter/material.dart';

class InputPassWordWithIcon extends StatefulWidget {
  final IconData icon;
  final String hint;

  InputPassWordWithIcon({required this.icon, required this.hint});

  @override
  _InputPassWordWithIconState createState() => _InputPassWordWithIconState();
}

class _InputPassWordWithIconState extends State<InputPassWordWithIcon> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor, width: 2),
          borderRadius: BorderRadius.circular(radius)),
      child: Row(
        children: <Widget>[
          Container(
            width: widthcomponents,
            child: Icon(
              widget.icon,
              size: 20,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Expanded(
              child: TextFormField(
                style: Theme.of(context).textTheme.bodyText1,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: radius),
                  border: InputBorder.none,
                  hintText: widget.hint,
                  hintStyle: Theme.of(context).textTheme.bodyText1,
                ),
                obscureText: true,
              )),
        ],
      ),
    );
  }
}

class InputWithIcon extends StatefulWidget {
  //const InputWithIcon({Key? key}) : super(key: key);
  final IconData icon;
  final String hint;

  InputWithIcon({required this.icon, required this.hint});

  @override
  _InputWithIconState createState() => _InputWithIconState();
}

class _InputWithIconState extends State<InputWithIcon> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor, width: 2),
          borderRadius: BorderRadius.circular(radius)),
      child: Row(
        children: <Widget>[
          Container(
            width: widthcomponents,
            child: Icon(
              widget.icon,
              size: 20,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Expanded(
            child: TextField(
              style: Theme.of(context).textTheme.bodyText1,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: radius),
                border: InputBorder.none,
                hintText: widget.hint,
                hintStyle: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PrimaryButton extends StatefulWidget {
  final String bntText;
  PrimaryButton({required this.bntText});

  @override
  __PrimaryButtonStateState createState() => __PrimaryButtonStateState();
}

class __PrimaryButtonStateState extends State<PrimaryButton> {

   //var _buttonBackgroupColor = Theme.of(context).primaryColor;
  // var _buttonTextColor = Color(0xffe9d0a0);

  // var _buttonBackgroupColor = Colors.grey.shade800;
  // var _buttonTextColor = Color(0xffe9d0a0);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).secondaryHeaderColor,
          borderRadius: BorderRadius.circular(radius)),
      padding: EdgeInsets.all(paddingcomponents),
      child: Center(
        child: Text(
          widget.bntText,
          style: Theme.of(context).textTheme.button,
        ),
      ),
    );
  }
}

class OutlineBnt extends StatefulWidget {
  //const OutlineBnt({Key? key}) : super(key: key);
  final String bntText;
  OutlineBnt({required this.bntText});

  @override
  _OutlineBntState createState() => _OutlineBntState();
}

class _OutlineBntState extends State<OutlineBnt> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).secondaryHeaderColor, width: 2),
          borderRadius: BorderRadius.circular(radius)),
      padding: EdgeInsets.all(paddingcomponents),
      child: Center(
        child: Text(
          widget.bntText,
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
    );
  }
}

class RedOutlineBnt extends StatefulWidget {
  //const OutlineBnt({Key? key}) : super(key: key);
  final String bntText;
  RedOutlineBnt({required this.bntText});

  @override
  _RedOutlineBntState createState() => _RedOutlineBntState();
}

class _RedOutlineBntState extends State<RedOutlineBnt> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).hintColor, width: 2),
          borderRadius: BorderRadius.circular(radius)),
      padding: EdgeInsets.all(paddingcomponents),
      child: Center(
        child: Text(
          widget.bntText,
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
    );
  }
}

class SelectImgBnt extends StatefulWidget {
  //const OutlineBnt({Key? key}) : super(key: key);
  final String bntText;
  SelectImgBnt({required this.bntText});

  @override
  _SelectImgBntState createState() => _SelectImgBntState();
}

class _SelectImgBntState extends State<SelectImgBnt> {

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //     border: Border.all(color: Theme.of(context).hintColor, width: 2),
      //     borderRadius: BorderRadius.circular(radius)),
      padding: EdgeInsets.all(paddingcomponents),
      child: Center(
        child: Column(
          children: <Widget>[
            Icon(Icons.image_outlined,
              color: Theme.of(context).primaryColor,
              size: 50,
            ),
            Text(
              widget.bntText,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        )


      ),
    );
  }
}

class UploadImgBnt extends StatefulWidget {
  //const OutlineBnt({Key? key}) : super(key: key);
  final String bntText;
  UploadImgBnt({required this.bntText});

  @override
  _UploadImgBntState createState() => _UploadImgBntState();
}

class _UploadImgBntState extends State<UploadImgBnt> {

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //     border: Border.all(color: Theme.of(context).hintColor, width: 2),
      //     borderRadius: BorderRadius.circular(radius)),
      padding: EdgeInsets.all(paddingcomponents),
      child: Center(
          child: Column(
            children: <Widget>[
              Icon(Icons.upload_file,
                color: Theme.of(context).primaryColor,
                size: 50,
              ),
              Text(
                widget.bntText,
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          )


      ),
    );
  }
}
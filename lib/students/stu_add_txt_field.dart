// ignore_for_file: non_constant_identifier_names, camel_case_types, must_be_immutable

import 'package:flutter/material.dart';

class Tex_fi extends StatefulWidget {
  Color input_text_color;
  // IconData field_icon;
  // Color icon_color;
  Color? focus_color = Colors.white;
  Color bar_color;
  String lable;
  String? hint_text;
  Color? lable_color;
  double radius_circle;
  final bool? secure_text;
  final TextEditingController control;
  double? verti;
  double? horizo;

  Tex_fi(
      {super.key,
      required this.input_text_color,
      required this.bar_color,
      // required this.field_icon,
      this.focus_color,
      // required this.icon_color,
      required this.radius_circle,
      required this.lable,
      required this.lable_color,
      this.hint_text,
      this.secure_text,
      required this.control,
      this.horizo,
      this.verti});
  @override
  State<Tex_fi> createState() => _Tex_fiState();
}

class _Tex_fiState extends State<Tex_fi> {
  bool? secure;
  // late TextEditingController controler;
  var controler = TextEditingController();
  // final tex_contr
  @override
  void initState() {
    super.initState();
    secure = widget.secure_text;
    controler = widget.control;
    // print("${widget.verti}");
    controler.addListener(() => setState(() {}));
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   controler.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.horizo,
      height: widget.verti, //?? 50,
      child: TextFormField(
        // keyboardType: TextInputType.number,
        obscureText: secure ?? false,
        controller: controler,
        style: TextStyle(
          height: 1,
          color: widget.input_text_color,
        ),

        //------------- Decorationns starts HERE------------------------------------
        decoration: InputDecoration(
          //-------------------FOR FOCUS BORDER  !!!!!!--------------------------------
          suffixIcon: controler.text.isEmpty
              ? Container(width: 0.0)
              : IconButton(
                  onPressed: () {
                    controler.clear();
                  },
                  icon: Icon(
                    Icons.cancel_outlined,
                    color: widget.focus_color ?? Colors.white,
                  )),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: widget.focus_color ?? Colors.white,
            ),
            // borderRadius: BorderRadius.circular(25),
          ),
          //-----------------------------------------------------------------
          // prefixIcon: Icon(
          //   widget.field_icon,
          //   color: widget.icon_color,
          // ),
          labelStyle: TextStyle(
              height: 0,
              color: widget.lable_color,
              fontSize: 16.0,
              fontWeight: FontWeight.w400),

          // hintText: widget.hint_text,
          labelText: widget.lable,
//---------Enable this if you want the lable needs to place with the border--------
          floatingLabelBehavior: FloatingLabelBehavior.always,
//--------------------------LABLE END---------------------------------------------
          //------------------------FOR NORMAL BORDER !!!! ---------------------------------
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: widget.bar_color,
            ),
            // if(radius_circle) ...[
            borderRadius: BorderRadius.circular(widget.radius_circle),
            // ],
          ),
          //----------------------------------------------------------------------------
        ),
      ),
    );
  }
}

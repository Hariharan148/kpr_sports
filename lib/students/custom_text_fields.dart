import 'package:flutter/material.dart';

nameField({
  required TextEditingController control,
  required String lableText,
  required Color inputTextColor,
  Color? focusColor,
  required Color barColor,
  double? verti,
  double? horizo,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        lableText,
        style: const TextStyle(fontSize: 12, fontFamily: "Poppins"),
      ),
      const SizedBox(
        height: 10,
      ),
      SizedBox(
        width: horizo ?? 285,
        height: verti ?? 30,
        child: TextFormField(
          cursorColor: const Color.fromRGBO(20, 42, 80, 1),
          controller: control,
          style: const TextStyle(fontFamily: "Poppins", fontSize: 15),
//------DECORATION OF TEXT FIELD STARTS-----------------------------------------
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 15, right: 15),
              errorStyle: const TextStyle(fontSize: 0.01),
//------FOCUS BORDER STARTS-----------------------------------------------------
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: focusColor ?? Colors.black,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(0)),
//------FOCUS BORDER ENDS-------------------------------------------------------

//------NORMAL BORDER STARTS----------------------------------------------------
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: barColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(0))),
//------NORMAL BORDER ENDS------------------------------------------------------
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "*Required";
            } else if (value.length < 4) {
              return "Enter Valid Name";
            } else {
              return null;
            }
          },
        ),
      ),
    ],
  );
}

rollField({
  required TextEditingController control,
  required String lableText,
  required Color inputTextColor,
  Color? focusColor,
  required Color barColor,
  double? verti,
  double? horizo,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        lableText,
        style: const TextStyle(fontSize: 12, fontFamily: "Poppins"),
      ),
      const SizedBox(
        height: 10,
      ),
      SizedBox(
        width: horizo ?? 285,
        height: verti ?? 30,
        child: TextFormField(
          cursorColor: const Color.fromRGBO(20, 42, 80, 1),
          controller: control,
          style: const TextStyle(fontFamily: "Poppins", fontSize: 15),
//------DECORATION OF TEXT FIELD STARTS-----------------------------------------
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 15, right: 15),
              errorStyle: const TextStyle(fontSize: 0.01),
//------FOCUS BORDER STARTS-----------------------------------------------------
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: focusColor ?? Colors.black,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(0)),
//------FOCUS BORDER ENDS-------------------------------------------------------

//------NORMAL BORDER STARTS----------------------------------------------------
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: barColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(0))),
//------NORMAL BORDER ENDS------------------------------------------------------
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "*Required";
            } else if (value.length < 4) {
              return "Enter Valid Roll No.";
            } else {
              return null;
            }
          },
        ),
      ),
    ],
  );
}

sectionField({
  required TextEditingController control,
  required String lableText,
  required Color inputTextColor,
  Color? focusColor,
  required Color barColor,
  double? verti,
  double? horizo,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        lableText,
        style: const TextStyle(fontSize: 12, fontFamily: "Poppins"),
      ),
      const SizedBox(
        height: 10,
      ),
      SizedBox(
        width: horizo ?? 285,
        height: verti ?? 30,
        child: TextFormField(
          cursorColor: const Color.fromRGBO(20, 42, 80, 1),
          controller: control,
          style: const TextStyle(fontFamily: "Poppins", fontSize: 15),
//------DECORATION OF TEXT FIELD STARTS-----------------------------------------
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 15, right: 15),
              errorStyle: const TextStyle(fontSize: 0.01),
//------FOCUS BORDER STARTS-----------------------------------------------------
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: focusColor ?? Colors.black,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(0)),
//------FOCUS BORDER ENDS-------------------------------------------------------

//------NORMAL BORDER STARTS----------------------------------------------------
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: barColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(0))),
//------NORMAL BORDER ENDS------------------------------------------------------
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "*Required";
            } else if (value.length > 4) {
              return "Enter Valid Section";
            } else {
              return null;
            }
          },
        ),
      ),
    ],
  );
}
deptField({
  required TextEditingController control,
  required String lableText,
  required Color inputTextColor,
  Color? focusColor,
  required Color barColor,
  double? verti,
  double? horizo,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        lableText,
        style: const TextStyle(fontSize: 12, fontFamily: "Poppins"),
      ),
      const SizedBox(
        height: 10,
      ),
      SizedBox(
        width: horizo ?? 285,
        height: verti ?? 30,
        child: TextFormField(
          cursorColor: const Color.fromRGBO(20, 42, 80, 1),
          controller: control,
          style: const TextStyle(fontFamily: "Poppins", fontSize: 15),
//------DECORATION OF TEXT FIELD STARTS-----------------------------------------
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 15, right: 15),
              errorStyle: const TextStyle(fontSize: 0.01),
//------FOCUS BORDER STARTS-----------------------------------------------------
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: focusColor ?? Colors.black,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(0)),
//------FOCUS BORDER ENDS-------------------------------------------------------

//------NORMAL BORDER STARTS----------------------------------------------------
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: barColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(0))),
//------NORMAL BORDER ENDS------------------------------------------------------
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "*Required";
            } else if (value.length < 2) {
              return "Enter Valid Dept.";
            } else {
              return null;
            }
          },
        ),
      ),
    ],
  );
}
yearField({
  required TextEditingController control,
  required String lableText,
  required Color inputTextColor,
  Color? focusColor,
  required Color barColor,
  double? verti,
  double? horizo,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        lableText,
        style: const TextStyle(fontSize: 12, fontFamily: "Poppins"),
      ),
      const SizedBox(
        height: 10,
      ),
      SizedBox(
        width: horizo ?? 285,
        height: verti ?? 30,
        child: TextFormField(
          cursorColor: const Color.fromRGBO(20, 42, 80, 1),
          controller: control,
          style: const TextStyle(fontFamily: "Poppins", fontSize: 15),
//------DECORATION OF TEXT FIELD STARTS-----------------------------------------
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 15, right: 15),
              errorStyle: const TextStyle(fontSize: 0.01),
//------FOCUS BORDER STARTS-----------------------------------------------------
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: focusColor ?? Colors.black,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(0)),
//------FOCUS BORDER ENDS-------------------------------------------------------

//------NORMAL BORDER STARTS----------------------------------------------------
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: barColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(0))),
//------NORMAL BORDER ENDS------------------------------------------------------
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "*Required";
            } else if (value.length < 1) {
              return "Enter Valid Year";
            } else {
              return null;
            }
          },
        ),
      ),
    ],
  );
}
bloodField({
  required TextEditingController control,
  required String lableText,
  required Color inputTextColor,
  Color? focusColor,
  required Color barColor,
  double? verti,
  double? horizo,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        lableText,
        style: const TextStyle(fontSize: 12, fontFamily: "Poppins"),
      ),
      const SizedBox(
        height: 10,
      ),
      SizedBox(
        width: horizo ?? 285,
        height: verti ?? 30,
        child: TextFormField(
          cursorColor: const Color.fromRGBO(20, 42, 80, 1),
          controller: control,
          style: const TextStyle(fontFamily: "Poppins", fontSize: 15),
//------DECORATION OF TEXT FIELD STARTS-----------------------------------------
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 15, right: 15),
              errorStyle: const TextStyle(fontSize: 0.01),
//------FOCUS BORDER STARTS-----------------------------------------------------
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: focusColor ?? Colors.black,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(0)),
//------FOCUS BORDER ENDS-------------------------------------------------------

//------NORMAL BORDER STARTS----------------------------------------------------
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: barColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(0))),
//------NORMAL BORDER ENDS------------------------------------------------------
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "*Required";
            } else if (value.length < 1) {
              return "Enter Blood Group";
            } else {
              return null;
            }
          },
        ),
      ),
    ],
  );
}

sportField({
  required TextEditingController control,
  required String lableText,
  required Color inputTextColor,
  Color? focusColor,
  required Color barColor,
  double? verti,
  double? horizo,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        lableText,
        style: const TextStyle(fontSize: 12, fontFamily: "Poppins"),
      ),
      const SizedBox(
        height: 10,
      ),
      SizedBox(
        width: horizo ?? 285,
        height: verti ?? 30,
        child: TextFormField(
          cursorColor: const Color.fromRGBO(20, 42, 80, 1),
          style: const TextStyle(fontFamily: "Poppins", fontSize: 15),
          controller: control,
//------DECORATION OF TEXT FIELD STARTS-----------------------------------------
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 15, right: 15),
              errorStyle: const TextStyle(fontSize: 0.01),
//------FOCUS BORDER STARTS-----------------------------------------------------
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: focusColor ?? Colors.black,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(0)),
//------FOCUS BORDER ENDS-------------------------------------------------------

//------NORMAL BORDER STARTS----------------------------------------------------
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: barColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(0))),
//------NORMAL BORDER ENDS------------------------------------------------------
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "*Required";
            } else if (value.length < 4) {
              return "Enter Valid Sport";
            } else {
              return null;
            }
          },
        ),
      ),
    ],
  );
}

emailField({
  required TextEditingController control,
  required String lableText,
  required Color inputTextColor,
  Color? focusColor,
  required Color barColor,
  double? verti,
  double? horizo,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        lableText,
        style: const TextStyle(fontSize: 12, fontFamily: "Poppins"),
      ),
      const SizedBox(
        height: 10,
      ),
      SizedBox(
        width: horizo ?? 285,
        height: verti ?? 30,
        child: TextFormField(
          cursorColor: const Color.fromRGBO(20, 42, 80, 1),
          controller: control,
          style: const TextStyle(fontFamily: "Poppins", fontSize: 15),
//------DECORATION OF TEXT FIELD STARTS-----------------------------------------
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 15, right: 15),
              errorStyle: const TextStyle(fontSize: 0.01),
//------FOCUS BORDER STARTS-----------------------------------------------------
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: focusColor ?? Colors.black,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(0)),
//------FOCUS BORDER ENDS-------------------------------------------------------

//------NORMAL BORDER STARTS----------------------------------------------------
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: barColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(0))),
//------NORMAL BORDER ENDS------------------------------------------------------
          validator: (value) {
            final emailRegex =
                RegExp(r'([\w-\.]+@kpriet.ac.in)|([\w-\.]+@gmail.com)$');
            if (value!.isEmpty) {
              return "*Required";
            } else if (emailRegex.hasMatch(value)) {
              return null;
            } else {
              return "Enter Valid Email";
            }
          },
        ),
      ),
    ],
  );
}

phoneField({
  required TextEditingController control,
  required String lableText,
  required Color inputTextColor,
  Color? focusColor,
  required Color barColor,
  double? verti,
  double? horizo,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        lableText,
        style: const TextStyle(fontSize: 12, fontFamily: "Poppins"),
      ),
      const SizedBox(
        height: 10,
      ),
      SizedBox(
        width: horizo ?? 285,
        height: verti ?? 30,
        child: TextFormField(
          cursorColor: const Color.fromRGBO(20, 42, 80, 1),
          style: const TextStyle(fontFamily: "Poppins", fontSize: 15),
          maxLength: 10,
          controller: control,
//------DECORATION OF TEXT FIELD STARTS-----------------------------------------
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 15, right: 15),
              counterText: "",
              errorStyle: const TextStyle(fontSize: 0.01),
//------FOCUS BORDER STARTS-----------------------------------------------------
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: focusColor ?? Colors.black,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(0)),
//------FOCUS BORDER ENDS-------------------------------------------------------

//------NORMAL BORDER STARTS----------------------------------------------------
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: barColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(0))),
//------NORMAL BORDER ENDS------------------------------------------------------
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "*Required";
            } else if (value.length < 10) {
              return "Enter Valid Phone Number";
            } else {
              return null;
            }
          },
        ),
      ),
    ],
  );
}

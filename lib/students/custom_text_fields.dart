import 'package:flutter/material.dart';

nameField(control, text) {
  return TextFormField(
    controller: control,
    decoration:
        InputDecoration(labelText: text, border: const OutlineInputBorder()),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "*Required";
      }
      else if (value.length < 4) {
        return "Enter Valid Name";
      } else {
        return null;
      }
    },
  );
}

rollField(control, text) {
  return TextFormField(
    controller: control,
    decoration:
        InputDecoration(labelText: text, border: const OutlineInputBorder()),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "*Required";
      }
      else if (value.length < 4) {
        return "Enter Valid Roll No.";
      } else {
        return null;
      }
    },
  );
}

sectionField(control, text) {
  return TextFormField(
    controller: control,
    decoration:
        InputDecoration(labelText: text, border: const OutlineInputBorder()),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "*Required";
      }
      else if (value.length < 4) {
        return "Enter Valid Section";
      } else {
        return null;
      }
    },
  );
}

sportField(control, text) {
  return TextFormField(
    controller: control,
    decoration:
        InputDecoration(labelText: text, border: const OutlineInputBorder()),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "*Required";
      }
      else if (value.length < 4) {
        return "Enter Valid Sports";
      } else {
        return null;
      }
    },
  );
}

emailField(control, text) {
  return TextFormField(
    controller: control,
    decoration:
        InputDecoration(labelText: text, border: const OutlineInputBorder()),
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
  );
}

phoneField(control, text) {
  return TextFormField(
    controller: control,
    decoration:
        InputDecoration(labelText: text, border: const OutlineInputBorder()),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "*Required";
      }
      else if (value.length < 10) {
        return "Enter Valid Phone Number";
      } else {
        return null;
      }
    },
  );
}

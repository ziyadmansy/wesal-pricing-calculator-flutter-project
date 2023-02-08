import 'package:flutter/material.dart';

final primaryColor = Colors.blue[900]!;

final kEnabledBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(4),
  borderSide: const BorderSide(
    width: 1,
    color: Colors.grey,
  ),
);

final kDisabledBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(4),
  borderSide: BorderSide(
    width: 1,
    color: Colors.grey.shade300,
  ),
);

final kFocusedBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(4),
  borderSide: BorderSide(
    width: 2,
    color: primaryColor,
  ),
);

final kErrorBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(4),
  borderSide: const BorderSide(
    width: 1,
    color: Colors.red,
  ),
);
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/const.dart';
import 'package:flutter_app/functions/dart/reusable_functions.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/widgets/alert_dialog.dart';

void sendRecoveryEmail(BuildContext context, String inputEmail) async {
  try {
    await auth.sendPasswordResetEmail(email: inputEmail);

    showAlertDialog(context);
  } on FirebaseAuthException catch (ex) {
    if (ex.message == noInternetError) {
      todoModelBox(context, 'No Internet Available');
    }
  } catch (e) {
    todoModelBox(context, '${e.toString()}');
  }
}
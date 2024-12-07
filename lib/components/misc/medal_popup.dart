
// Funzione per mostrare la modale della medaglia
  import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/generated/l10n.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:kebabbo_flutter/main.dart';
void showMedalDialog(BuildContext context) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.success,
    animType: AnimType.scale,
    title: S.of(context).congratulazioni,
    desc: S.of(context).hai_raggiunto_un_nuovo_traguardo_e_ottenuto_una_nuova_medaglia,
    btnOkColor: red,
    btnOkOnPress: () {},
    customHeader: Icon(
      Icons.emoji_events,
      color: Colors.orange,
      size: 100,
    )
    .animate(
      // No need to repeat the animation
    )
    .scaleXY(
      begin: 0.5,
      end: 1.1,
      duration: Duration(seconds: 2),  // Slower animation (increased duration)
      curve: Curves.elasticInOut,
    )
    .fadeIn(duration: Duration(milliseconds: 500)),  // Slightly slower fade-in
  ).show();
}

    void showFirstTimeDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.scale,
      title: S.of(context).first_time_title,
      desc: S.of(context).first_time_description,
      btnOkColor: red,
      btnOkOnPress: () {},
      customHeader: Image.asset(
        'assets/images/kebab.png',  // Your custom PNG image path
        width: 100,
        height: 100,
      ),  // No animation for the image
    ).show();
  }
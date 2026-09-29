// Dialog dell'app (medaglia, benvenuto, apri nell'app).
// Sostituisce awesome_dialog, che tramite rive includeva una libreria nativa
// non compatibile con le pagine di memoria da 16 KB richieste da Google Play.
import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/generated/l10n.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/components/misc/app_launcher.dart';

const String _logoAsset = 'assets/new-logos/logo scritta ad arco-1.png';

/// Dialog con header, titolo, testo scorrevole, bottone OK e opzionale Annulla.
Future<void> showKebabboDialog(
  BuildContext context, {
  required Widget header,
  required String title,
  required String description,
  String? okText,
  VoidCallback? onOk,
  String? cancelText,
  VoidCallback? onCancel,
}) {
  return showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black54,
    transitionDuration: const Duration(milliseconds: 250),
    pageBuilder: (dialogContext, _, __) {
      final maxHeight = MediaQuery.sizeOf(dialogContext).height * 0.8;
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 420, maxHeight: maxHeight),
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    header,
                    const SizedBox(height: 12),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Flexible(
                      child: SingleChildScrollView(
                        child: Text(
                          description,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.4,
                            color: Colors.grey[800],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        if (cancelText != null) ...[
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.of(dialogContext).pop();
                                onCancel?.call();
                              },
                              child: Text(cancelText),
                            ),
                          ),
                          const SizedBox(width: 12),
                        ],
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: red,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.of(dialogContext).pop();
                              onOk?.call();
                            },
                            child: Text(okText ?? 'OK'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
    transitionBuilder: (_, animation, __, child) {
      final curved =
          CurvedAnimation(parent: animation, curve: Curves.easeOutBack);
      return FadeTransition(
        opacity: animation,
        child: ScaleTransition(scale: curved, child: child),
      );
    },
  );
}

void showMedalDialog(BuildContext context) {
  showKebabboDialog(
    context,
    title: S.of(context).congratulazioni,
    description: S
        .of(context)
        .hai_raggiunto_un_nuovo_traguardo_e_ottenuto_una_nuova_medaglia,
    header: const Icon(
      Icons.emoji_events,
      color: Colors.orange,
      size: 100,
    )
        .animate()
        .scaleXY(
          begin: 0.5,
          end: 1.1,
          duration: const Duration(seconds: 2),
          curve: Curves.elasticInOut,
        )
        .fadeIn(duration: const Duration(milliseconds: 500)),
  );
}

void showFirstTimeDialog(BuildContext context) {
  showKebabboDialog(
    context,
    title: S.of(context).first_time_title,
    description: S.of(context).first_time_description,
    header: Image.asset(_logoAsset, width: 100, height: 100),
  );
}

void showAppInstallDialog(BuildContext context) {
  showKebabboDialog(
    context,
    title: S.of(context).app_is_installed,
    description: S.of(context).app_is_installed_description,
    header: Image.asset(_logoAsset, width: 100, height: 100),
    okText: S.of(context).open_in_app,
    onOk: openApp,
    cancelText: S.of(context).no_thanks,
  );
}

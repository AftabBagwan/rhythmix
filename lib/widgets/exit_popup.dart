import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rhythmix/utils/colors.dart';

class ExitPopup extends StatefulWidget {
  const ExitPopup({super.key});

  @override
  State<ExitPopup> createState() => _ExitPopupState();
}

class _ExitPopupState extends State<ExitPopup> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        Navigator.pop(context);
      },
      child: Dialog(
        key: const Key('exitPopUp'),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
          width: width * 0.81,
          constraints: const BoxConstraints(
            maxHeight: 130,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xff979797),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
              colors: [Color(0xff101010), Color(0xff252525)],
              stops: [0, 1],
              begin: Alignment(-0.00, -1.00),
              end: Alignment(0.00, 1.00),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                "Are you sure want to exit?",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.transparent,
                      shape: const StadiumBorder(),
                      side: BorderSide(color: AppColors.grey, width: 1.5),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                      ),
                    ),
                    child: const Text(
                      "No",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      exit(0);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.transparent,
                      shape: const StadiumBorder(),
                      side: BorderSide(color: AppColors.grey, width: 1.5),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                      ),
                    ),
                    child: const Text(
                      "Yes",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rhythmix/providers/bottom_nav_provider.dart';
import 'package:rhythmix/utils/colors.dart';
import 'package:rhythmix/utils/utils.dart';
import 'package:rhythmix/widgets/exit_popup.dart';

class OfflineScreen extends StatelessWidget {
  const OfflineScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final bottombarProvider = Provider.of<BottomNavProvider>(context);
    return PopScope(
      onPopInvoked: (didPop) {
        Utils.checkInternet().then((value) {
          if (value) {
            bottombarProvider.changePage(0);
            return true;
          } else {
            _exitPopup(context);
            return true;
          }
        });
      },
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.signal_wifi_connected_no_internet_4_sharp,
                size: 60,
                color: Color(0xfff1f1f1),
              ),
              Center(
                child: Text(
                  "Your internet isn't working.",
                  style: TextStyle(
                    color: Color(0xfff1f1f1),
                    fontWeight: FontWeight.w700,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        //bottomNavigationBar: const NavBar(),
      ),
    );
  }

  Future<Future> _exitPopup(context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: const Color(0xff191919).withOpacity(0.9),
      builder: (BuildContext context) {
        return const ExitPopup();
      },
    );
  }
}

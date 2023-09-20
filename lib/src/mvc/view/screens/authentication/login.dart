import 'package:flutter/material.dart';

import '../../../model/models.dart';
import '../../model_widgets.dart';

class Login extends StatelessWidget {
  const Login({
    super.key,
    required this.userSession,
  });

  final UserSession userSession;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        // leading: AppBarActionButton(
        //   icon: context.backButtonIcon,
        //   onTap: () {},
        // ),
      ),
      body: const Column(
        children: [
          CustomBackgroundTop(
            showLogo: true,
          ),
        ],
      ),
    );
  }
}

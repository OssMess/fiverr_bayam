import 'package:flutter/material.dart';

import '../../../model/models.dart';

class Page5Profile extends StatelessWidget {
  const Page5Profile({
    super.key,
    required this.userSession,
  });

  final UserSession userSession;

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView();
  }
}

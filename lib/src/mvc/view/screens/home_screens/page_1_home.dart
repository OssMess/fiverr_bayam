import 'package:flutter/material.dart';

import '../../../model/models.dart';

class Page1Home extends StatelessWidget {
  const Page1Home({
    super.key,
    required this.userSession,
  });

  final UserSession userSession;

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView();
  }
}

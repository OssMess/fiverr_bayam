import 'package:flutter/material.dart';

import '../../../model/models.dart';

class Page2Messages extends StatelessWidget {
  const Page2Messages({
    super.key,
    required this.userSession,
  });

  final UserSession userSession;

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView();
  }
}

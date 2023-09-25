// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:badges/badges.dart' as badge;

import '../../../../extensions.dart';
import '../../../model/change_notifiers.dart';
import '../../../model/enums.dart';
import '../../../model/models.dart';
import '../../model_widgets.dart';
import '../../../../settings.dart';
import '../../../../tools.dart';
import '../../screens.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({
    super.key,
    required this.notifierViewMode,
  });

  final NotifierViewMode notifierViewMode;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomRefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            16.sliverSp,
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../mvc/model/enums.dart';
import '../tools.dart';

extension AccountTypeExtensions on AccountType {
  String translate(BuildContext context) {
    return Functions.of(context).translateKey(
      this == AccountType.person ? 'person' : 'company',
    );
  }

  String get getString => {
        AccountType.company: 'company',
        AccountType.person: 'person',
      }[this]!;
}

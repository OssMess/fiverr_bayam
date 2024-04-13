import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../extensions.dart';
import '../../../../tools.dart';
import '../../../controller/services.dart';
import '../../../model/enums.dart';
import '../../../model/list_models.dart';
import '../../../model/models.dart';
import '../../../model/models_ui.dart';
import '../../model_widgets.dart';
import '../../model_widgets_screens.dart';

class PickPreferences extends StatefulWidget {
  const PickPreferences({
    super.key,
    required this.userSession,
  });

  final UserSession userSession;

  @override
  State<PickPreferences> createState() => _PickPreferencesState();
}

class _PickPreferencesState extends State<PickPreferences> {
  Set<CategorySub> pickedPreferences = {};

  Debouncer debouncer = Debouncer(milliseconds: 500);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        if (widget.userSession.listCategoriesSub != null) {
          setState(() {
            widget.userSession.listCategoriesSub?.onResetSearch();
            pickedPreferences.addAll(
              widget.userSession.listCategoriesSub!.list.where(
                (element) => (widget.userSession.preferences ?? [])
                    .contains(element.uuid),
              ),
            );
          });
        } else {
          widget.userSession.listCategoriesSub!.initData(callGet: true).then(
            (_) {
              if (widget.userSession.listCategoriesSub != null) {
                pickedPreferences.addAll(
                  widget.userSession.listCategoriesSub!.list.where(
                    (element) => (widget.userSession.preferences ?? [])
                        .contains(element.uuid),
                  ),
                );
              }
            },
          );
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    widget.userSession.listCategories?.onResetSearch();
    widget.userSession.listCategoriesSub?.onResetSearch();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      floatingActionButton: CustomElevatedButton(
        onPressed: next,
        label: AppLocalizations.of(context)!.continu,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        children: [
          CustomAppBarBackground(
            type: AppBarBackgroundType.shrink,
            appBarTitleWidget: const CustomAppBarLogo(),
            appBarLeading: AppBarActionButton(
              icon: context.backButtonIcon,
              onTap: () => context.pop(),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.sp),
              child: ChangeNotifierProvider.value(
                value: widget.userSession.listCategoriesSub!,
                child: Consumer<ListCategoriesSub>(
                  builder: (context, list, _) {
                    if (list.isNull) {
                      return const Align(
                        alignment: Alignment.topCenter,
                        child: CustomLoadingIndicator(
                          isSliver: false,
                        ),
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!
                              .select_at_least_nb_preferences,
                          style: Styles.poppins(
                            fontSize: 18.sp,
                            fontWeight: Styles.semiBold,
                            color: context.textTheme.displayLarge!.color,
                          ),
                        ),
                        16.heightSp,
                        CustomTextFormField(
                          prefixIcon: AwesomeIcons.magnifying_glass,
                          suffixIcon: AwesomeIcons.sliders_outlined,
                          onChanged: (value) {
                            debouncer.run(
                              () {
                                widget.userSession.listCategoriesSub
                                    ?.onUpdateSearch(value);
                              },
                            );
                          },
                        ),
                        Expanded(
                          child: ListView.separated(
                            padding: EdgeInsets.only(
                              top: 32.sp,
                              bottom: context.viewPadding.bottom + 90.sp,
                            ),
                            itemBuilder: (context, index) => StatefulBuilder(
                              builder: (context, setState) {
                                CategorySub preference =
                                    list.list.elementAt(index);
                                return PreferenceCheckListTile(
                                  checked: pickedPreferences
                                      .map((element) => element.uuid)
                                      .contains(preference.uuid),
                                  preference: preference,
                                  onChange: (added) {
                                    if (added) {
                                      pickedPreferences.add(preference);
                                    } else {
                                      pickedPreferences.remove(preference);
                                    }
                                    setState(() {});
                                  },
                                );
                              },
                            ),
                            separatorBuilder: (_, __) => 24.heightSp,
                            itemCount: list.list.length,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> next() async {
    if (pickedPreferences.length < 3) {
      Dialogs.of(context).showSnackBar(
        message: AppLocalizations.of(context)!.select_at_least_nb_preferences,
      );
      return;
    }
    widget.userSession.preferences =
        pickedPreferences.map((e) => e.uuid).toList();
    Dialogs.of(context).runAsyncAction(
      future: () => UserServices.of(widget.userSession).post(context),
      onComplete: (_) => context.pop(),
    );
  }
}

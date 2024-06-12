import '../../../config.dart';
import '../../../models/select_language_model.dart';

class RadioButtonLayout extends StatelessWidget {
  final SelectLanguageModel? data;
  final int? index, selectIndex;
  final GestureTapCallback? onTap;

  const RadioButtonLayout(
      {Key? key, this.data, this.selectIndex, this.index, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const VSpace(Sizes.s20),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(children: [
          Image.asset(data!.image!, height: Sizes.s40, width: Sizes.s40)
              .decorated(boxShadow: [
            BoxShadow(
                color: appCtrl.isTheme
                    ? Colors.transparent
                    : appCtrl.appTheme.lightGray.withOpacity(0.2),
                blurRadius: 3,
                spreadRadius: 3)
          ], shape: BoxShape.circle),
          const HSpace(Sizes.s12),
          Text(data!.title!.toString().tr,
              style: AppCss.outfitMedium18.textColor(appCtrl.appTheme.black))
        ]),
        Container(
            padding: const EdgeInsets.all(Insets.i3),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: selectIndex == index
                        ? appCtrl.appTheme.primary
                        : appCtrl.appTheme.lightGray)),
            child: Icon(Icons.circle,
                size: 10,
                color: selectIndex == index
                    ? appCtrl.appTheme.primary
                    : Colors.transparent))
      ]).inkWell(onTap: onTap),
      if (index != 5) const VSpace(Sizes.s20),
      if (index != 5) const Divider(height: 1, thickness: 1)
    ]);
  }
}
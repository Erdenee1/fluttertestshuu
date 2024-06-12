import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';

import '../../../../config.dart';

class CheckThisOut extends StatelessWidget {
  final dynamic data;

  const CheckThisOut({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
            decoration: ShapeDecoration(
                color: appCtrl.isTheme
                    ? appCtrl.appTheme.white.withOpacity(.05)
                    : appCtrl.appTheme.white,
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        width: 1,
                        color: appCtrl.appTheme.lightGray.withOpacity(0.2)),
                    borderRadius: BorderRadius.circular(8))),
            child: Column(children: [
              Row(children: [
                CachedNetworkImage(
                    imageUrl: data['Image'],
                    imageBuilder: (context, imageProvider) => Image(
                          image: imageProvider,
                          height: Sizes.s28,
                          width: Sizes.s28,
                        ),
                    placeholder: (context, url) => Image.asset(
                        eImageAssets.logo,
                        height: Sizes.s28,
                        width: Sizes.s28),
                    errorWidget: (context, url, error) => Image.asset(
                        eImageAssets.logo,
                        height: Sizes.s28,
                        width: Sizes.s28)),
                const HSpace(Sizes.s10),
                Text(data['Title'],
                    style: TextStyle(
                        color: appCtrl.appTheme.black,
                        fontSize: FontSizes.f14,
                        fontWeight: FontWeight.w500))
              ]).paddingAll(Insets.i10),
              Container(
                  width: Sizes.s140,
                  height: 0.5,
                  color: appCtrl.appTheme.moreLightGray),
              Text(data['subTitle'] ?? "Web version",
                      style: TextStyle(
                          color: appCtrl.appTheme.gray,
                          fontSize: FontSizes.f14,
                          fontWeight: FontWeight.w400))
                  .alignment(Alignment.bottomLeft)
                  .paddingSymmetric(
                      vertical: Insets.i5, horizontal: AppRadius.r10)
            ]))
        .inkWell(onTap: () {log("webview==>${data}");
          Get.toNamed(routeName.webView, arguments: data);});
  }
}

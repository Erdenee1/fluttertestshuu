import 'package:app/config.dart';
import 'package:app/widgets/directionality_rtl.dart';
import 'package:intl/intl.dart';

class NotificationList extends StatelessWidget {
  const NotificationList({super.key});

  @override
  Widget build(BuildContext context) {
    return DirectionalityRtl(
      child: Scaffold(
        backgroundColor: appCtrl.appTheme.white,
        appBar: appCtrl.isAppBar
            ? AppBar(
                iconTheme: IconThemeData(color: appCtrl.appTheme.white),
                flexibleSpace: isGradient
                    ? Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: <Color>[
                            appCtrl.appTheme.gradient1,
                            appCtrl.appTheme.gradient2
                          ])))
                    : null,
                backgroundColor: appCtrl.appTheme.primary,
                elevation: 0,
                title: Text(appFonts.notification.tr,
                    style:
                        AppCss.outfitMedium18.textColor(appCtrl.appTheme.white)),
                centerTitle: appCtrl.headerTitlePosition == "start"
                    ? true
                    : false 
                )
            : null,
        body: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection("notification").snapshots(),
            builder: (context, snap) {
              if (snap.hasData) {
                if (snap.data!.docs.isNotEmpty) {
                  return ListView(children: [
                    ...snap.data!.docs.asMap().entries.map((element) {
                      return Container(
                        decoration: BoxDecoration(
                            color: appCtrl.appTheme.white,
                            borderRadius: BorderRadius.circular(AppRadius.r10),
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      appCtrl.appTheme.primary.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 4)
                            ]),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Row(children: [
                                Expanded(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                      Text(element.value['title'],
                                          style: AppCss.outfitBold16
                                              .textColor(appCtrl.appTheme.black)),
                                      const VSpace(Sizes.s8),
                                      Text(element.value['des'],
                                          style: AppCss.outfitMedium14
                                              .textColor(appCtrl.appTheme.gray)
                                              .letterSpace(.5))
                                    ]).paddingSymmetric(vertical: Insets.i10))
                              ])),
                              Column(children: [
                                if (element.value['createdDate'] != null &&
                                    element.value['createdDate'] != "")
                                  Text(
                                    DateFormat('hh:mm a').format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            int.parse(element.value["createdDate"]
                                                .toString()
                                                .toString()))),
                                    style: AppCss.outfitMedium12
                                        .textColor(appCtrl.appTheme.gray),
                                  ).padding(top: Insets.i15, bottom: Insets.i5),
                                if (element.value['image'] != null &&
                                    element.value['image'] != "")
                                  Image.network(element.value.data()['image'],
                                      height: Sizes.s50, width: Sizes.s50)
                              ])
                            ]).paddingSymmetric(
                            horizontal: Insets.i20, vertical: Insets.i10),
                      ).paddingSymmetric(
                          horizontal: Insets.i20, vertical: Insets.i5);
                    })
                  ]).marginOnly(top: Insets.i10);
                } else {
                  return Container();
                }
              } else {
                return Container();
              }
            }),
      ),
    );
  }
}

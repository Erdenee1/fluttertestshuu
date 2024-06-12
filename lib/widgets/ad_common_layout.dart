

import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../config.dart';
import '../controllers/other_controller/ad_controller.dart';

class AdCommonLayout extends StatelessWidget {
  final AlignmentGeometry? alignment;
  final BannerAd? bannerAd;
  final bool bannerAdIsLoaded;
  final Widget? currentAd;
  const AdCommonLayout({Key? key, this.alignment,this.bannerAdIsLoaded = false,this.bannerAd,this.currentAd }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdController>(
        builder: (addCtrl) {
          return StreamBuilder(
            stream: FirebaseFirestore.instance.collection("adsConfiguration").snapshots(),
            builder: (context,snap) {
              bool isGoogle = true,isAddVisible =true;
              if(snap.hasData){
                if(snap.data!.docs.isNotEmpty){
                  isGoogle = snap.data!.docs[0].data()['googleAdsVisible'];
                  isAddVisible = snap.data!.docs[0].data()['isAdVisible'];
                }
              }

              return isAddVisible? Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  isGoogle
                          ? (addCtrl.bannerAd != null && addCtrl.bannerAdIsLoaded)
                          ? AdWidget(ad: addCtrl.bannerAd!)
                          .height(Sizes.s50)
                          .paddingOnly(bottom: Insets.i10)
                          .width(MediaQuery.of(context).size.width)
                          : Container()
                          : Container(
                          alignment: Alignment.bottomCenter,
                          child:currentAd)
                          .paddingSymmetric(
                          vertical: Insets.i10, horizontal: Insets.i20)
                          .width(MediaQuery.of(context).size.width)
                ],
              ):Container();
            }
          );
        }
    );
  }
}
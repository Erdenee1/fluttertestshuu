
import '../../../config.dart';
import '../../../widgets/directionality_rtl.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  void initState() {
    addCtrl.onInterstitialAdShow();
    setState(() {

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return DirectionalityRtl(
      child: Scaffold(
        backgroundColor: appCtrl.appTheme.backgroudColor,
        appBar: AppBar(
          iconTheme: IconThemeData(color: appCtrl.appTheme.black),
          backgroundColor: appCtrl.appTheme.backgroudColor,
          title: Text(
            appFonts.aboutUs.toString().tr,
            style: AppCss.outfitMedium18.textColor(appCtrl.appTheme.black),
          ),
        ),
        body:    Stack(alignment: Alignment.bottomCenter,
        children: [
          ListView(

            children: [
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("socialConfig")
                      .where("title", isEqualTo: 'desc')
                      .snapshots(),
                  builder: (context, snapShot) {
                    if (snapShot.hasData) {
                      if (snapShot.data!.docs.isNotEmpty) {
                        return Text(snapShot.data!.docs[0].data()['url'],style: AppCss.outfitMedium16.textColor(appCtrl.appTheme.black).letterSpace(.5).textHeight(1.2)).paddingSymmetric(horizontal: Insets.i20);
                      } else {
                        return Container();
                      }
                    } else {
                      return Container();
                    }
                  }),
              const VSpace(Sizes.s20),
              GridView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(bottom: Insets.i100),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: appCtrl.socialLink.length,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 20,
                      mainAxisExtent: 90,
                      mainAxisSpacing: 20.0,
                      crossAxisCount: 3),
                  itemBuilder: (context, index) {

                    return Column(
                      children: [
                        Image.network(
                          appCtrl.socialLink[index]['image'],
                          height: Sizes.s40,
                          width: Sizes.s40,


                        ),
                        const VSpace(Sizes.s10),
                        Text(appCtrl.socialLink[index]['name'].toString().replaceAll(" Link", ""),style: AppCss.outfitMedium14.textColor(appCtrl.appTheme.black),),
                      ],
                    ).inkWell(
                        onTap: () =>
                            Get.toNamed(routeName.webView, arguments: {
                              "URL": appCtrl.socialLink[index]['url']
                            }));
                  }).paddingAll(Insets.i20),
            ],
          ),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("socialConfig")
                  .where("title", isEqualTo: 'copyRight')
                  .snapshots(),
              builder: (context, snapShot) {
                if (snapShot.hasData) {
                  if (snapShot.data!.docs.isNotEmpty) {
                    return Text(snapShot.data!.docs[0].data()['url']).paddingOnly(bottom: Insets.i20);
                  } else {
                    return Container();
                  }
                } else {
                  return Container();
                }
              }),
        ],
      ).height(MediaQuery.of(context).size.height),
      ),
    );
  }
}

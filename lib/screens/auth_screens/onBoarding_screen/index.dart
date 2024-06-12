
import '../../../config.dart';

class OnBoardingScreen extends StatelessWidget {
  final onBoardingCtrl = Get.put(OnBoardingController());
  final DocumentSnapshot<Map<String, dynamic>> uc;


  OnBoardingScreen({super.key, required this.uc});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBoardingController>(
      builder: (onBoardingCtrl) {
        return Scaffold(
            backgroundColor: const Color(0xFFFAFAFC),
            body: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("config").snapshots(),
                builder: (context, snapShot) {

                  if (snapShot.hasData) {
                    var data = snapShot.data!.docs[0].data();

                    return Stack(
                      children: [
                        data['onBoardingVariant'] == 1
                            ? const OnBoardingVariant1()
                            : data['onBoardingVariant'] == 2
                                ? OnBoardingVariant2()
                                : OnBoardingVariant3()
                      ],
                    );
                  } else {
                    return Container();
                  }
                }));
      }
    );
  }
}

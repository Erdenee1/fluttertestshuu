import '../../../../config.dart';

class PageViewCommon extends StatelessWidget {
  final dynamic image;

  const PageViewCommon({Key? key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBoardingController>(builder: (onBoardingCtrl) {
      return SizedBox(
          height: Sizes.s550,
          child: Image.network(
            image,
            height: Sizes.s300,
            fit: BoxFit.contain,
          ));
    });
  }
}

import '../config.dart';

class CommonLoader extends StatelessWidget {
  const CommonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return appCtrl.isLoading ? Center(
        child: SizedBox(
            height: 70,width: 200,
            child: Image.network(appCtrl.loaderStyle,color:appCtrl.color,height: 70))):Container();
  }
}

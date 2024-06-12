import 'dart:developer';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:dartx/dartx_io.dart';
import 'dart:convert';

import '../../config.dart';
import '../../widgets/common_button.dart';
import '../../widgets/text_field_common.dart';

class CallFunc extends StatefulWidget {
  const CallFunc({super.key});

  @override
  CallFuncState createState() => CallFuncState();
}

class CallFuncState extends State<CallFunc> {
  bool isLoading = true, isCircular = false;
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  bool isDocHave = false, isCheckAK = true;
  DocumentSnapshot<Map<String, dynamic>>? doc, uc;
  String sV1 = "", sV2 = "", sV3 = "", sV4 = "", sV5 = "", sV6 = "", sV7 = "";

  String k20 = appFonts.codeBase;
  String k21 = appFonts.akCodeBase64Id;
  String k22 = appFonts.akCodeBaseLink;
  String k27 = a2V5;
  bool isA1 = false, isA2 = false, isA3 = false, isA4 = false;

  initialise() async {
    isLoading = true;

    await a25.then((mn) async {
      log("MMM :$mn");
      if (mn.exists) {
        final docHae = mn.data();

        List list = docHae!.keys.toList().sorted();

        list.asMap().entries.forEach((a) {
          if (a.key == 0) {
            isA1 = ak76(k22) == ak76(a.value);
          }
          if (a.key == 1) {
            isA2 = ak76(k20) == ak76(a.value);
          }
          if (a.key == 2) {

            isA3 = ak76(k27) == ak76(a.value);
          }
          if (a.key == 3) {
            isA4 = ak76(k21) == ak76(a.value);
          }
        });

        setState(() {});

        if (isA1) {
          if (isA2) {
            if (isA3) {
              if (isA4) {
                await rmt().then((e) {
                  doc = e;
                  setState(() {});
                });

                await uct().then((e) {
                  uc = e;
                  setState(() {});
                });

                setState(() {});
                isDocHave = true;
                isCheckAK = false;
                isLoading = false;
              } else {
                setState(() {
                  isDocHave = false;
                  isCheckAK = false;
                  isLoading = false;
                });
              }
            } else {
              setState(() {
                isDocHave = false;
                isCheckAK = false;
                isLoading = false;
              });
            }
          } else {
            setState(() {
              isDocHave = false;
              isCheckAK = false;
              isLoading = false;
            });
          }
        } else {
          setState(() {
            isDocHave = false;
            isCheckAK = false;
            isLoading = false;
          });
        }
      } else {
        setState(() {
          isDocHave = false;
          isCheckAK = false;
          isLoading = false;
        });
      }
    }).catchError((onError) async {
      isCheckAK = false;
      isLoading = false;
      setState(() {});
      if (happens(onError)) {
        isDocHave = false;
        flutterAlertMessage(msg: onError.message);
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    initialise();

    super.initState();
  }

  FirebaseApp? app = Firebase.app();

  dest2(String c, String sk3, String sk4) async {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    final dio = Dio();
    isCircular = true;
    setState(() {});

    String k98 = app!.options.projectId;
    String k10 = k64(appFonts.codeBase);
    String k11 = k64(appFonts.akCodeBase64Id);
    String k12 = k64(appFonts.akCodeBaseLink);
    String k13 = k64(c);
    String k14 = k64(sk3);
    String k15 = k64(sk4);
    String k16 = k64(appFonts.akCodeBaseLink24);
    String k17 = k64(a2V5);
    String k18 = k64(appFonts.dG9uZUlk);
    String k19 = appFonts.occ;
    var data = {k17: k13, k10: k14, k11: k15, k12: k98, k18: k19};
    try {
      var response = await dio.post(k16, data: data);
      if (response.statusCode == 200) {

        var responseData = response.data;

        sV2 = a2V5;
        sV1 = appFonts.codeBase;
        sV6 = appFonts.akCodeBase64Id;
        sV3 = appFonts.akCodeBaseLink;

        await r25
            .set({sV2: c, sV1: k15, sV6: sk4, sV3: ak76(k98)}).then((v) async {
          await rmt().then((e) {
            doc = e;
            setState(() {});
          });

          await uct().then((e) {
            uc = e;
            setState(() {});
          });
          isCircular = false;
          setState(() {});
          successSheet(doc, uc)!;
        }).catchError((onError) async {
          isCheckAK = false;
          setState(() {});
          if (happens(onError)) {
            isDocHave = false;
            flutterAlertMessage(msg: onError.message);
            setState(() {});
          }
        });
      } else {
        isCircular = false;
        setState(() {});
      }
    } catch (e) {
      isCircular = false;
      setState(() {});
      if (e is DioException) {
        if (e.type == DioExceptionType.badResponse) {
          final response = e.response;
          if (response != null && response.data != null) {
            flutterAlertMessage(msg: response.data['message']);
          }
        } else {
          final response = e.response;
          if (response != null && response.data != null) {
            final Map responseData =
                json.decode(response.data as String) as Map;
            flutterAlertMessage(msg: responseData['message']);
          }
        }
      }
    }
  }

  final _controller = TextEditingController();
  final userName = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(this.context).size.height;

    return !isDocHave
        ? isLoading
            ? Scaffold(
                backgroundColor: appCtrl.appTheme.primary,
                body: Stack(alignment: Alignment.center, children: [
                  SizedBox(
                      child: Image.asset(eImageAssets.logo, fit: BoxFit.fill).center()),
                ]))
            : Scaffold(
                backgroundColor: appCtrl.appTheme.white,
                appBar: AppBar(
                  centerTitle: true,
                  title: Text(appFonts.checkLicense.tr,
                      style: GoogleFonts.outfit(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: appCtrl.appTheme.primary)),
                  backgroundColor: appCtrl.appTheme.white,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                ),
                body: Stack(children: [
                  Center(
                      child: ListView(
                          padding: const EdgeInsets.all(20),
                          children: <Widget>[
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, h / 10, 0, h / 8),
                            child: Column(children: [
                              Text(appFonts.linkApp.tr,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.outfit(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: appCtrl.appTheme.black,
                                  ).textHeight(1.8)),
                              const VSpace(Sizes.s20)
                            ])),
                        Text(appFonts.pasteCode.tr,
                                textAlign: TextAlign.center,
                                style: AppCss.outfitBold16
                                    .textColor(appCtrl.appTheme.primary))
                            .alignment(Alignment.topLeft),
                        const VSpace(Sizes.s20),
                        Form(
                            key: _formKey,
                            child: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 17, 15, 15),
                                decoration: BoxDecoration(
                                  color: appCtrl.appTheme.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: appCtrl.appTheme.lightGray
                                            .withOpacity(0.5),
                                        blurRadius: AppRadius.r5,
                                        spreadRadius: AppRadius.r2)
                                  ],
                                ),
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(appFonts.userName.tr,
                                          style: GoogleFonts.outfit(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: appCtrl.appTheme.black)),
                                      const VSpace(Sizes.s8),

                                      TextFieldCommon(
                                          controller: userName,
                                          hintText:
                                              appFonts.localUsername.tr,
                                          keyboardType: TextInputType.text,
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: appCtrl.appTheme.gray
                                                      .withOpacity(.15)),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppRadius.r8)),
                                          fillColor: const Color.fromRGBO(
                                              153, 158, 166, .1),
                                          validator: (val) {
                                            if (val == null || val.isEmpty) {
                                              return 'Хоосон байж болохгүй';
                                            }

                                            return null;
                                          }),
                                      const VSpace(Sizes.s28),
                                      Text(appFonts.code_.tr,
                                          style: GoogleFonts.outfit(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: appCtrl.appTheme.black,
                                          )),
                                      const VSpace(Sizes.s8),
                                      TextFieldCommon(
                                        controller: _controller,
                                        hintText:
                                            'xxxxxx-xxx-xxxxx-xxx-xxx-xxxxxx-xx',
                                        keyboardType: TextInputType.text,
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: appCtrl.appTheme.gray
                                                    .withOpacity(.15)),
                                            borderRadius: BorderRadius.circular(
                                                AppRadius.r8)),
                                        fillColor: const Color.fromRGBO(
                                            153, 158, 166, .1),
                                        validator: (text) {
                                          if (text == null || text.isEmpty) {
                                            return 'Хоосон байж болохгүй';
                                          }
                                          if (text.length < 4) {
                                            return 'Богинохон байна';
                                          }
                                          return null;
                                        },
                                      ),
                                      const VSpace(Sizes.s40),
                                      CommonButton(
                                          title: appFonts.checkLicense.tr,
                                          margin: 0,
                                          style: AppCss.outfitMedium14
                                              .textColor(
                                                  appCtrl.appTheme.white),
                                          onTap: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              if (_controller.text.isNotEmpty &&
                                                  (_controller.text
                                                              .trim()
                                                              .length ==
                                                          36 ||
                                                      _controller.text
                                                              .trim()
                                                              .length ==
                                                          23)) {
                                                dest2(
                                                    ak76(_controller.text),
                                                    ak76(userName.text),
                                                    ak76(appFonts.fontSizeKey));
                                              } else {
                                                flutterAlertMessage(
                                                    msg:
                                                        '36 урт эсвэл 23 урт код оруулна уу');
                                              }
                                            }
                                          }),

                                      const SizedBox(height: 7)
                                    ])))
                      ])),
                  if (isCircular)
                    const Center(child: CircularProgressIndicator())
                ]))
        : isLoading
            ? Scaffold(
                backgroundColor: appCtrl.appTheme.primary,
                body: Stack(alignment: Alignment.center, children: [
                  SizedBox(
                      child: Image.asset(eImageAssets.logo, fit: BoxFit.fill)),

                ]))
            : isDocHave
                ? !isCheckAK
                    ? SplashScreen(rm: doc!, uc: uc!)
                    : SplashScreen(rm: doc!, uc: uc!)
                : Scaffold(
                    backgroundColor: appCtrl.appTheme.primary,
                    body: Stack(alignment: Alignment.center, children: [
                      SizedBox(
                          child:
                              Image.asset(eImageAssets.logo, fit: BoxFit.fill)),
                   
                    ]));
  }

  String reverse(String string) {
    if (string.length < 2) {
      return string;
    }

    final characters = Characters(string);
    return characters.toList().reversed.join();
  }
}

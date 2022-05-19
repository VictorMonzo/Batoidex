import 'dart:async';

import 'package:batoidex_bat/bottom_navigation_bar.dart';
import 'package:batoidex_bat/services/MyColors.dart';
import 'package:batoidex_bat/services/MyFunctions.dart';
import 'package:batoidex_bat/services/firebase/FirebaseAuth.dart';
import 'package:batoidex_bat/ui/background/background.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VerifyEmailForm extends StatefulWidget {
  const VerifyEmailForm({Key? key}) : super(key: key);

  @override
  State<VerifyEmailForm> createState() => _VerifyEmailFormState();
}

class _VerifyEmailFormState extends State<VerifyEmailForm> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
          const Duration(seconds: 3), (_) => checkEmailVerified());
    }
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      MyFunctions().toast(
          AppLocalizations.of(context)!.emailsent, MyColors().greenLight);

      setState(() {
        canResendEmail = false;
      });
      await Future.delayed(const Duration(seconds: 5));
      setState(() {
        canResendEmail = true;
      });
    } catch (e) {
      MyFunctions().toast(e.toString(), MyColors().redDegradedLight);
    }
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return isEmailVerified
        ? const MyBottomNavigationBar()
        : Material(
            child: Stack(
              children: [
                Background(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 60),
                      child: SizedBox(
                        width: width * 0.7,
                        child: Text(
                          AppLocalizations.of(context)!.verifyEmail,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 150,
                      child: Stack(
                        children: [
                          Container(
                            height: 150,
                            margin: const EdgeInsets.only(
                              right: 70,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(100),
                                bottomRight: Radius.circular(100),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 0,
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 16, right: 32),
                                child: Text(
                                  AppLocalizations.of(context)!.resentEmail,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              child: Container(
                                margin: const EdgeInsets.only(right: 15),
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Colors.green[200]!.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                  shape: BoxShape.circle,
                                  gradient: const LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Color(0xff1bccba),
                                      Color(0xff22e2ab),
                                    ],
                                  ),
                                ),
                                child: const Icon(
                                  Icons.arrow_forward_outlined,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              ),
                              onTap: () {
                                canResendEmail ? sendVerificationEmail() : null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          child: Container(
                            margin: const EdgeInsets.only(right: 16, top: 16),
                            child: Text(
                              AppLocalizations.of(context)!.cancel,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[400],
                              ),
                            ),
                          ),
                          onTap: () => MyFirebaseAuthService().signOut(),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 16, top: 24),
                          child: SizedBox(
                            width: width * 0.7,
                            child: Text(
                              AppLocalizations.of(context)!
                                  .verificationEmailHasBeenSentToYourEmail,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xffe98f60),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          );
  }
}

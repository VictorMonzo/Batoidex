import 'package:batoidex_bat/ui/background/background.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../services/firebase/FirebaseAuth.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({Key? key}) : super(key: key);

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  validateForm() {
    return formKey.currentState!.validate();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Material(
      child: Stack(
        children: [
          Background(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 60),
                child: SizedBox(
                  width: width * 0.5,
                  child: Text(
                    AppLocalizations.of(context)!.resetPassword,
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
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 16, right: 32),
                              child: TextFormField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  hintStyle: const TextStyle(fontSize: 20),
                                  border: InputBorder.none,
                                  icon:
                                      const Icon(Icons.account_circle_rounded),
                                  hintText: AppLocalizations.of(context)!.email,
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (email) => email != null &&
                                        !EmailValidator.validate(email)
                                    ? AppLocalizations.of(context)!
                                        .enterValidEmail
                                    : null,
                              ),
                            ),
                          ],
                        ),
                      ),
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
                                color: Colors.green[200]!.withOpacity(0.5),
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
                          if (validateForm()) {
                            MyFirebaseAuthService().resetPassword(
                                emailController.text.trim(), context);
                          }
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
                        AppLocalizations.of(context)!.back,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[400],
                        ),
                      ),
                    ),
                    onTap: () => Navigator.pop(context),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 16, top: 24),
                    child: SizedBox(
                      width: width * 0.82,
                      child: Text(
                        AppLocalizations.of(context)!
                            .receiveAnEmailToResetYourPassword,
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

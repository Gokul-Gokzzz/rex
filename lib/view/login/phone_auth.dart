// ignore_for_file: empty_catches

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rexparts/controller/login_provider.dart';
import 'package:rexparts/widget/popup_widget.dart';
import 'package:rexparts/widget/text_widget.dart';

class OtpPage extends StatelessWidget {
  final formkey = GlobalKey<FormState>();

  OtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: TextWidget().text(
          data: "OTP",
          size: 24.0,
          weight: FontWeight.bold,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Consumer<LoginProvider>(
                  builder: (context, value, child) => TextFormField(
                    controller: loginProvider.phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      prefixIcon: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: InkWell(
                          onTap: () {
                            showCountryPicker(
                              context: context,
                              countryListTheme: const CountryListThemeData(
                                bottomSheetHeight: 500,
                              ),
                              onSelect: (value) {
                                loginProvider.selectCountry = value;
                              },
                            );
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                value.selectCountry.flagEmoji,
                                style: const TextStyle(fontSize: 20),
                              ),
                              SizedBox(width: size.width * .03),
                              Text(
                                "+${value.selectCountry.phoneCode}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      labelText: 'Enter Phone Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * .02),
                ElevatedButton(
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      try {
                        if (loginProvider.phoneController.text.length == 10) {
                          loginProvider.getOtp(
                            "+${loginProvider.selectCountry.phoneCode}${loginProvider.phoneController.text}",
                          );
                          PopupWidgets().showSuccessSnackbar(
                              context, "OTP sent Successfully");
                        } else {
                          PopupWidgets().showSuccessSnackbar(
                              context, "Please check your mobile number");
                        }
                      } catch (e) {}
                    }
                    loginProvider.showOtp();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                  ),
                  child: TextWidget().text(
                    data: "Send OTP",
                    size: 18.0,
                    weight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20.0),
                Consumer<LoginProvider>(
                  builder: (context, value, child) {
                    if (value.showOtpField == true) {
                      return Column(
                        children: [
                          TextFormField(
                            controller: loginProvider.otpController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Enter OTP',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          ElevatedButton(
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                try {
                                  loginProvider.verifyOtp(
                                      loginProvider.otpController.text,
                                      context);
                                } catch (e) {
                                  PopupWidgets().showSuccessSnackbar(
                                      context, "Invalid OTP $e");
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(
                                vertical: 15.0,
                                horizontal: 10,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: TextWidget().text(
                              data: 'Verify OTP',
                              size: 18.0,
                              weight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/screens/otp_validate_screen.dart';
import 'package:myapp/core/widgets/custom_button.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final TextEditingController phoneController = TextEditingController();
  final String _countryCode = "+91";
  Widget elevatedButtonText = Text(
    "CONTINUE",
    style: GoogleFonts.montserrat(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: const Color(0xffFFFFFF),
    ),
  );
  bool isCalledFromAuth = true;

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  void sendOTP() async {
    setState(() {
      elevatedButtonText = const Center(
        child: CircularProgressIndicator(),
      );
    });

    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: "$_countryCode${phoneController.text.trim()}",
        verificationCompleted: (phoneAuthCredential) async {
          await _firebaseAuth.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (error) {
          throw Exception(error.toString());
        },
        codeSent: (verificationId, forceResendingToken) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => OtpValidationScreen(
                verificationId: verificationId,
                sendOtpAgain: sendOTP,
                phone: phoneController.text,
              ),
            ),
          );
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      debugPrint(
        e.toString(),
      );
    }
    setState(() {
      elevatedButtonText = Text(
        "CONTINUE",
        style: GoogleFonts.montserrat(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: const Color(0xffFFFFFF),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 150,
          ),
          Text(
            'Please enter your mobile number',
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 11,
          ),
          Text(
            'You’ll receive a 4 digit code \nto verify next.',
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              color: const Color(0xff6A6C7B),
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 21,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: phoneController,
              cursorColor: Colors.grey,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Mobile Number",
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/indiaFlag.png'),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        '+91',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        '-',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 21,
          ),
          const SizedBox(
            height: 21,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomButton(
              buttonText: elevatedButtonText,
              onTap: () async {
                await FirebaseAuth.instance.verifyPhoneNumber(
                  phoneNumber: "$_countryCode${phoneController.text.trim()}",
                  verificationCompleted: (PhoneAuthCredential credential) {},
                  verificationFailed: (FirebaseAuthException e) {
                    throw Exception(e.toString());
                  },
                  codeSent: (String verificationId, int? resendToken) {},
                  codeAutoRetrievalTimeout: (String verificationId) {},
                );
              },
            ),
          ),
          const Spacer(),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              'assets/waterWave2.png',
              fit: BoxFit.fitWidth,
            ),
          ),
        ],
      ),
    );
  }
}

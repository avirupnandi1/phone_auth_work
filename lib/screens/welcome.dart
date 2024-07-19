import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/screens/auth_screen.dart';
import 'package:myapp/core/widgets/custom_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<WelcomeScreen> {
  List languages = ["English", "Hindi", "Bengali"];
  String val = "English";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 200,
            ),
            Image.asset(
              'assets/gallery_image.png',
              scale: 1.1,
            ),
            const SizedBox(
              height: 21,
            ),
            Text(
              'Please select your Language',
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 11,
            ),
            Text(
              'You can change the language \nat any time.',
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
            Container(
              width: 220,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xff2F3037),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      val,
                      style: GoogleFonts.montserrat(
                        color: const Color(0xff2F3037),
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    DropdownButton(
                        items: languages
                            .map(
                              (value) => DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              ),
                            )
                            .toList(),
                        onChanged: (changedValue) {
                          setState(() {
                            val = changedValue!;
                          });
                        })
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 21,
            ),
            CustomButton(
              buttonText: Text(
                "NEXT",
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xffFFFFFF),
                ),
              ),
              width: 220,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const AuthScreen(),
                  ),
                );
              },
            ),
            const Spacer(),
            Stack(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    'assets/waveblue.png',
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Positioned(
                  top: 10,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      'assets/waveFade.png',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

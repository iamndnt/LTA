import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:women_safety_app/utils/quotes.dart';

class CustomAppBar extends StatelessWidget {
  // const CustomAppBar({super.key});
  Function? onTap;
  int? quoteIndex;
  CustomAppBar({this.onTap, this.quoteIndex});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap!();
      },
      child: Container(
        child: Text(sweetSayings[quoteIndex!],
            style: GoogleFonts.roboto(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic)),
      ),
    );
  }
}

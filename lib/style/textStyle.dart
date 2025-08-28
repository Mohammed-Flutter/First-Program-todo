import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StyleText extends StatelessWidget {
  const StyleText(this.text,{super.key});
final String text;
  @override
  Widget build(BuildContext context) {
    return Text(text,style:GoogleFonts.roboto(textStyle: Theme.of(context).textTheme.bodyMedium));
  }
}

class HeadingText extends StatelessWidget {
  const HeadingText(this.text,{super.key});
final String text;
  @override
  Widget build(BuildContext context) {
    return Text(text,style:GoogleFonts.montserrat(textStyle:Theme.of(context).textTheme.headlineMedium));
  }
}

class TitleText extends StatelessWidget {
  const TitleText(this.text,{super.key});
final String text;
  @override
  Widget build(BuildContext context) {
    return Text(text,style:GoogleFonts.poppins(textStyle: Theme.of(context).textTheme.titleMedium));
  }
}

class labelStyle extends StatelessWidget {
  const labelStyle(this.text,{super.key});
final String text;
  @override
  Widget build(BuildContext context) {
    return Text(text,style:GoogleFonts.lato(textStyle: Theme.of(context).textTheme.labelMedium));
  }
}
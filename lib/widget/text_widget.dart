import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWidget {
  text({data, size, weight, color, align, style}) {
    return Text(
      data,
      style: GoogleFonts.aBeeZee(
        fontSize: size,
        fontWeight: weight,
        color: color,
        fontStyle: style,
      ),
      textAlign: align,
      overflow: TextOverflow.ellipsis,
    );
  }
}

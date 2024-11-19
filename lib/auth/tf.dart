import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";





String? validateEmail(String? value) {
const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
final regex = RegExp(pattern);

return value!.isNotEmpty && !regex.hasMatch(value)
? 'Enter a valid email address'
    : null;
}

Widget authTextField(
    String hintText,
    TextEditingController controller,

    {bool obscureText = false,
    bool validateEmai = false,
      void Function(String)? onChanged,
      TextInputType? keyboardType,
      String? Function(String?)? validator,
      int? maxLines,
      int? minLines,
      Widget? suffix}
    ){
  return
    SizedBox(

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(hintText,
          style: GoogleFonts.montserrat(
            color: Colors.white70,
            fontWeight: FontWeight.w800
          ),),
          SizedBox(height: 5,),
          Form(

              autovalidateMode:validateEmai? AutovalidateMode.always:AutovalidateMode.disabled,
            child: TextFormField  (


              onChanged: onChanged,
              controller: controller,
              validator:(value)=>validateEmail(value),
              obscureText: obscureText,
              keyboardType:keyboardType ,

              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 12
              ),
              // maxLines: maxLines,
              // minLines: minLines,
              decoration:
              InputDecoration(
                  hintText: hintText,
                  hintStyle: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontSize: 12
                  ),
                  filled:true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),


                  suffixIcon: suffix),
            ),
          ),
        ],
      ),
    );
}
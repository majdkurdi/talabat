import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final IconData icon;
  final Function(String?) save;
  final String? Function(String?) validate;
  final TextInputType keyboardType;
  final secureText;
  final String hint;
  MyTextField(this.icon, this.keyboardType, this.hint, this.validate, this.save,
      [this.secureText = false]);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: TextFormField(
        obscureText: secureText,
        keyboardType: keyboardType,
        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20),
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[350]),
          prefixIcon: Icon(icon, color: Theme.of(context).primaryColor),
          fillColor: Theme.of(context).accentColor,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
            borderSide:
                BorderSide(color: Theme.of(context).accentColor, width: 3.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35.0),
            borderSide: BorderSide(
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
        onSaved: save,
        validator: validate,
      ),
    );
  }
}

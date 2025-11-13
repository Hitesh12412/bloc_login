import 'dart:async';

mixin Validators {
  var emailValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (email, sink) {
        if (email.isEmpty){
          return sink.addError("Email is required");
        }
        if (email.length > 35){
          return sink.addError("Email is too long");
        }
        if (email.length < 5){
          return sink.addError("Email is too short");
        }
        if (!email.contains("@")){
          return sink.addError("Invalid email");
        }
        if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").
        hasMatch(email)){
          return sink.addError("Invalid email");
        }
        else {
          return sink.add(email);
        }
        }


  );

  var loginPasswordValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
        if (password.isEmpty){
          return sink.addError("Password is required");
        }
        if (password.length > 35){
          return sink.addError("Password is too long");
        }
        if (password.length < 5){
          return sink.addError("Password is too short");
        }
        else {
          return sink.add(password);
        }
      }


  );

  var nameValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (name, sink) {
        if (name.isEmpty){
          return sink.addError("Name is required");
        }
        if (name.length > 35){
          return sink.addError("Name is too long");
        }
        if (!RegExp(r"^[a-zA-Z ]+$").hasMatch(name)){
          return sink.addError("Invalid name");
        }
        else {
          return sink.add(name);
        }
      }


  );

  var usernameValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (username, sink) {
        if (username.isEmpty){
          return sink.addError("Username is required");
        } 
        else {
          return sink.add(username);
        }
      }


  );

  var phoneValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (phone, sink) {
        if (phone.isEmpty){
          return sink.addError("Phone is required");
        }
        if (phone.length > 10){
          return sink.addError("Invalid Phone");
        }
        if (phone.length < 10){
          return sink.addError("Invalid Phone");
        }
        if (!RegExp(r"^[0-9]+$").
        hasMatch(phone)){
          return sink.addError("Invalid Phone");
        }
        else {
          return sink.add(phone);
        }
      }


  );
  var passwordValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
        if (password.isEmpty){
          return sink.addError("Password is required");
        }
        if (password.length > 35){
          return sink.addError("Password is too long");
        }
        if (password.length < 5){
          return sink.addError("Password is too short");
        }
        else {
          return sink.add(password);
        }
      }


  );


}
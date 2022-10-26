import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeVuModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  bool isHiddenOld = true;
  bool isHiddenNew = true;
  bool isHiddenConfirm = true;

  String oldPassword = '';
  String newPassword = '';
  String confirmPassword = '';
  late BuildContext mContext;

  changePasswordViewModel(context) {
    mContext = context;
  }

  String? oldPasswordValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Required*';
    }
    return null;
  }

  oldPasswordSaved(value) {
    oldPassword = value;
  }

  String? newPasswordValidator(value) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$');
    confirmPassword = value;
    if (value == null || value.isEmpty) {
      return 'Required*';
    } else {
      if (!regex.hasMatch(value)) {
        return '${'at_least_6_characters_long'}'
            '${'at_least_1_uppercase_character'}'
            '${'at_least_1_lowercase_character'}'
            '${'at_least_1_digit'}'
            '${'at_least_1_special_character'}';
      } else {
        return null;
      }
    }
  }

  newPasswordSaved(value) {
    newPassword = value;
  }

  String? confirmPasswordValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Required*';
    }
    if (value != confirmPassword) {
      return 'Password must be same as above';
    }
    return null;
  }

  confirmPasswordSaved(value) {
    confirmPassword = value;
  }

  setInputPassword(String oldPass, String newPass, String confirmPass,
      BuildContext context) {
    oldPassword = oldPass;
    newPassword = newPass;
    confirmPassword = confirmPass;
    if (formKey.currentState == null) {
      return;
    }

    if (!formKey.currentState!.validate()) {
      return;
    }

    if (oldPassword == newPassword) {
    } else {
      setPassword(context);
    }
  }

  togglePasswordVisiblilityOld() {
    isHiddenOld = !isHiddenOld;
  }

  togglePasswordVisiblilityNew() {
    isHiddenNew = !isHiddenNew;
  }

  togglePasswordVisiblilityConfirm() {
    isHiddenConfirm = !isHiddenConfirm;
  }

  setPassword(BuildContext context) async {
    debugPrint(
        '///////////////////////////////setpassword function called////////////////////////////');
    setBusy(true);
    formKey.currentState!.save();
    notifyListeners();
  }
}

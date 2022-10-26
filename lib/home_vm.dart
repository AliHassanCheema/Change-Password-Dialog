import 'package:changepswd_dialog/model.dart';
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
  Passwords? passwords;

  onRefresh() async {
    notifyListeners();
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
        return 'Atleast 1 small,capital,number and \nspecial character should be included*';
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

  setInputPassword(BuildContext context) {
    if (formKey.currentState == null) {
      return;
    }
    if (!formKey.currentState!.validate()) {
      return;
    }
    formKey.currentState!.save();
    passwords = Passwords(oldPassword, newPassword, confirmPassword);
    if (oldPassword == newPassword) {
      return;
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
    setBusy(true);
    // formKey.currentState!.save();

    debugPrint(
        'OldPassword: $oldPassword >>>>> NewPassword: $newPassword >>>>> ConfirmNewPassword: $confirmPassword');
    // Navigator.pop(context);
  }
}

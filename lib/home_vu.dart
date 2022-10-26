import 'package:changepswd_dialog/home_vm.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeScreen extends ViewModelBuilderWidget<HomeVuModel> {
  const HomeScreen({super.key});
  @override
  Widget builder(BuildContext context, HomeVuModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showChangePasswordDialog(context, viewModel);
          },
          child: const Text('Press'),
        ),
      ),
    );
  }

  @override
  HomeVuModel viewModelBuilder(BuildContext context) {
    return HomeVuModel();
  }
}

showChangePasswordDialog(context, HomeVuModel viewModel) {
  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 1.92,
              child: SingleChildScrollView(
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: viewModel.formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(children: [
                      fieldsPassword(viewModel, setState, context),
                      const Divider(
                        color: Colors.grey,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: const StadiumBorder(),
                              side: const BorderSide(
                                  color: Color.fromRGBO(0x38, 0x7b, 0x96, 1.0)),
                            ),
                            onPressed: () {
                              viewModel.setInputPassword(
                                  viewModel.oldPassword.toString(),
                                  viewModel.newPassword.toString(),
                                  viewModel.confirmPassword.toString(),
                                  context);
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text(
                                'CHANGE PASSWORD',
                                style: TextStyle(
                                    color:
                                        Color.fromRGBO(0x38, 0x7b, 0x96, 1.0),
                                    fontSize: 18),
                              ),
                            ),
                          )
                        ],
                      )
                    ]),
                  ),
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

Padding fieldsPassword(
    HomeVuModel viewModel, StateSetter setState, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text(
          'Please Change Password to continue',
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        chiPassField(
          viewModel.isHiddenOld,
          'Enter old password',
          () {
            setState(
              () {
                viewModel.togglePasswordVisiblilityOld();
              },
            );
          },
          viewModel.oldPasswordValidator,
          viewModel.oldPasswordSaved,
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Your new password will be saved as default for all future logins',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        chiPassField(
          viewModel.isHiddenNew,
          'Enter new password',
          () {
            setState(
              () {
                viewModel.togglePasswordVisiblilityNew();
              },
            );
          },
          viewModel.newPasswordValidator,
          viewModel.newPasswordSaved,
        ),
        const SizedBox(
          height: 20,
        ),
        chiPassField(
          viewModel.isHiddenConfirm,
          'Confirm new password',
          () {
            setState(
              () {
                viewModel.togglePasswordVisiblilityConfirm();
              },
            );
          },
          viewModel.confirmPasswordValidator,
          viewModel.confirmPasswordSaved,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    ),
  );
}

Widget chiPassField(bool isHidden, String labelText, void Function()? onPressed,
    String? Function(String?)? validator, void Function(String?)? onSaveFunc) {
  return TextFormField(
      obscureText: isHidden,
      style: const TextStyle(fontWeight: FontWeight.w600),
      decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          labelText: labelText,
          labelStyle: const TextStyle(
              color: Colors.grey, fontSize: 18, fontWeight: FontWeight.normal),
          suffixIcon: IconButton(
              icon: Icon(
                !isHidden ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
                size: 20,
              ),
              onPressed: onPressed)),
      validator: validator,
      onSaved: onSaveFunc);
}

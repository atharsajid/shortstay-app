import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:listar_flutter_pro/blocs/bloc.dart';
import 'package:listar_flutter_pro/utils/utils.dart';
import 'package:listar_flutter_pro/widgets/widget.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() {
    return _SignUpState();
  }
}

class _SignUpState extends State<SignUp> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _textPassController = TextEditingController();
  final _textEmailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _focusFirstName = FocusNode();
  final _focusLastName = FocusNode();
  final _focusPhone = FocusNode();
  final _focusPass = FocusNode();
  final _focusEmail = FocusNode();

  bool _showPassword = false;
  String? _errorFirstName;
  String? _errorLastName;
  String? _errorPass;
  String? _errorEmail;
  String? _errorPhone;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _textPassController.dispose();
    _textEmailController.dispose();
    _phoneNumberController.dispose();
    _focusFirstName.dispose();
    _focusPass.dispose();
    _focusEmail.dispose();
    super.dispose();
  }

  ///On sign up
  void _signUp() async {
    UtilOther.hiddenKeyboard(context);
    setState(() {
      _errorFirstName = UtilValidator.validate(_firstNameController.text);
      _errorLastName = UtilValidator.validate(_firstNameController.text);
      _errorPass = UtilValidator.validate(_textPassController.text);
      _errorEmail = UtilValidator.validate(
        _textEmailController.text,
        type: ValidateType.email,
      );
      _errorPhone = UtilValidator.validate(_phoneNumberController.text,
          type: ValidateType.number);
    });
    if (_errorFirstName == null &&
        _errorLastName == null &&
        _errorPass == null &&
        _errorEmail == null &&
        _errorPhone == null) {
      final result = await AppBloc.userCubit.onRegister(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        password: _textPassController.text,
        email: _textEmailController.text,
        number: _phoneNumberController.text,
      );
      if (result) {
        if (!mounted) return;
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('sign_up'),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  Translate.of(context).translate('First Name'),
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                AppTextInput(
                  hintText: 'Input your first name',
                  errorText: _errorFirstName,
                  controller: _firstNameController,
                  focusNode: _focusFirstName,
                  textInputAction: TextInputAction.next,
                  onChanged: (text) {
                    setState(() {
                      _errorFirstName =
                          UtilValidator.validate(_firstNameController.text);
                    });
                  },
                  onSubmitted: (text) {
                    UtilOther.fieldFocusChange(
                        context, _focusFirstName, _focusLastName);
                  },
                  trailing: GestureDetector(
                    dragStartBehavior: DragStartBehavior.down,
                    onTap: () {
                      _firstNameController.clear();
                    },
                    child: const Icon(Icons.clear),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  Translate.of(context).translate('Last Name'),
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                AppTextInput(
                  hintText: 'Input your last name',
                  errorText: _errorLastName,
                  controller: _lastNameController,
                  focusNode: _focusLastName,
                  textInputAction: TextInputAction.next,
                  onChanged: (text) {
                    setState(() {
                      _errorLastName =
                          UtilValidator.validate(_lastNameController.text);
                    });
                  },
                  onSubmitted: (text) {
                    UtilOther.fieldFocusChange(
                        context, _focusLastName, _focusEmail);
                  },
                  trailing: GestureDetector(
                    dragStartBehavior: DragStartBehavior.down,
                    onTap: () {
                      _lastNameController.clear();
                    },
                    child: const Icon(Icons.clear),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  Translate.of(context).translate('email'),
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                AppTextInput(
                  hintText: Translate.of(context).translate('input_email'),
                  errorText: _errorEmail,
                  focusNode: _focusEmail,
                  trailing: GestureDetector(
                    dragStartBehavior: DragStartBehavior.down,
                    onTap: () {
                      _textEmailController.clear();
                    },
                    child: const Icon(Icons.clear),
                  ),
                  onSubmitted: (text) {
                    UtilOther.fieldFocusChange(
                      context,
                      _focusEmail,
                      _focusPhone,
                    );
                  },
                  onChanged: (text) {
                    setState(() {
                      _errorEmail = UtilValidator.validate(
                        _textEmailController.text,
                        type: ValidateType.email,
                      );
                    });
                  },
                  controller: _textEmailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                Text(
                  Translate.of(context).translate('Phone Number'),
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                AppTextInput(
                  hintText: 'Input your phone number',
                  errorText: _errorPhone,
                  focusNode: _focusPhone,
                  trailing: GestureDetector(
                    dragStartBehavior: DragStartBehavior.down,
                    onTap: () {
                      _phoneNumberController.clear();
                    },
                    child: const Icon(Icons.clear),
                  ),
                  onSubmitted: (text) {
                    UtilOther.fieldFocusChange(
                      context,
                      _focusPhone,
                      _focusPass,
                    );
                  },
                  onChanged: (text) {
                    setState(() {
                      _errorEmail = UtilValidator.validate(
                        _phoneNumberController.text,
                        type: ValidateType.phone,
                      );
                    });
                  },
                  controller: _phoneNumberController,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16),
                Text(
                  Translate.of(context).translate('password'),
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                AppTextInput(
                  hintText: Translate.of(context).translate(
                    'input_your_password',
                  ),
                  errorText: _errorPass,
                  onChanged: (text) {
                    setState(() {
                      _errorPass = UtilValidator.validate(
                        _textPassController.text,
                      );
                    });
                  },
                  onSubmitted: (text) {
                    _signUp();
                  },
                  trailing: GestureDetector(
                    dragStartBehavior: DragStartBehavior.down,
                    onTap: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                    child: Icon(_showPassword
                        ? Icons.visibility
                        : Icons.visibility_off),
                  ),
                  obscureText: !_showPassword,
                  controller: _textPassController,
                  focusNode: _focusPass,
                ),
                const SizedBox(height: 16),
                AppButton(
                  Translate.of(context).translate('sign_up'),
                  mainAxisSize: MainAxisSize.max,
                  onPressed: _signUp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

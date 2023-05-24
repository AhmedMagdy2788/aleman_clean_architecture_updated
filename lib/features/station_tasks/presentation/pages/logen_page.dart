import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  LoginWidgetState createState() => LoginWidgetState();
}

class LoginWidgetState extends State<LoginWidget> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isPasswordVisibile = true;

  bool _isLoginEnabled = false;

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void onChangeTextFormField(String value) {
    setState(() {
      // Check if both username and password are not empty
      _isLoginEnabled = _usernameController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 500,
          height: 350,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    buildTextFormField(
                        lableText: 'Username',
                        icon: const Icon(Icons.person),
                        errorText: 'Please enter your username',
                        obscureText: false,
                        controller: _usernameController,
                        onChange: onChangeTextFormField),
                    buildTextFormField(
                      lableText: 'Password',
                      icon: const Icon(Icons.lock),
                      errorText: 'Please enter your password',
                      obscureText: isPasswordVisibile,
                      controller: _passwordController,
                      onChange: onChangeTextFormField,
                      suffixIconButton: IconButton(
                        onPressed: () {
                          setState(() {
                            isPasswordVisibile = !isPasswordVisibile;
                          });
                        },
                        icon: isPasswordVisibile
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _isLoginEnabled
                          ? () {
                              // Validate and submit the form
                              if (_formKey.currentState!.validate()) {
                                // Do something with the username and password
                                print('Username: ${_usernameController.text}');
                                print('Password: ${_passwordController.text}');
                              }
                            }
                          : null, // Disable the button if username or password is empty
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateColor.resolveWith((states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.blue;
                          }
                          return Colors.grey;
                        }),
                      ),
                      child: const Text(
                          'Login'), // Keep the color as grey if login is disabled
                    ),
                    TextButton(
                      child: const Text('Forgot Password?'),
                      onPressed: () {
                        // Do something when the user taps on the link
                        print('Forgot Password');
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField buildTextFormField(
      {required String lableText,
      required Widget icon,
      required String errorText,
      required TextEditingController controller,
      required Function(String) onChange,
      IconButton? suffixIconButton,
      bool obscureText = false}) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorText;
        }
        return null;
      },
      onChanged: onChange,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: lableText,
        icon: icon,
        // Show an X icon if there is any text, otherwise show nothing
        suffixIcon: controller.text.isNotEmpty
            ? suffixIconButton ??
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    // Clear the text when pressed
                    setState(() {
                      controller.clear();
                    });
                  },
                )
            : null,

        // Set border for enabled state (default)
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 3, color: Colors.blue),
          borderRadius: BorderRadius.circular(15),
        ),
        // Set border for focused state
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 3, color: Colors.green),
          borderRadius: BorderRadius.circular(15),
        ),
        // Set border for error state
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 3, color: Colors.yellow),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}

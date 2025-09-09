import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_coffee_app/bloc/auth_bloc.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AuthScreenState();
  }
}

class _AuthScreenState extends State<AuthScreen> {
  final _form = GlobalKey<FormState>();
  var _enteredEmail = "";
  var _enteredPassword = "";
  var _enteredUsername = "";
  bool _obscurePassword = true;
  bool _isLogin = true;
  var _isAuthenticating = false;

  void _submit() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }

    _form.currentState!.save();

    if (!mounted) return;

    if (_isLogin) {
      // Login - trigger BLoC event
      context.read<AuthBloc>().add(
        LoginRequested(email: _enteredEmail, password: _enteredPassword),
      );
    } else {
      // Signup - trigger BLoC event
      context.read<AuthBloc>().add(
        SignupRequested(
          email: _enteredEmail,
          password: _enteredPassword,
          username: _enteredUsername,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          setState(() {
            _isAuthenticating = true;
          });
        } else if (state is AuthSuccess) {
          if (!mounted) return;

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              backgroundColor: Theme.of(context).colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              behavior: SnackBarBehavior.floating,
            ),
          );

          if (state.isLogin) {
            // Navigate to home after successful login
            if (mounted) {
              setState(() {
                _isAuthenticating = false;
              });
              _form.currentState?.reset();
              context.go('/home');
            }
          } else {
            // Switch to login mode after successful signup
            setState(() {
              _isLogin = true;
              _enteredEmail = "";
              _enteredPassword = "";
              _enteredUsername = "";
              _isAuthenticating = false;
            });
            _form.currentState?.reset();
          }
        } else if (state is AuthFailure) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Theme.of(context).colorScheme.error,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              behavior: SnackBarBehavior.floating,
            ),
          );
          setState(() {
            _isAuthenticating = false;
          });
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Scaffold(
            body: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          top: 60,
                          bottom: 8,
                          left: 20,
                          right: 20,
                        ),
                        width: 150,
                      ),
                      SizedBox(
                        height: 240,
                        child: Lottie.asset(
                          'lib/assets/images/Coffee love.json',
                          fit: BoxFit.contain,
                        ),
                      ),
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Form(
                            key: _form,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (!_isLogin)
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Text(
                                          "Username",
                                          style: TextStyle(
                                            color:
                                                Theme.of(
                                                  context,
                                                ).colorScheme.primary,
                                          ),
                                        ),
                                      ),
                                    if (!_isLogin)
                                      TextFormField(
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              32,
                                            ),
                                            borderSide: BorderSide(
                                              color:
                                                  Theme.of(
                                                    context,
                                                  ).colorScheme.primary,
                                            ),
                                          ),
                                          hintText: "Username",
                                        ),
                                        keyboardType: TextInputType.name,
                                        autocorrect: false,
                                        textCapitalization:
                                            TextCapitalization.none,
                                        textInputAction: TextInputAction.next,
                                        validator: (value) {
                                          if (value == null ||
                                              value.trim().isEmpty ||
                                              value.trim().length < 2) {
                                            return "Please enter a valid username";
                                          }
                                          return null;
                                        },
                                        onSaved: (newValue) {
                                          _enteredUsername = newValue!;
                                        },
                                      ),
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Text(
                                        "Email Address",
                                        style: TextStyle(
                                          color:
                                              Theme.of(
                                                context,
                                              ).colorScheme.primary,
                                        ),
                                      ),
                                    ),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            32,
                                          ),
                                          borderSide: BorderSide(
                                            color:
                                                Theme.of(
                                                  context,
                                                ).colorScheme.primary,
                                          ),
                                        ),
                                        hintText: "Email Address",
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                      autocorrect: false,
                                      enableSuggestions: true,
                                      textCapitalization:
                                          TextCapitalization.none,
                                      textInputAction: TextInputAction.next,
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty ||
                                            !value.contains("@") ||
                                            !value.contains(".")) {
                                          return "Please enter a valid email address";
                                        }
                                        return null;
                                      },
                                      onSaved:
                                          (newValue) =>
                                              _enteredEmail = newValue!,
                                    ),
                                  ],
                                ),
                                // const SizedBox(height: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Text(
                                        "Password",
                                        style: TextStyle(
                                          color:
                                              Theme.of(
                                                context,
                                              ).colorScheme.primary,
                                        ),
                                      ),
                                    ),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            32,
                                          ),
                                          borderSide: BorderSide(
                                            color:
                                                Theme.of(
                                                  context,
                                                ).colorScheme.primary,
                                          ),
                                        ),
                                        hintText: "Password",
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _obscurePassword =
                                                  !_obscurePassword;
                                            });
                                          },
                                          icon: Icon(
                                            !_obscurePassword
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                          ),
                                        ),
                                      ),
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      obscureText: _obscurePassword,
                                      autocorrect: false,
                                      validator:
                                          (value) =>
                                              value!.isEmpty ||
                                                      value.trim().length < 6
                                                  ? "Password must be at least 6 characters"
                                                  : null,
                                      onSaved:
                                          (newValue) =>
                                              _enteredPassword = newValue!,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 32),
                                if (!_isAuthenticating)
                                  ElevatedButton(
                                    onPressed: _submit,
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(32),
                                      ),
                                      minimumSize: const Size(
                                        double.infinity,
                                        50,
                                      ),
                                      backgroundColor:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                    child: Text(
                                      _isLogin ? "Login" : "Signup",
                                      style: TextStyle(
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.onPrimary,
                                      ),
                                    ),
                                  ),
                                const SizedBox(height: 8),
                                if (_isAuthenticating)
                                  const CircularProgressIndicator(),
                                if (!_isAuthenticating)
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        _isLogin = !_isLogin;
                                      });
                                      _enteredEmail = "";
                                      _enteredPassword = "";
                                      _enteredUsername = "";
                                      _form.currentState?.reset();
                                    },
                                    child: Text(
                                      _isLogin
                                          ? "Create an account"
                                          : "Already have an account, login instead",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Events
abstract class AuthEvent {}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  LoginRequested({required this.email, required this.password});
}

class SignupRequested extends AuthEvent {
  final String email;
  final String password;
  final String username;

  SignupRequested({
    required this.email,
    required this.password,
    required this.username,
  });
}

// States
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String message;
  final bool isLogin;

  AuthSuccess({required this.message, required this.isLogin});
}

class AuthFailure extends AuthState {
  final String errorMessage;

  AuthFailure({required this.errorMessage});
}

// BLoC
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _firebase = FirebaseAuth.instance;

  AuthBloc() : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<SignupRequested>(_onSignupRequested);
  }

  String getFriendlyFirebaseError(String code) {
    switch (code) {
      case 'user-not-found':
        return 'No account found for this email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'email-already-in-use':
        return 'This email is already registered. Try logging in.';
      case 'weak-password':
        return 'Password is too weak. Try a stronger one.';
      case 'invalid-email':
        return 'This email format looks off.';
      case 'network-request-failed':
        return 'Network issue. Please check your internet.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'too-many-requests':
        return 'Too many failed attempts. Please try again later.';
      case 'operation-not-allowed':
        return 'This operation is not allowed.';
      case 'invalid-credential':
        return 'Invalid email or password.';
      case 'account-exists-with-different-credential':
        return 'An account already exists with the same email but different sign-in credentials.';
      case 'requires-recent-login':
        return 'This operation requires recent authentication. Please log in again.';
      case 'credential-already-in-use':
        return 'This credential is already associated with a different user account.';
      case 'invalid-verification-code':
        return 'Invalid verification code.';
      case 'invalid-verification-id':
        return 'Invalid verification ID.';
      case 'session-expired':
        return 'Your session has expired. Please log in again.';
      default:
        return 'Something went wrong. Please try again. (Error: $code)';
    }
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      await _firebase.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      emit(AuthSuccess(message: "Logged in successfully!", isLogin: true));
    } on FirebaseAuthException catch (error) {
      final errorMessage = getFriendlyFirebaseError(error.code);
      emit(AuthFailure(errorMessage: errorMessage));
    } catch (error) {
      emit(AuthFailure(errorMessage: 'An unexpected error occurred: $error'));
    }
  }

  Future<void> _onSignupRequested(
    SignupRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final userCredentials = await _firebase.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      // Store user data in Firestore
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userCredentials.user!.uid)
          .set({
            'username': event.username,
            'email': event.email,
            'createdAt': DateTime.now(),
            'updatedAt': DateTime.now(),
          });

      emit(
        AuthSuccess(
          message: "Account created successfully! Please log in.",
          isLogin: false,
        ),
      );
    } on FirebaseAuthException catch (error) {
      final errorMessage = getFriendlyFirebaseError(error.code);
      emit(AuthFailure(errorMessage: errorMessage));
    } catch (error) {
      emit(AuthFailure(errorMessage: 'An unexpected error occurred: $error'));
    }
  }
}

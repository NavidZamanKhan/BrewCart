import 'package:go_router/go_router.dart';
import 'package:my_coffee_app/screens/splash_screen.dart';
import 'package:my_coffee_app/screens/auth.dart';

// TODO: Import these screens when they're created
// import 'package:my_coffee_app/screens/login_screen.dart';
// import 'package:my_coffee_app/screens/signup_screen.dart';
// import 'package:my_coffee_app/screens/home_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/auth',
      name: 'auth',
      builder: (context, state) => const AuthScreen(),
    ),

    // GoRoute(
    //   path: '/signup',
    //   name: 'signup',
    //   builder: (context, state) => const SignupScreen(),
    // ),
    // GoRoute(
    //   path: '/home',
    //   name: 'home',
    //   builder: (context, state) => const HomeScreen(),
    // ),
  ],
  // TODO: Add error handling
  // errorBuilder: (context, state) => const ErrorScreen(),
);

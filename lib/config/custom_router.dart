import 'package:flutter/material.dart';
import 'package:flutter_instagram/screens/screens.dart';
import 'package:flutter_instagram/screens/signup/signup_screen.dart';

class CustomRouter {
  static getRoutes() {
    return {
      "/": (ctx) => SplashScreen(),
      SplashScreen.routeName: (ctx) => SplashScreen(),
      LoginScreen.routeName: (ctx) => LoginScreen(),
      NavScreen.routeName: (ctx) => NavScreen(),
      SignupScreen.routeName: (ctx) => SignupScreen(),
    };
  }

// }
//
//
// static Route onGenerateRoute(RouteSettings settings) {
//   print('Route: ${settings.name}');
//   switch (settings.name) {
//     case '/':
//       return MaterialPageRoute(
//         settings: const RouteSettings(name: '/'),
//         builder: (_) => Scaffold(
//             appBar: AppBar(
//               title: const Text('Flutter Instagram'),
//             ),
//             body: Container()),
//       );
//     default:
//       return _errorRoute();
//   }
// }
//
// static Route _errorRoute() {
//   return MaterialPageRoute(
//       settings: const RouteSettings(name: '/error'),
//       builder: (_) => Scaffold(
//           appBar: AppBar(
//             title: Text('Error'),
//           ),
//           body: const Center(
//             child: Text('Something went wrong'),
//           )));
// }
}

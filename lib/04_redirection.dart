import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

enum AuthState { unAuthenticated, authenticated }

class AuthNotifier extends ChangeNotifier {
  AuthState _authState = .unAuthenticated;

  AuthState get auth => _authState;

  void login() {
    _authState = .authenticated;
    notifyListeners();
  }

  void logOut() {
    _authState = .unAuthenticated;
    notifyListeners();
  }

  Future<bool> isSignedIn() async {
    await Future.delayed(Duration(seconds: 2));
    return _authState == .authenticated;
  }
}

class RedirectionApp extends StatefulWidget {
  const RedirectionApp({super.key});

  @override
  State<RedirectionApp> createState() => _RedirectionAppState();
}

class _RedirectionAppState extends State<RedirectionApp> {
  final authProvider = AuthNotifier();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router(authProvider),
      debugShowCheckedModeBanner: false,
    );
  }
}

/// The route configuration.
GoRouter _router(AuthNotifier notifier) => GoRouter(
  errorBuilder: (_, state) =>
      Material(child: Center(child: Text(state.error.toString()))),
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return HomeScreen(notifier: notifier);
      },
    ),
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) {
        return LoginScreen(notifier: notifier);
      },
    ),
  ],

  refreshListenable: notifier,
  redirectLimit: 4,
  redirect: (context, state) async {
    final isLoginRoute = state.matchedLocation == "/login";

    final isAuthencated = await notifier.isSignedIn();

    if (!isAuthencated) return isLoginRoute ? null : "/login";
    if (isAuthencated && isLoginRoute) return "/";

    return null;
  },
);

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.notifier});
  final AuthNotifier notifier;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            debugPrint("==Logout");
            widget.notifier.logOut();
            isLoading = true;
            setState(() {});
          },
          child: isLoading ? CircularProgressIndicator() : Text("logout"),
        ),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.notifier});

  final AuthNotifier notifier;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LoginScreen ')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            debugPrint("==Login");
            widget.notifier.login();
            isLoading = true;
            setState(() {});
          },
          child: isLoading ? CircularProgressIndicator() : Text("login"),
        ),
      ),
    );
  }
}

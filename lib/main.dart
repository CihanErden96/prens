import 'package:flutter/material.dart';
import 'package:prens/pages/main_screen.dart';
import 'package:prens/pages/login_screen.dart';
import 'package:prens/services/msal_auth_service.dart';
import 'package:prens/core/app_theme.dart';
import 'constants/global_variables.dart';
import 'config/app_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.initialize(AppEnvironment.development);
  authService = MsalAuthService(AppConfig.instance);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? clientID;
  String? webURL;

  @override
  void initState() {
    super.initState();
    _loadConfig();
  }

  Future<void> _loadConfig() async {
    clientID = await secureStorage.read(key: 'clientID');
    webURL = await secureStorage.read(key: 'webURL');
    setState(() {}); // Rebuild the widget after loading the config
  }

  Future<bool> _checkLoginStatus() async {
    return (await authService!.hasValidAccount());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Named Routes Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const MainScreen(),
      },
      home: FutureBuilder<bool>(
        future: _checkLoginStatus(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          final isLoggedIn =
              snapshot.data! && clientID != null && webURL != null;
          return isLoggedIn ? MainScreen() : LoginScreen();
        },
      ),
    );
  }
}

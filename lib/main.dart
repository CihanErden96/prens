import 'package:flutter/material.dart';
import 'package:prens/pages/main_screen.dart';
import 'package:prens/pages/login_screen.dart';
import 'package:prens/services/msal_auth_service.dart';
import 'package:prens/core/app_theme.dart';
import 'constants/global_variables.dart';
import 'config/app_config.dart';
import 'package:isar/isar.dart';
import 'package:prens/models/question.dart'; // Import your generated file
import 'package:path_provider/path_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import Riverpod

late Isar isar;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationSupportDirectory();
  isar = await Isar.open(
    [QuestionSchema], // Add your generated schema here
    directory: dir.path,
    inspector: true,
  );

  await AppConfig.initialize(AppEnvironment.development);
  authService = MsalAuthService(AppConfig.instance);
  runApp(const ProviderScope(child: MyApp())); // Wrap MyApp with ProviderScope
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

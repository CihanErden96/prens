
import 'package:flutter_dotenv/flutter_dotenv.dart';

enum AppEnvironment {
  development,
  staging,
  production,
}

class AppConfig {
  final String authAndroidConfigPath;
  final String authAndroidRedirectUri;
  final String authAppleAuthority;
  final AppEnvironment environment;

  static late AppConfig instance;

  AppConfig({
    required this.authAndroidConfigPath,
    required this.authAndroidRedirectUri,
    required this.authAppleAuthority,
    required this.environment,
  });

  static Future<void> initialize(AppEnvironment env) async {
    final fileName = switch (env) {
      AppEnvironment.development => '.env.development',
      AppEnvironment.staging => '.env.staging',
      AppEnvironment.production => '.env.production',
    };
    await dotenv.load(fileName: fileName);

    instance = AppConfig(
      authAndroidConfigPath: dotenv.env['ANDROID_CONFIG_PATH']!,
      authAndroidRedirectUri: dotenv.env['REDIRECT_URI']!,
      authAppleAuthority: dotenv.env['AUTHORITY']!,
      environment: env,
    );
  }
}


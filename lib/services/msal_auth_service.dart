import 'dart:developer';
import '../config/app_config.dart';
import 'package:msal_auth/msal_auth.dart';
import '../constants/global_variables.dart';


abstract class IAuthService {
  Future<String?> getToken();
  Future<void> signOut();
}

final class MsalAuthService implements IAuthService {
  String? _clientId;
  List<String> _scopes = [];
  final String _androidConfigPath;
  final String _androidRedirectUri;
  final String _appleAuthority;

  PublicClientApplication? _app;

  MsalAuthService(AppConfig config)
      : _androidConfigPath = config.authAndroidConfigPath,
        _androidRedirectUri = config.authAndroidRedirectUri,
        _appleAuthority = config.authAppleAuthority;

  Future<void> _initialize() async {
    if (_app != null) return;

    _clientId = await secureStorage.read(key: 'clientID');
    if (_clientId == null || _clientId!.isEmpty) {
      log('Client ID is missing.');
      return;
    }

    _scopes = ["api://$_clientId/.default"];

    try {
      _app = await SingleAccountPca.create(
        clientId: _clientId!,
        androidConfig: AndroidConfig(
          configFilePath: _androidConfigPath,
          redirectUri: _androidRedirectUri,
        ),
        appleConfig: AppleConfig(
          authority: _appleAuthority,
          authorityType: AuthorityType.aad,
          broker: Broker.msAuthenticator,
        ),
      );
    } on MsalException catch (e) {
      _handleMsalException('MSAL init failed', e);
    }
  }

  Future<String> signIn() async {
    _scopes = ["api://$_clientId/.default"];
    _app = null; // Force re-initialization

    final token = await getToken();
    if (token == null) {
      throw Exception('Failed to acquire token');
    }
    return token;
  }

  @override
  Future<String?> getToken() async {
    await _initialize();
    if (_app == null) return null;

    try {
      final result = await _app!.acquireToken(
        scopes: _scopes,
        prompt: Prompt.whenRequired,
      );
      log('Token acquired => ${result.accessToken}');
      return result.accessToken;
    } on MsalException catch (e) {
      _handleMsalException('Token acquisition failed', e);
      _app = null;
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    if (_app is! SingleAccountPca) {
      log('Sign out skipped: _app is not initialized or not SingleAccountPca');
      return;
    }

    try {
      await (_app as SingleAccountPca).signOut();
      log('Sign out successful');
    } on MsalException catch (e) {
      _handleMsalException('Sign out failed', e);
    }
  }

  Future<bool> hasValidAccount() async {
    await _initialize();
    if (_app == null) return false;

    try {
      final result = await _app!.acquireTokenSilent(scopes: _scopes);
      log('Silent token acquired: ${result.accessToken}');
      return result.accessToken != null;
    } on MsalException catch (e) {
      _handleMsalException('Silent token acquisition failed', e);
      return false;
    }
  }

  void _handleMsalException(String context, MsalException e) {
    log('$context => ${e.runtimeType} { message: ${e.message} }');
  }
}

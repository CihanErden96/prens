import 'package:flutter/material.dart';
import 'package:prens/main.dart'; // main.dart dosyasını import et
import 'package:prens/pages/main_screen.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _clientIdController = TextEditingController();
  final secureStorage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _clientIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/login.png',
                  width: 250,
                  height: 250,
                ),
                const SizedBox(height: 64),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Container(
          color: Theme.of(context).colorScheme.surface,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1), // Temadan alınan renk ile güncellendi
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: _focusNode.hasFocus ? 450.0 : 110.0,
                  child: TextField(
                    controller: _clientIdController,
                    focusNode: _focusNode,
                    style: TextStyle(
                      fontSize: _focusNode.hasFocus ? 16 : 4,
                      color: Theme.of(context).inputDecorationTheme.labelStyle?.color,
                    ),
                    decoration: InputDecoration(
                      hintText: '00000000-0000-0000-000000000000',
                      labelText: 'Client ID',
                      labelStyle: TextStyle(
                        fontSize: Theme.of(context).inputDecorationTheme.labelStyle!.fontSize! * 1.3,
                        color: Theme.of(context).inputDecorationTheme.labelStyle?.color,
                      ),
                      hintStyle: Theme.of(context).inputDecorationTheme.hintStyle?.copyWith(fontSize: 16),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3), // Temadan alınan renk ile güncellendi
                              blurRadius: 20.0,
                              spreadRadius: 1.0,
                              offset: const Offset(5.0, 5.0),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: Theme.of(context).elevatedButtonTheme.style,
                          onPressed: () async {
                            await secureStorage.write(key: 'clientID', value: _clientIdController.text.trim());
                            if (authService != null) {
                              final token = await authService!.signIn();
                              if (token != null) {
                                Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
                                await secureStorage.write(key: 'webURL', value: decodedToken['scp']);
                                // ignore: use_build_context_synchronously
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => const MainScreen()),
                                );
                              } else {
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Authentication failed. Please try again.')),
                                );
                              }
                            } else {
                              // authService is null
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('AuthService is not initialized.')),
                              );
                            }
                          },
                          child: const Text('Continue with Microsoft'),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
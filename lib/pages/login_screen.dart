import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FocusNode _focusNode = FocusNode();

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
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
          color: Theme.of(context).bottomSheetTheme.backgroundColor,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).bottomSheetTheme.backgroundColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
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
                    focusNode: _focusNode,
                    style: TextStyle(
                      fontSize: _focusNode.hasFocus ? 16 : 4,
                      color: Theme.of(context).inputDecorationTheme.labelStyle?.color,
                    ),
                    decoration: InputDecoration(
                      hintText: '00000000-0000-0000-000000000000',
                      labelText: 'Client ID',
                      labelStyle: TextStyle(
                        fontSize: (Theme.of(context).inputDecorationTheme.labelStyle?.fontSize ?? 14) * 1.3,
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
                              color: Colors.grey.shade500,
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
                          onPressed: () {},
                          child: const Text('Continue with Microsoft'),
                        ),
                      ),
                    ],
                  ),
                )
            )
            ],
          ),
        ),
      ),
    );
  }
}
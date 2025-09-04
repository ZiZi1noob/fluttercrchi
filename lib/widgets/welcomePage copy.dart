import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'dart:ui';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final screenWidth = media.size.width;
    final screenHeight = media.size.height;
    final isDesktop = screenWidth > 600;

    return Scaffold(
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),

        child: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isDesktop ? screenWidth * 0.5 : screenWidth * 0.9,
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Animated Title
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [_Title(), _CatLottie()],
                    ),

                    _Username(),
                    SizedBox(height: screenHeight * 0.03),

                    // Submit Button with Loading State
                    // Selector<UserProvider, bool>(
                    //       selector: (_, provider) => provider.isLoading,

                    //       builder: (context, isLoading, child) {
                    //         return FilledButton.tonal(
                    //           onPressed: isLoading
                    //               ? null
                    //               : () async {
                    //                   if (_formKey.currentState!.validate()) {
                    //                     final isSucc = await context
                    //                         .read<UserProvider>()
                    //                         .getUserInfo(
                    //                           _nameController.text,
                    //                           context,
                    //                         );
                    //                     if (isSucc) {
                    //                       Navigator.push(
                    //                         context,
                    //                         MaterialPageRoute(
                    //                           builder: (context) =>
                    //                               const MenuPage(),
                    //                         ),
                    //                       );
                    //                     }
                    //                   }
                    //                 },

                    //           style: FilledButton.styleFrom(
                    //             minimumSize: const Size(double.infinity, 50),
                    //             shape: RoundedRectangleBorder(
                    //               borderRadius: BorderRadius.circular(12),
                    //             ),
                    //           ),
                    //           child: isLoading
                    //               ? const CircularProgressIndicator(
                    //                   color: Colors.white,
                    //                 )
                    //               : const Text('Continue'),
                    //         );
                    //       },
                    // )
                    // .animate()
                    // .fadeIn(delay: 400.ms)
                    // .slideY(begin: 0.1, curve: Curves.easeOut),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatefulWidget {
  const _Title();

  @override
  State<_Title> createState() => __TitleState();
}

class __TitleState extends State<_Title> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child:
          Text(
                'WELCOME',
                style: TextStyle(
                  fontFamily: 'Bitcount Grid Double',
                  fontSize: 68,
                  color: _isHovering
                      ? Colors.blue
                      : Colors.black, // Color change
                  shadows: _isHovering
                      ? [
                          Shadow(
                            blurRadius: 10,
                            color: Colors.blue.withAlpha(128),
                            offset: const Offset(0, 0),
                          ),
                        ]
                      : null,
                ),
              )
              .animate(
                target: _isHovering ? 1 : 0.7,
              ) // Animate based on hover state
              .fadeIn(duration: 500.ms)
              .then(delay: 200.ms)
              .slideY(begin: -0.1, curve: Curves.easeOut),
    );
  }
}

class _CatLottie extends StatefulWidget {
  const _CatLottie();

  @override
  State<_CatLottie> createState() => __CatLottieState();
}

class __CatLottieState extends State<_CatLottie> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child:
          SizedBox(
                width: 68,
                height: 68,
                child: Lottie.asset(
                  'assets/lotties/CatMovement.json',
                  alignment: Alignment.topCenter,
                  repeat: true,
                  frameRate: FrameRate(30),
                  backgroundLoading: true,
                ),
              )
              .animate(target: _isHovering ? 1 : 0)
              .scaleXY(
                begin: 1,
                end: _isHovering ? 1.2 : 1,
                duration: 300.ms,
                curve: Curves.easeOut,
              ),
    );
  }
}

class _Username extends StatefulWidget {
  const _Username();

  @override
  State<_Username> createState() => _UsernameState();
}

class _UsernameState extends State<_Username> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child:
          TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Enter your name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.person),
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              )
              .animate()
              .fadeIn(delay: 300.ms)
              .slideX(begin: -0.5, curve: Curves.easeOut),
    );
  }
}

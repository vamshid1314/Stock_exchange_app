import 'package:flutter/material.dart';
import 'package:stock_exchange_app/home/views/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  bool _isImageLoaded = false;
  bool _isPrecached = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    
    _controller.addStatusListener((status){
      if(status == AnimationStatus.completed){
        Future.delayed(const Duration(milliseconds: 1000),(){
          Navigator.of(context).pushReplacement(HomeScreen.route());
        });
      }
    });

    Future.delayed(const Duration(seconds: 3), (){
      Navigator.of(context).push(HomeScreen.route());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isPrecached) {
      _isPrecached = true;
      precacheImage(const AssetImage('assets/images/splash_image.avif'), context).then((_) {
        setState(() {
          _isImageLoaded = true;
          _controller.forward();
        });
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isImageLoaded) {
      // Show blank or loader while image is not loaded
      return const Scaffold(
        body: SizedBox.expand(child: SizedBox.shrink()),
      );
    }

    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: [
            Positioned.fill(
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5),
                    BlendMode.darken
                ),
                child: Image.asset(
                  'assets/images/splash_image.avif',
                  fit: BoxFit.cover,
                  opacity: const AlwaysStoppedAnimation(0.35),
                ),
              ),
            ),
            Center(
              child: SlideTransition(
                position: _slideAnimation,
                child: Row(
                  children: [
                    const Spacer(),
                    const Text(
                      'True Broker',
                      style: TextStyle(
                        fontFamily: 'MW',
                        color: Colors.amberAccent,
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            blurRadius: 4,
                            color: Colors.white70,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 15),
                    Image.asset(
                      'assets/images/symbol1.png',
                      width: 60,
                      height: 60,
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

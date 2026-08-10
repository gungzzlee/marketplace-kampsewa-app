import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_camp_sewa/layouts/layout_onboarding.dart';
import 'package:project_camp_sewa/screens/screen_dashboard.dart';
import 'package:project_camp_sewa/theme_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen>
    with TickerProviderStateMixin {
  String? token;

  // Animation controllers
  late AnimationController _bgController;
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _taglineController;
  late AnimationController _loadingController;
  late AnimationController _particleController;
  late AnimationController _shimmerController;

  // Animations
  late Animation<double> _bgScale;
  late Animation<double> _bgOpacity;
  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<Offset> _logoSlide;
  late Animation<double> _textOpacity;
  late Animation<Offset> _textSlide;
  late Animation<double> _taglineOpacity;
  late Animation<Offset> _taglineSlide;
  late Animation<double> _shimmerPos;
  late Animation<double> _loadingProgress;

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String? ambilToken = prefs.getString('token');
    if (ambilToken != null) {
      token = ambilToken;
    }
  }

  @override
  void initState() {
    super.initState();

    // Hide system UI for full immersive experience
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );

    _initAnimations();
    _startAnimations();

    loadUserData().then((_) {
      Future.delayed(const Duration(milliseconds: 3200), () {
        if (mounted) {
          Get.off(
            () => token != null
                ? const ScreenDashboard()
                : const OnboardLayout(),
            transition: Transition.fadeIn,
            duration: const Duration(milliseconds: 800),
          );
        }
      });
    });
  }

  void _initAnimations() {
    // Background slow zoom-in
    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    );
    _bgScale = Tween<double>(begin: 1.0, end: 1.12).animate(
      CurvedAnimation(parent: _bgController, curve: Curves.easeInOut),
    );
    _bgOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _bgController,
        curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
      ),
    );

    // Logo bounce-in
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _logoScale = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );
    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );
    _logoSlide = Tween<Offset>(
      begin: const Offset(0, -0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutCubic),
    );

    // App name text slide-up
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOut),
    );
    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOutCubic),
    );

    // Tagline fade-in
    _taglineController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _taglineOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _taglineController, curve: Curves.easeOut),
    );
    _taglineSlide = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _taglineController, curve: Curves.easeOutCubic),
    );

    // Shimmer effect
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    _shimmerPos = Tween<double>(begin: -1.5, end: 2.5).animate(
      CurvedAnimation(parent: _shimmerController, curve: Curves.easeInOut),
    );

    // Loading bar
    _loadingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    );
    _loadingProgress = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _loadingController, curve: Curves.easeInOut),
    );

    // Particle float
    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
  }

  void _startAnimations() async {
    // Start background immediately
    _bgController.forward();

    // Logo enters after 300ms
    await Future.delayed(const Duration(milliseconds: 300));
    if (mounted) _logoController.forward();

    // Text after logo
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) _textController.forward();

    // Tagline after text
    await Future.delayed(const Duration(milliseconds: 350));
    if (mounted) _taglineController.forward();

    // Shimmer after tagline
    await Future.delayed(const Duration(milliseconds: 200));
    if (mounted) {
      _shimmerController.forward();
      _loadingController.forward();
    }
  }

  @override
  void dispose() {
    _bgController.dispose();
    _logoController.dispose();
    _textController.dispose();
    _taglineController.dispose();
    _loadingController.dispose();
    _particleController.dispose();
    _shimmerController.dispose();

    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF0D1F17),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ── Background image with parallax zoom ──
          AnimatedBuilder(
            animation: _bgController,
            builder: (_, __) => Opacity(
              opacity: _bgOpacity.value,
              child: Transform.scale(
                scale: _bgScale.value,
                child: Image.asset(
                  'assets/images/background-splash-screen.png',
                  fit: BoxFit.cover,
                  width: size.width,
                  height: size.height,
                ),
              ),
            ),
          ),

          // ── Multi-layer gradient overlay ──
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x55000000),
                  Color(0x22000000),
                  Color(0x44000000),
                  Color(0xBB0D1F17),
                  Color(0xEE0A1910),
                ],
                stops: [0.0, 0.2, 0.5, 0.75, 1.0],
              ),
            ),
          ),

          // ── Floating particles ──
          AnimatedBuilder(
            animation: _particleController,
            builder: (_, __) => CustomPaint(
              painter: _ParticlePainter(_particleController.value),
              size: Size(size.width, size.height),
            ),
          ),

          // ── Main content ──
          SafeArea(
            child: Column(
              children: [
                const Spacer(flex: 3),

                // ── Logo section ──
                AnimatedBuilder(
                  animation: _logoController,
                  builder: (_, __) => SlideTransition(
                    position: _logoSlide,
                    child: FadeTransition(
                      opacity: _logoOpacity,
                      child: ScaleTransition(
                        scale: _logoScale,
                        child: _buildLogoSection(),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                // ── App name ──
                AnimatedBuilder(
                  animation: _textController,
                  builder: (_, __) => SlideTransition(
                    position: _textSlide,
                    child: FadeTransition(
                      opacity: _textOpacity,
                      child: _buildAppName(),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // ── Tagline ──
                AnimatedBuilder(
                  animation: _taglineController,
                  builder: (_, __) => SlideTransition(
                    position: _taglineSlide,
                    child: FadeTransition(
                      opacity: _taglineOpacity,
                      child: _buildTagline(),
                    ),
                  ),
                ),

                const Spacer(flex: 4),

                // ── Loading bar ──
                AnimatedBuilder(
                  animation: _loadingController,
                  builder: (_, __) => FadeTransition(
                    opacity: _taglineOpacity,
                    child: _buildLoadingBar(size),
                  ),
                ),

                const SizedBox(height: 16),

                // ── Developer credit ──
                AnimatedBuilder(
                  animation: _taglineController,
                  builder: (_, __) => FadeTransition(
                    opacity: _taglineOpacity,
                    child: _buildDeveloperCredit(),
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoSection() {
    return AnimatedBuilder(
      animation: _shimmerController,
      builder: (_, __) {
        return Stack(
          alignment: Alignment.center,
          children: [
            // Outer glow ring (animated pulse)
            AnimatedBuilder(
              animation: _particleController,
              builder: (_, __) {
                final pulse =
                    (math.sin(_particleController.value * 2 * math.pi) + 1) /
                        2;
                return Container(
                  width: 140 + pulse * 12,
                  height: 140 + pulse * 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.mainColor.withValues(alpha: 0.25 + pulse * 0.1),
                        AppColors.mainColor.withValues(alpha: 0.05),
                        Colors.transparent,
                      ],
                    ),
                  ),
                );
              },
            ),

            // Glass container for logo
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withValues(alpha: 0.22),
                    Colors.white.withValues(alpha: 0.08),
                  ],
                ),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.35),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.mainColor.withValues(alpha: 0.5),
                    blurRadius: 30,
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 20,
                    spreadRadius: -5,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipOval(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Image.asset(
                        'assets/favicons/android-chrome-512x512.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    // Shimmer sweep
                    if (_shimmerPos.value > -1.5 &&
                        _shimmerPos.value < 2.5)
                      Positioned.fill(
                        child: ShaderMask(
                          shaderCallback: (bounds) {
                            return LinearGradient(
                              begin: Alignment(
                                  _shimmerPos.value - 0.5, -0.5),
                              end: Alignment(
                                  _shimmerPos.value + 0.5, 0.5),
                              colors: [
                                Colors.white.withValues(alpha: 0.0),
                                Colors.white.withValues(alpha: 0.4),
                                Colors.white.withValues(alpha: 0.0),
                              ],
                            ).createShader(bounds);
                          },
                          child: Container(color: Colors.white),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAppName() {
    return Column(
      children: [
        // "Marketplace" label badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.mainColor.withValues(alpha: 0.35),
            border: Border.all(
              color: AppColors.mainColor.withValues(alpha: 0.6),
              width: 1,
            ),
          ),
          child: Text(
            'M A R K E T P L A C E',
            style: GoogleFonts.geist(
              color: const Color(0xFFA8D5B5),
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 3.0,
            ),
          ),
        ),
        const SizedBox(height: 10),

        // "KampSewa" main title with gradient
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFFFFF),
              Color(0xFFD4EDD8),
              Color(0xFFA8D5B5),
            ],
          ).createShader(bounds),
          child: Text(
            'KampSewa',
            style: GoogleFonts.geist(
              color: Colors.white,
              fontSize: 46,
              fontWeight: FontWeight.w900,
              letterSpacing: -1.0,
              height: 1.0,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTagline() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48.0),
      child: Column(
        children: [
          // Divider line
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 1,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.white.withValues(alpha: 0.3),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 1,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withValues(alpha: 0.3),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            'Tempat Menyewakan & Sewa\nAlat Kamping Terpercaya',
            textAlign: TextAlign.center,
            style: GoogleFonts.geist(
              color: Colors.white.withValues(alpha: 0.75),
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 1.6,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingBar(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 56.0),
      child: Column(
        children: [
          // Progress bar
          Container(
            height: 3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white.withValues(alpha: 0.1),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: _loadingProgress.value,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF4CAF7D),
                        Color(0xFF2C4E40),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF4CAF7D).withValues(alpha: 0.6),
                        blurRadius: 8,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeveloperCredit() {
    return Column(
      children: [
        Text(
          'Developed by',
          style: GoogleFonts.geist(
            color: Colors.white.withValues(alpha: 0.35),
            fontSize: 11,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          '@ABBMA TEAM',
          style: GoogleFonts.geist(
            color: Colors.white.withValues(alpha: 0.65),
            fontSize: 13,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }
}

// ── Floating particles painter ──
class _ParticlePainter extends CustomPainter {
  final double progress;
  static final List<_Particle> _particles = _generateParticles();

  _ParticlePainter(this.progress);

  static List<_Particle> _generateParticles() {
    final rng = math.Random(42);
    return List.generate(18, (i) {
      return _Particle(
        x: rng.nextDouble(),
        y: rng.nextDouble(),
        radius: rng.nextDouble() * 2.0 + 0.5,
        speed: rng.nextDouble() * 0.15 + 0.05,
        phase: rng.nextDouble() * 2 * math.pi,
        opacity: rng.nextDouble() * 0.35 + 0.05,
      );
    });
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in _particles) {
      final dy = (p.y - progress * p.speed) % 1.0;
      final dx = p.x +
          math.sin(progress * 2 * math.pi + p.phase) * 0.015;

      final paint = Paint()
        ..color = Colors.white.withValues(
          alpha: p.opacity * (0.5 + 0.5 * math.sin(progress * 4 * math.pi + p.phase)),
        )
        ..style = PaintingStyle.fill;

      canvas.drawCircle(
        Offset(dx * size.width, dy * size.height),
        p.radius,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_ParticlePainter oldDelegate) => true;
}

class _Particle {
  final double x, y, radius, speed, phase, opacity;
  const _Particle({
    required this.x,
    required this.y,
    required this.radius,
    required this.speed,
    required this.phase,
    required this.opacity,
  });
}

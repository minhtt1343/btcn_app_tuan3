import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

// 1. Cấu hình Điều hướng (Navigation)
final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: '/list',
      builder: (context, state) => const ListScreen(),
    ),
    GoRoute(
      path: '/detail',
      builder: (context, state) => const DetailScreen(),
    ),
  ],
);

// 2. Class Root với khung giao diện kiểu Điện thoại
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UI Components App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      builder: (context, child) {
        return Scaffold(
          backgroundColor: const Color(0xFF1E1E1E), // Màu nền bao bên ngoài
          body: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24), // Bo góc khung điện thoại
              child: Container(
                width: 390,  // Chiều rộng chuẩn điện thoại
                height: 844, // Chiều cao chuẩn điện thoại
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: MaterialApp.router(
                  debugShowCheckedModeBanner: false,
                  routerConfig: _router,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// 3. Màn hình 1: Welcome Screen
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 40),
              Column(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: const Color(0xFF00C853),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(
                      child: Text(
                        'LOGO',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Jetpack Compose / Flutter',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Jetpack Compose is a modern UI toolkit for building native Android applications using a declarative programming approach.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => context.go('/list'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2196F3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    "I'm ready",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 4. Màn hình 2: Components List
class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'UI Components List',
          style: TextStyle(color: Color(0xFF2196F3), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: [
          const SectionTitle(title: 'Display'),
          ComponentCard(
            title: 'Text',
            description: 'Displays text',
            onTap: () => context.go('/detail'),
          ),
          const ComponentCard(title: 'Image', description: 'Displays an image'),

          const SectionTitle(title: 'Input'),
          const ComponentCard(title: 'TextField', description: 'Input field for text'),
          const ComponentCard(title: 'PasswordField', description: 'Input field for passwords'),

          const SectionTitle(title: 'Layout'),
          const ComponentCard(title: 'Column', description: 'Arranges elements vertically'),
          const ComponentCard(title: 'Row', description: 'Arranges elements horizontally'),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
    );
  }
}

class ComponentCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback? onTap;

  const ComponentCard({
    super.key,
    required this.title,
    required this.description,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Material(
        color: const Color(0xFFD6EAF8),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Text(
                  description,
                  style: const TextStyle(color: Colors.black54, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// 5. Màn hình 3: Text Detail
class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Text Detail',
          style: TextStyle(color: Color(0xFF2196F3), fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/list'),
        ),
      ),
      body: Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
            style: TextStyle(fontSize: 20, color: Colors.black, height: 1.5),
            children: [
              TextSpan(text: 'The '),
              TextSpan(
                text: 'quick',
                style: TextStyle(decoration: TextDecoration.lineThrough),
              ),
              TextSpan(text: ' '),
              TextSpan(
                text: 'Brown',
                style: TextStyle(
                  color: Color(0xFFA52A2A),
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              TextSpan(text: '\nfox '),
              TextSpan(text: 'j u m p s '),
              TextSpan(
                text: 'over',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(text: '\nthe '),
              TextSpan(
                text: 'lazy',
                style: TextStyle(decoration: TextDecoration.underline),
              ),
              TextSpan(text: ' dog.'),
            ],
          ),
        ),
      ),
    );
  }
}
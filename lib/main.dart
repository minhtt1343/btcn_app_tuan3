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
      path: '/text_detail',
      builder: (context, state) => const TextDetailScreen(),
    ),
    GoRoute(
      path: '/images_detail',
      builder: (context, state) => const ImagesDetailScreen(),
    ),
    GoRoute(
      path: '/textfield_detail',
      builder: (context, state) => const TextFieldDetailScreen(),
    ),
    GoRoute(
      path: '/row_detail',
      builder: (context, state) => const RowDetailScreen(),
    ),
    GoRoute(
      path: '/theory_detail',
      builder: (context, state) => const TheoryDetailScreen(),
    ),
  ],
);

// 2. Class Root với khung giao diện kiểu Điện Thoại
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
              borderRadius: BorderRadius.circular(24), // Bo góc mô hình điện thoại
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

// 3. Màn hình Welcome
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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Jetpack Compose is a modern UI toolkit for building native Android applications using a declarative programming approach.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 14),
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

// 4. Màn hình UI Components List
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
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        children: [
          const SectionTitle(title: 'Display'),
          ComponentCard(
            title: 'Text',
            description: 'Displays text',
            onTap: () => context.go('/text_detail'),
          ),
          ComponentCard(
            title: 'Image',
            description: 'Displays an image',
            onTap: () => context.go('/images_detail'),
          ),

          const SectionTitle(title: 'Input'),
          ComponentCard(
            title: 'TextField',
            description: 'Input field for text',
            onTap: () => context.go('/textfield_detail'),
          ),
          const ComponentCard(
            title: 'PasswordField',
            description: 'Input field for passwords',
          ),

          const SectionTitle(title: 'Layout'),
          const ComponentCard(
            title: 'Column',
            description: 'Arranges elements vertically',
          ),
          ComponentCard(
            title: 'Row',
            description: 'Arranges elements horizontally',
            onTap: () => context.go('/row_detail'),
          ),

          const SizedBox(height: 12),
          // Nút Tự tìm hiểu ở dưới cùng
          InkWell(
            onTap: () => context.go('/theory_detail'),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color(0xFFFFCDD2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tự tìm hiểu',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Tìm ra tất cả các thành phần UI Cơ bản',
                    style: TextStyle(color: Colors.black87, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
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

// 5. Màn hình Text Detail
class TextDetailScreen extends StatelessWidget {
  const TextDetailScreen({super.key});

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

// 6. Màn hình Images Detail (Cập nhật sử dụng img1.jpg và img2.webp)
class ImagesDetailScreen extends StatelessWidget {
  const ImagesDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Images',
          style: TextStyle(color: Color(0xFF2196F3), fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/list'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Ảnh 1: img1.jpg
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/img1.jpg',
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 180,
                  color: Colors.grey.shade300,
                  child: const Center(child: Text('Không tìm thấy assets/img1.jpg')),
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'assets/img1.jpg',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // Ảnh 2: img2.webp
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/img2.webp',
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 180,
                  color: Colors.grey.shade300,
                  child: const Center(child: Text('Không tìm thấy assets/img2.webp')),
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text('In app', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

// 7. Màn hình TextField Detail
class TextFieldDetailScreen extends StatefulWidget {
  const TextFieldDetailScreen({super.key});

  @override
  State<TextFieldDetailScreen> createState() => _TextFieldDetailScreenState();
}

class _TextFieldDetailScreenState extends State<TextFieldDetailScreen> {
  String _inputText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TextField',
          style: TextStyle(color: Color(0xFF2196F3), fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/list'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            TextField(
              onChanged: (value) {
                setState(() {
                  _inputText = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Thông tin nhập',
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              _inputText.isEmpty ? 'Tự động cập nhật dữ liệu theo textfield' : _inputText,
              style: const TextStyle(color: Colors.red, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}

// 8. Màn hình Row Layout
class RowDetailScreen extends StatelessWidget {
  const RowDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Row Layout',
          style: TextStyle(color: Color(0xFF2196F3), fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/list'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: List.generate(
            4,
            (rowIndex) => Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  3,
                  (colIndex) => Container(
                    width: 90,
                    height: 50,
                    decoration: BoxDecoration(
                      color: colIndex == 1 ? Colors.blue : Colors.blue.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// 9. Màn hình Tự Tìm Hiểu UI
class TheoryDetailScreen extends StatelessWidget {
  const TheoryDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tự Tìm Hiểu UI',
          style: TextStyle(color: Color(0xFF2196F3), fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/list'),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          SectionTitle(title: 'Display'),
          ComponentCard(title: 'Text', description: 'Displays text'),
          ComponentCard(title: 'Image', description: 'Displays an image'),

          SectionTitle(title: 'Input'),
          ComponentCard(title: 'TextField', description: 'Input field for text'),
          ComponentCard(title: 'PasswordField', description: 'Input field for passwords'),
          ComponentCard(title: 'Toggle', description: 'On/off switch'),
          ComponentCard(title: 'Slider', description: 'Selects a value from a range'),
          ComponentCard(title: 'DatePicker', description: 'Selects a date and time'),

          SectionTitle(title: 'Selection'),
          ComponentCard(title: 'Button', description: 'Triggers an action when tapped'),
          ComponentCard(title: 'Checkbox', description: 'Selects one or multiple options'),
          ComponentCard(title: 'RadioButton', description: 'Selects a single option'),
          ComponentCard(title: 'Picker', description: 'Selects a value from a list'),

          SectionTitle(title: 'Navigation'),
          ComponentCard(title: 'NavigationView', description: 'Navigation container with title and back button'),
          ComponentCard(title: 'TabBar', description: 'Switches between main sections'),
          ComponentCard(title: 'Menu', description: 'Shows a menu with multiple actions'),

          SectionTitle(title: 'Content'),
          ComponentCard(title: 'List', description: 'Displays a list of items'),
          ComponentCard(title: 'Card', description: 'Container with content and style'),
          ComponentCard(title: 'Divider', description: 'Separates content into sections'),
        ],
      ),
    );
  }
}
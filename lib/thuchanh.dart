import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const PracticeApp());
}

// Cấu hình Router cho Thực hành 1 & 2
final GoRouter _practiceRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const RootScreen(),
    ),
    GoRoute(
      path: '/list',
      builder: (context, state) => const LazyListScreen(),
    ),
    GoRoute(
      path: '/detail',
      builder: (context, state) {
        final itemIndex = state.extra as int? ?? 1;
        return DetailScreen(itemIndex: itemIndex);
      },
    ),
  ],
);

class PracticeApp extends StatelessWidget {
  const PracticeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'THỰC HÀNH NAVIGATION + LAZYCOLUMN',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      builder: (context, child) {
        return Scaffold(
          backgroundColor: const Color(0xFF1E1E1E),
          body: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Container(
                width: 390,
                height: 844,
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
                  routerConfig: _practiceRouter,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// 1. MÀN HÌNH ROOT (Thực hành 1 & 2)
class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Choose List Type',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo biểu tượng
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.blue.shade900,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.layers_sharp,
                size: 60,
                color: Colors.greenAccent,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Navigation',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'A framework that simplifies the implementation of navigation between different UI components (screens) in an app.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 40),

            // Nút bấm cho Thực hành 2: Column (1,000,000 items)
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () => context.go('/list'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Column (1,000,000 items)',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Nút PUSH (Thực hành 1: Root -> List<Lazy>)
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () => context.go('/list'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF9800),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'LazyColumn (1,000,000 items)',
                  style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 2. MÀN HÌNH LAZYCOLUMN (1,000,000 items - Tối ưu bộ nhớ)
class LazyListScreen extends StatelessWidget {
  const LazyListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'LazyColumn',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go('/'), // List -> Root
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: 1000000, // Tải 1,000,000 phần tử
        itemBuilder: (context, index) {
          final itemNumber = index + 1;
          return Card(
            margin: const EdgeInsets.only(bottom: 10),
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              title: Text(
                '$itemNumber',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              subtitle: const Text(
                '"The only way to do great work is to love what you do."',
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
              trailing: const Icon(Icons.chevron_right, color: Colors.black54),
              onTap: () {
                // Chuyển List -> Detail (kèm dữ liệu vi trí item)
                context.go('/detail', extra: itemNumber);
              },
            ),
          );
        },
      ),
    );
  }
}

// 3. MÀN HÌNH DETAIL
class DetailScreen extends StatelessWidget {
  final int itemIndex;

  const DetailScreen({super.key, required this.itemIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go('/list'), // Detail -> List
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(height: 20),
                const Text(
                  '"The only way to do great work\nis to love what you do."',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, color: Colors.black87),
                ),
                const SizedBox(height: 30),
                // Ô hiển thị thông tin trích dẫn theo hình mẫu
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(0xFFB3E5FC),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '"The only way to do great work is to love what you do."',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Item #$itemIndex - Steve Jobs',
                        style: const TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Nút BACK TO ROOT (Detail -> Root)
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () => context.go('/'), // Detail -> Root
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3F51B5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'BACK TO ROOT',
                  style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const GardenPetApp());
}

class GardenPetApp extends StatelessWidget {
  const GardenPetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grow A Garden Pet Info',
      debugShowCheckedModeBanner: false,
      home: const GardenPetHome(),
    );
  }
}

class GardenPetHome extends StatefulWidget {
  const GardenPetHome({super.key});

  @override
  State<GardenPetHome> createState() => _GardenPetHomeState();
}

class _GardenPetHomeState extends State<GardenPetHome> {
  int _currentPage = 0;
  late Timer _timer;
  final PageController _pageController = PageController();

  // Manual carousel images
  final List<String> imageAssets = [
    'assets/roblox 1.png',
    'assets/roblox 2.png',
    'assets/roblox 3.png',
    'assets/frog.png',
  ];

  // Manual gallery images
  final List<String> galleryImages = [
    'assets/hedgehog.png',
    'assets/turtle.png',
    'assets/queen bee.png',
    'assets/fish.png',
    'assets/hamster.png',
    'assets/parrot.png',
    'assets/snake.png',
    'assets/lizard.png',
    'assets/goat.png',
    'assets/duck.png',
    'assets/horse.png',
    'assets/chicken.png',
    'assets/hedgehog.png',
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      final next = (_currentPage + 1) % imageAssets.length;
      _pageController.animateToPage(
        next,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF7B3F00),
      appBar: AppBar(
        backgroundColor: const Color(0xFF59C639),
        title: const Text(
          'Grow A Garden Pet Info',
          style: TextStyle(
            fontFamily: 'Times New Roman',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          // Carousel
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 20),
                SizedBox(
                  height: 270,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: imageAssets.length,
                    onPageChanged: (i) => setState(() => _currentPage = i),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF5A2E0C),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          padding: const EdgeInsets.all(4),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              imageAssets[index],
                              fit: BoxFit.cover,
                              errorBuilder: (c, e, s) =>
                                  const Center(child: Icon(Icons.error)),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    imageAssets.length,
                    (i) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _currentPage == i ? 12 : 8,
                      height: _currentPage == i ? 12 : 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            _currentPage == i ? Colors.white : Colors.white54,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),

          // Grid of pets (manual)
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        galleryImages[index],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Center(child: Icon(Icons.error)),
                      ),
                    ),
                  );
                },
                childCount: galleryImages.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF1A1A2E),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            color: Colors.white70,
          ),
        ),
      ),
      home: const GardenPetHome(),
    );
  }
}

class GardenPetHome extends StatefulWidget {
  const GardenPetHome({super.key});

  @override
  State<GardenPetHome> createState() => _GardenPetHomeState();
}

class _GardenPetHomeState extends State<GardenPetHome>
    with TickerProviderStateMixin {
  int _currentPage = 0;
  late Timer _timer;
  final PageController _pageController = PageController();
  final Set<int> _pressedIndexes = {};
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  String _selectedCategory = "All"; // Track selected category as "All"

  final List<String> imageAssets = [
    'assets/roblox 1.png',
    'assets/roblox 2.png',
    'assets/roblox 3.png',
    'assets/tarantula001.png',
  ];

  final List<String> galleryImages = [
    'assets/hedgehog.png',
    'assets/turtle.png',
    'assets/queen bee.png',
    'assets/tarantula.png',
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

  final List<String> petDetailImages = [
    'assets/hedgehog11.png',
    'assets/turtle_big.png',
    'assets/queenbee11.png',
    'assets/tarantula001.png',
    'assets/hamster_big.png',
    'assets/parrot_big.png',
    'assets/snake_big.png',
    'assets/lizard_big.png',
    'assets/goat_big.png',
    'assets/duck_big.png',
    'assets/horse_big.png',
    'assets/chicken_big.png',
    'assets/hedgehog_big.png',
  ];

  final List<String> petNames = [
    'Hedgehog',
    'Turtle',
    'Queen Bee',
    'Tarantula',
    'Hamster',
    'Parrot',
    'Snake',
    'Lizard',
    'Goat',
    'Duck',
    'Horse',
    'Chicken',
    'Hedgehog',
  ];

  final List<String> petRarities = [
    'Common',
    'Common',
    'Rare',
    'Rare',
    'Common',
    'Rare',
    'Divine',
    'Divine',
    'Common',
    'Common',
    'Rare',
    'Common',
    'Common',
  ];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _fadeController.forward();
    
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      final next = (_currentPage + 1) % imageAssets.length;
      _pageController.animateToPage(
        next,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    _fadeController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  // Method to filter pets based on selected category
  List<int> _getFilteredPetIndexes() {
    switch (_selectedCategory) {
      case "Bee Egg":
        // Only show Queen Bee (index 2) in the Bee Egg category
        return [2];
      case "All":
      default:
        // Show all pets
        return List.generate(galleryImages.length, (index) => index);
    }
  }

  List<Color> _getRarityColors(String rarity) {
    switch (rarity.toLowerCase()) {
      case 'common':
        return [const Color(0xFF95A5A6), const Color(0xFF7F8C8D)];
      case 'rare':
        return [const Color(0xFF3498DB), const Color(0xFF2980B9)];
      case 'divine':
        return [const Color(0xFFE74C3C), const Color(0xFFC0392B)];
      default:
        return [const Color(0xFF95A5A6), const Color(0xFF7F8C8D)];
    }
  }

  // Show the dialog with pet details
  void showImageDialog(String imagePath, String petName, String rarity) {
    _scaleController.forward();
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(20),
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
          ),
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFF8B4513),
                      const Color(0xFFA0522D),
                      const Color(0xFF8B4513),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            imagePath,
                            fit: BoxFit.cover,
                            width: 200,
                            height: 200,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        petName,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              offset: Offset(0, 2),
                              blurRadius: 4,
                              color: Colors.black26,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: _getRarityColors(rarity),
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          rarity,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "A magnificent $petName ready for your garden adventure!",
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 28),
                  onPressed: () => Navigator.of(context).pop(),
                  tooltip: 'Close',
                ),
              ),
            ],
          ),
        ),
      ),
    ).then((_) => _scaleController.reset());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4CAF50),
        title: const Text(
          'Grow A Garden Pet Info',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF7B3F00),
              Color(0xFF8B4513),
              Color(0xFFA0522D),
            ],
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              // Hero Carousel Section
              SliverToBoxAdapter(
                child: FadeTransition(
                  opacity: _fadeController,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 250,
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: imageAssets.length,
                            onPageChanged: (i) => setState(() => _currentPage = i),
                            itemBuilder: (context, index) {
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: const EdgeInsets.symmetric(horizontal: 16),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(24),
                                    child: Image.asset(
                                      imageAssets[index],
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      errorBuilder: (c, e, s) => const Center(
                                        child: Icon(
                                          Icons.error,
                                          color: Colors.white,
                                          size: 40,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Dots Indicator
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            imageAssets.length,
                            (i) => AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.symmetric(horizontal: 6),
                              width: _currentPage == i ? 24 : 8,
                              height: 8,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                gradient: LinearGradient(
                                  colors: _currentPage == i
                                      ? [const Color(0xFF59C639), const Color(0xFF4CAF50)]
                                      : [Colors.white.withOpacity(0.3), Colors.white.withOpacity(0.1)],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Category Button Bar directly below carousel
                        SizedBox(
                          height: 56,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            children: [
                              _buildCategoryButton("All", _selectedCategory == "All"),
                              _buildCategoryButton("Common", _selectedCategory == "Common"),
                              _buildCategoryButton("Uncommon", _selectedCategory == "Uncommon"),
                              _buildCategoryButton("Rare", _selectedCategory == "Rare"),
                              _buildCategoryButton("Legendary Egg", _selectedCategory == "Legendary Egg"),
                              _buildCategoryButton("Mythical Egg", _selectedCategory == "Mythical Egg"),
                              _buildCategoryButton("Bug Egg", _selectedCategory == "Bug Egg"),
                              _buildCategoryButton("Bee Egg", _selectedCategory == "Bee Egg"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Pet Grid Section
              SliverPadding(
                padding: const EdgeInsets.all(20),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 0.8,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final filteredIndexes = _getFilteredPetIndexes();
                      final originalIndex = filteredIndexes[index];
                      final isPressed = _pressedIndexes.contains(originalIndex);

                      return Listener(
                        onPointerDown: (_) =>
                            setState(() => _pressedIndexes.add(originalIndex)),
                        onPointerUp: (_) =>
                            setState(() => _pressedIndexes.remove(originalIndex)),
                        onPointerCancel: (_) =>
                            setState(() => _pressedIndexes.remove(originalIndex)),
                        child: AnimatedScale(
                          scale: isPressed ? 0.95 : 1.0,
                          duration: const Duration(milliseconds: 150),
                          child: GestureDetector(
                            onTap: () => showImageDialog(
                                petDetailImages[originalIndex], 
                                petNames[originalIndex],
                                petRarities[originalIndex]),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    const Color(0xFF8B4513),
                                    const Color(0xFFA0522D),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: const Color(0xFF7B3F00),
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF7B3F00).withOpacity(0.18),
                                    blurRadius: 16,
                                    spreadRadius: 2,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: Image.asset(
                                          galleryImages[originalIndex],
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) =>
                                              const Icon(Icons.error, size: 40, color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          petNames[originalIndex],
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 6),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: _getRarityColors(petRarities[originalIndex])[0],
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(
                                              color: _getRarityColors(petRarities[originalIndex])[1],
                                              width: 2,
                                            ),
                                          ),
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: ConstrainedBox(
                                              constraints: const BoxConstraints(minWidth: 75),
                                              child: Text(
                                                petRarities[originalIndex],
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: _getFilteredPetIndexes().length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryButton(String label, bool isActive) {
    IconData iconData;
    Color? iconColor;
    switch (label) {
      case "All":
        iconData = Icons.pets;
        break;
      case "Common":
        iconData = Icons.star_border;
        break;
      case "Uncommon":
        iconData = Icons.star_half;
        break;
      case "Rare":
        iconData = Icons.star;
        break;
      case "Legendary Egg":
        iconData = Icons.egg_outlined;
        iconColor = Color(0xFFFFD700); // Gold
        break;
      case "Mythical Egg":
        iconData = Icons.egg_outlined;
        break;
      case "Bug Egg":
        iconData = Icons.bug_report;
        break;
      case "Bee Egg":
        iconData = Icons.emoji_nature;
        break;
      default:
        iconData = Icons.category;
    }
    
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF59C639) : Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isActive ? Colors.green.shade700 : Colors.white.withOpacity(0.1),
          width: 2,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.green.withOpacity(0.3),
          borderRadius: BorderRadius.circular(18),
          onTap: () {
            setState(() {
              _selectedCategory = label;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  iconData,
                  color: iconColor ?? (isActive ? Colors.white : Colors.white70),
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  label,
          style: TextStyle(
                    color: isActive ? Colors.white : Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

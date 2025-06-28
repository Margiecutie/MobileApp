import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// PetInfo class at top-level
class PetInfo {
  final String name;
  final String image;
  final String detailImage;
  final String description;
  final String tier;
  final String obtainingMethod;
  final String hatchChance;
  final String passive;
  final String obtainable;
  final String dateAdded;
  final String? box;

  PetInfo({
    required this.name,
    required this.image,
    required this.detailImage,
    required this.description,
    required this.tier,
    required this.obtainingMethod,
    required this.hatchChance,
    required this.passive,
    required this.obtainable,
    required this.dateAdded,
    this.box,
  });
}

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
    'assets/frog.png',
  ];

  final List<String> galleryImages = [
    'assets/hedgehog.png',
    'assets/turtle.png',
    'assets/queen bee.png',
    'assets/tarantula.png',
    'assets/bunny.png',
    'assets/crab.png',
    'assets/dog.png',
    'assets/dog1.png',
    'assets/seagul.png',
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
    'assets/bunny.png',
    'assets/crab.png',
    'assets/dog.png',
    'assets/dog1.png',
    'assets/seagul.png',
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
    'Bunny',
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
      case "Common":
        // Show pets with Common tier
        return pets
            .asMap()
            .entries
            .where((entry) => pets[entry.key].tier.toLowerCase() == 'common')
            .map((entry) => entry.key)
            .toList();
      case "Uncommon":
        // Show pets with Uncommon tier
        return pets
            .asMap()
            .entries
            .where((entry) => pets[entry.key].tier.toLowerCase() == 'uncommon')
            .map((entry) => entry.key)
            .toList();
      case "Rare":
        // Show pets with Rare tier
        return pets
            .asMap()
            .entries
            .where((entry) => pets[entry.key].tier.toLowerCase() == 'rare')
            .map((entry) => entry.key)
            .toList();
      case "Legendary":
        // Show pets with Legendary tier
        return pets
            .asMap()
            .entries
            .where((entry) => pets[entry.key].tier.toLowerCase() == 'legendary')
            .map((entry) => entry.key)
            .toList();
      case "Mythical":
        // Show pets with Mythical tier
        return pets
            .asMap()
            .entries
            .where((entry) => pets[entry.key].tier.toLowerCase() == 'mythical')
            .map((entry) => entry.key)
            .toList();
      case "Divine":
        // Show pets with Divine tier
        return pets
            .asMap()
            .entries
            .where((entry) => pets[entry.key].tier.toLowerCase() == 'divine')
            .map((entry) => entry.key)
            .toList();
      case "Prismatic":
        // Show pets with Prismatic tier
        return pets
            .asMap()
            .entries
            .where((entry) => pets[entry.key].tier.toLowerCase() == 'prismatic')
            .map((entry) => entry.key)
            .toList();
      case "All":
      default:
        // Show all pets
        return List.generate(pets.length, (index) => index);
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

  // Replace the pet data lists with a list of PetInfo objects (showing only the first pet as an example)
  final List<PetInfo> pets = [
    PetInfo(
      name: 'Starfish',
      image: 'assets/starfish.jpg',
      detailImage: 'assets/starfish.jpg',
      description: 'A Starfish',
      tier: 'Common',
      obtainingMethod: 'Common Summer Egg',
      hatchChance: '50%',
      passive: 'You\'re a Star: Gains additional XP per second',
      obtainable: 'Yes',
      dateAdded: 'June 21, 2025',
    ),
    PetInfo(
      name: 'Queen Bee',
      image: 'assets/queen bee.png',
      detailImage: 'assets/queenbee11.png',
      description: 'A Queen Bee',
      tier: 'Rare',
      obtainingMethod: 'Bee Egg',
      hatchChance: '25%',
      passive: 'Honey Maker: Produces honey over time',
      obtainable: 'Yes',
      dateAdded: 'June 15, 2025',
    ),
    PetInfo(
      name: 'Bunny',
      image: 'assets/bunny.png',
      detailImage: 'assets/bunny.png',
      description: 'The Bunny.',
      tier: 'Common',
      obtainingMethod: 'Common Egg',
      hatchChance: '33.33%',
      passive: 'Every 40s, eats a carrot at a 1.5x value bonus.',
      obtainable: 'Yes',
      dateAdded: 'May 3rd, 2025',
    ),
    PetInfo(
      name: 'Crab',
      image: 'assets/crab.png',
      detailImage: 'assets/crab.png',
      description: 'A Crab',
      tier: 'Common',
      obtainingMethod: 'Common Summer Egg',
      hatchChance: '25%',
      passive:
          'Pinch Pocket: Occasionally goes to another player and pinches them and grants you a small amount of sheckles',
      obtainable: 'Yes',
      dateAdded: 'June 21, 2025',
    ),
    PetInfo(
      name: 'Dog',
      image: 'assets/dog.png',
      detailImage: 'assets/dog.png',
      description: 'A loyal Dog',
      tier: 'Common',
      obtainingMethod: 'Common Egg',
      hatchChance: '33.33%',
      passive: 'Every 60s, 5% chance to dig up a random seed.',
      obtainable: 'Yes',
      dateAdded: 'May 3rd, 2025',
      box: 'Common Egg',
    ),
    PetInfo(
      name: 'Puppy',
      image: 'assets/dog1.png',
      detailImage: 'assets/dog1.png',
      description: 'A cute Puppy',
      tier: 'Common',
      obtainingMethod: 'Pet Egg',
      hatchChance: '45%',
      passive: 'Playful: Makes you happy',
      obtainable: 'Yes',
      dateAdded: 'June 17, 2025',
    ),
    PetInfo(
      name: 'Seagull',
      image: 'assets/seagul.png',
      detailImage: 'assets/seagul.png',
      description: 'A Seagull',
      tier: 'Common',
      obtainingMethod: 'Common Summer Egg',
      hatchChance: '25%',
      passive:
          'Scavenger: Shoveling plants have a percent chance to drop the equivalent seed. Does not work on fruits. Hunger: 3500',
      obtainable: 'Yes',
      dateAdded: 'June 21, 2025',
    ),
    PetInfo(
      name: 'Duck',
      image: 'assets/duck.png',
      detailImage: 'assets/duck_big.png',
      description: 'A swimming Duck',
      tier: 'Common',
      obtainingMethod: 'Water Egg',
      hatchChance: '50%',
      passive: 'Water Walker: Can walk on water',
      obtainable: 'Yes',
      dateAdded: 'June 14, 2025',
    ),
    PetInfo(
      name: 'Horse',
      image: 'assets/horse.png',
      detailImage: 'assets/horse_big.png',
      description: 'A strong Horse',
      tier: 'Divine',
      obtainingMethod: 'Farm Egg',
      hatchChance: '25%',
      passive: 'Speed Runner: Very fast movement',
      obtainable: 'Yes',
      dateAdded: 'June 13, 2025',
    ),
    PetInfo(
      name: 'Chicken',
      image: 'assets/chicken.png',
      detailImage: 'assets/chicken_big.png',
      description: 'A farm Chicken',
      tier: 'Common',
      obtainingMethod: 'Farm Egg',
      hatchChance: '60%',
      passive: 'Egg Layer: Lays eggs daily',
      obtainable: 'Yes',
      dateAdded: 'June 12, 2025',
    ),
    PetInfo(
      name: 'Hedgehog',
      image: 'assets/hedgehog.png',
      detailImage: 'assets/hedgehog_big.png',
      description: 'A spiky Hedgehog',
      tier: 'Prismatic',
      obtainingMethod: 'Forest Egg',
      hatchChance: '40%',
      passive: 'Spike Shield: Protects from damage',
      obtainable: 'Yes',
      dateAdded: 'June 11, 2025',
    ),
  ];

  // Update the pet grid to use pets list
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4CAF50),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Grow A Garden',
              style: GoogleFonts.quicksand(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.1,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'Pet Info',
              style: GoogleFonts.quicksand(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.0,
                color: Colors.white70,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    backgroundColor: Colors.transparent,
                    insetPadding: const EdgeInsets.all(24),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF8B4513),
                            Color(0xFFA0522D),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: Color(0xFFF5DEB3), width: 2),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'How to Use',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Click any pet box below to view its information.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: const Color(0xFFF5DEB3),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text(
                                'OK',
                                style: TextStyle(
                                  color: Color(0xFF8B4513),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0x804CAF50), // semi-transparent green
                  shape: BoxShape.circle,
                  border: Border.all(color: Color(0xFFF5DEB3), width: 1.5),
                ),
                child: const Center(
                  child: Text(
                    'i',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
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
                            onPageChanged: (i) =>
                                setState(() => _currentPage = i),
                            itemBuilder: (context, index) {
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    border: Border.all(
                                      color: Color(0xFFF5DEB3),
                                      width: 2,
                                    ),
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
                                      ? [
                                          const Color(0xFF59C639),
                                          const Color(0xFF4CAF50)
                                        ]
                                      : [
                                          Colors.white.withOpacity(0.3),
                                          Colors.white.withOpacity(0.1)
                                        ],
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
                              _buildCategoryButton(
                                  "All", _selectedCategory == "All"),
                              _buildCategoryButton(
                                  "Common", _selectedCategory == "Common"),
                              _buildCategoryButton(
                                  "Uncommon", _selectedCategory == "Uncommon"),
                              _buildCategoryButton(
                                  "Rare", _selectedCategory == "Rare"),
                              _buildCategoryButton("Legendary",
                                  _selectedCategory == "Legendary"),
                              _buildCategoryButton(
                                  "Mythical", _selectedCategory == "Mythical"),
                              _buildCategoryButton(
                                  "Divine", _selectedCategory == "Divine"),
                              _buildCategoryButton("Prismatic",
                                  _selectedCategory == "Prismatic"),
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
                        onPointerUp: (_) => setState(
                            () => _pressedIndexes.remove(originalIndex)),
                        onPointerCancel: (_) => setState(
                            () => _pressedIndexes.remove(originalIndex)),
                        child: AnimatedScale(
                          scale: isPressed ? 0.95 : 1.0,
                          duration: const Duration(milliseconds: 150),
                          child: GestureDetector(
                            onTap: () => showImageDialog(pets[originalIndex]),
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
                                  color: Colors.white,
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF7B3F00)
                                        .withOpacity(0.18),
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
                                          pets[originalIndex].image,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  const Icon(Icons.error,
                                                      size: 40,
                                                      color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          pets[originalIndex].name,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 6),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: _getRarityColors(
                                                pets[originalIndex].tier)[0],
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                              color: _getRarityColors(
                                                  pets[originalIndex].tier)[1],
                                              width: 2,
                                            ),
                                          ),
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: ConstrainedBox(
                                              constraints: const BoxConstraints(
                                                  minWidth: 75),
                                              child: Text(
                                                pets[originalIndex].tier,
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
      case "Legendary":
        iconData = Icons.egg_outlined;
        iconColor = Color(0xFFFFD700); // Gold
        break;
      case "Mythical":
        iconData = Icons.egg_outlined;
        break;
      case "Divine":
        iconData = Icons.emoji_nature;
        break;
      case "Prismatic":
        iconData = Icons.emoji_nature;
        break;
      default:
        iconData = Icons.category;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color:
            isActive ? const Color(0xFF59C639) : Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color:
              isActive ? Colors.green.shade700 : Colors.white.withOpacity(0.1),
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
                  color:
                      iconColor ?? (isActive ? Colors.white : Colors.white70),
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

  // Update showImageDialog to accept PetInfo and show a detailed card
  void showImageDialog(PetInfo pet) {
    _scaleController.forward();
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(12),
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
          ),
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 340),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF234022),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFF4CAF50), width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.18),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      children: [
                        Column(
                          children: [
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 6), // match Info bar
                              decoration: BoxDecoration(
                                color: const Color(0xFF5DA25A),
                                borderRadius:
                                    BorderRadius.circular(6), // match Info bar
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    pet.name,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  if (pet.box != null) ...[
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF4CAF50),
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      child: Text(
                                        pet.box!,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: IconButton(
                            icon: const Icon(Icons.close,
                                color: Colors.white, size: 24),
                            onPressed: () => Navigator.of(context).pop(),
                            tooltip: 'Close',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        pet.detailImage,
                        width: 140,
                        height: 140,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 2),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF5DA25A),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        pet.description,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF5DA25A),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Center(
                        child: Text(
                          'Info',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 7),
                    _infoRow('Tier', pet.tier),
                    _infoRow('Obtaining method', pet.obtainingMethod,
                        highlight: true),
                    _infoRow('Hatch Chance', pet.hatchChance),
                    _infoRow('Passive', pet.passive),
                    _infoRow('Obtainable?', pet.obtainable),
                    _infoRow('Date Added', pet.dateAdded),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ).then((_) => _scaleController.reset());
  }

  Widget _infoRow(String label, String value, {bool highlight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: highlight ? Colors.yellow[600] : Colors.white,
                fontWeight: highlight ? FontWeight.bold : FontWeight.normal,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

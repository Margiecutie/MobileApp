import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'egg_hatching_guide.dart';
import 'pets_data.dart';
import 'dart:ui';

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
  String _selectedCategory = "All"; // Track selected category as "All"
  int _petPage = 0;
  static const int petsPerPage = 6;

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
      case "All":
      default:
        // Group all Divine pets (including Queen Bee) together at the end
        final nonDivine = <int>[];
        final divine = <int>[];
        for (var i = 0; i < pets.length; i++) {
          if (pets[i].tier.toLowerCase() == 'divine') {
            divine.add(i);
          } else {
            nonDivine.add(i);
          }
        }
        return [...nonDivine, ...divine];
    }
  }

  List<int> _getPagedPetIndexes() {
    final filtered = _getFilteredPetIndexes();
    final start = _petPage * petsPerPage;
    final end = (start + petsPerPage) > filtered.length
        ? filtered.length
        : (start + petsPerPage);
    return filtered.sublist(start, end);
  }

  List<Color> _getRarityColors(String rarity) {
    switch (rarity.toLowerCase()) {
      case 'common':
        // Use white for Common
        return [const Color(0xFFF5F5F5), const Color(0xFFE0E0E0)];
      case 'rare':
        return [const Color(0xFF3498DB), const Color(0xFF2980B9)];
      case 'legendary':
        // Use gold/yellow for Legendary
        return [const Color(0xFFFFD700), const Color(0xFFFFB300)];
      case 'divine':
        return [const Color(0xFFE74C3C), const Color(0xFFC0392B)];
      case 'mythical':
        // Use orange for Mythical
        return [const Color(0xFFFF9800), const Color(0xFFF57C00)];
      default:
        return [const Color(0xFF95A5A6), const Color(0xFF7F8C8D)];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
          IconButton(
            icon: const Icon(Icons.egg_outlined, color: Colors.white),
            tooltip: 'Egg Hatching Guide',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EggHatchingGuidePage(pets: pets),
                ),
              );
            },
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
                            _buildCategoryButton(
                                "Legendary", _selectedCategory == "Legendary"),
                            _buildCategoryButton(
                                "Mythical", _selectedCategory == "Mythical"),
                            _buildCategoryButton(
                                "Divine", _selectedCategory == "Divine"),
                          ],
                        ),
                      ),
                    ],
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
                      final pagedIndexes = _getPagedPetIndexes();
                      final originalIndex = pagedIndexes[index];

                      return GestureDetector(
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
                                color:
                                    const Color(0xFF7B3F00).withOpacity(0.18),
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
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.asset(
                                        pets[originalIndex].image,
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
                              ),
                              const SizedBox(height: 4),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
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
                                        borderRadius: BorderRadius.circular(8),
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
                                            style: TextStyle(
                                              color: pets[originalIndex]
                                                          .tier
                                                          .toLowerCase() ==
                                                      'common'
                                                  ? Colors.black
                                                  : Colors.white,
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
                      );
                    },
                    childCount: _getPagedPetIndexes().length,
                  ),
                ),
              ),
              // Pagination buttons
              SliverToBoxAdapter(
                child: Builder(
                  builder: (context) {
                    final filtered = _getFilteredPetIndexes();
                    final pageCount = (filtered.length / petsPerPage).ceil();
                    if (pageCount <= 1) return const SizedBox.shrink();
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 48, // Constrain height for scroll view
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                  pageCount,
                                  (i) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 2), // More compact
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      curve: Curves.easeInOut,
                                      width: _petPage == i
                                          ? 38
                                          : 32, // More compact
                                      height: _petPage == i
                                          ? 38
                                          : 32, // More compact
                                      decoration: BoxDecoration(
                                        color: _petPage == i
                                            ? const Color(0xFF4CAF50)
                                            : Colors.grey[800],
                                        borderRadius: BorderRadius.circular(19),
                                        boxShadow: [
                                          if (_petPage == i)
                                            BoxShadow(
                                              color: Colors.black
                                                  .withOpacity(0.18),
                                              blurRadius: 8,
                                              offset: const Offset(0, 3),
                                            ),
                                        ],
                                        border: Border.all(
                                          color: _petPage == i
                                              ? Colors.white
                                              : Colors.grey[600]!,
                                          width: 2,
                                        ),
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(19),
                                          onTap: () {
                                            setState(() {
                                              _petPage = i;
                                            });
                                          },
                                          child: Center(
                                            child: Text(
                                              "${i + 1}",
                                              style: TextStyle(
                                                color: _petPage == i
                                                    ? Colors.white
                                                    : Colors.white70,
                                                fontWeight: FontWeight.bold,
                                                fontSize: _petPage == i
                                                    ? 17
                                                    : 15, // More compact
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
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
              _petPage = 0;
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
    showDialog(
      context: context,
      barrierColor: Colors.black54, // semi-transparent dark overlay
      barrierDismissible: true, // Allow tapping outside to close
      builder: (BuildContext dialogContext) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(12),
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
                          onPressed: () {
                            Navigator.of(dialogContext).pop();
                          },
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
    );
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

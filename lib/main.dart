import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'egg_hatching_guide.dart';

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
  final String? hunger;

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
    this.hunger,
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
      detailImage: 'assets/queen bee.png',
      description: 'A Queen Bee',
      tier: 'Divine',
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
      name: 'Bee',
      image: 'assets/bee.png',
      detailImage: 'assets/bee.png',
      description: 'The Bee',
      tier: 'Uncommon',
      obtainingMethod: 'Bee Egg',
      hatchChance: '65%',
      passive:
          'Every ~25m, flies to a nearby fruit and pollinates it, applying the Pollinated mutation.',
      obtainable: 'Yes',
      dateAdded: 'May 31, 2025',
      box: null,
      hunger: '25,000',
    ),
    PetInfo(
      name: 'Black Bunny',
      image: 'assets/black bunny.png',
      detailImage: 'assets/black bunny.png',
      description: 'The Black Bunny.',
      tier: 'Uncommon',
      obtainingMethod: 'Uncommon Egg',
      hatchChance: '25%',
      passive:
          'Every 40 seconds, the Black Bunny searches for a Carrot on the garden and eats it, automatically selling it at a marked up price of 1.5x value.',
      obtainable: 'Yes',
      dateAdded: 'May 3rd, 2025',
      box: null,
    ),
    PetInfo(
      name: 'Chicken',
      image: 'assets/chicken.png',
      detailImage: 'assets/chicken.png',
      description: 'The Chicken.',
      tier: 'Uncommon',
      obtainingMethod: 'Uncommon Egg',
      hatchChance: '25%',
      passive: 'Increases egg hatch speed by 10%.',
      obtainable: 'Yes',
      dateAdded: 'May 3rd, 2025',
      box: null,
    ),
    PetInfo(
      name: 'Cat',
      image: 'assets/moon cat.png',
      detailImage: 'assets/moon cat.png',
      description: 'The Cat.',
      tier: 'Uncommon',
      obtainingMethod: 'Uncommon Egg',
      hatchChance: '25%',
      passive:
          'Every 80 seconds, the Cat will nap for 10 seconds. New fruit within 10 studs will be 1.25x larger.',
      obtainable: 'Yes',
      dateAdded: 'May 3rd, 2025',
      box: null,
    ),
    PetInfo(
      name: 'Deer',
      image: 'assets/deer.png',
      detailImage: 'assets/deer.png',
      description: 'The Deer.',
      tier: 'Uncommon',
      obtainingMethod: 'Uncommon Egg',
      hatchChance: '25%',
      passive: 'Gives a 3% chance for berry plants to stay when harvested.',
      obtainable: 'Yes',
      dateAdded: 'May 3rd, 2025',
      box: null,
      hunger: '2,500',
    ),
    PetInfo(
      name: 'Monkey',
      image: 'assets/monkey.png',
      detailImage: 'assets/monkey.png',
      description: 'The Monkey.',
      tier: 'Rare',
      obtainingMethod: 'Rare Egg',
      hatchChance: '8.33%',
      passive:
          '~2.5% to refund fruit back to your inventory. Rarer plants have a lower chance to refund.',
      obtainable: 'Yes',
      dateAdded: 'May 3, 2025',
      box: null,
      hunger: '7,400',
    ),
    PetInfo(
      name: 'Orange Tabby',
      image: 'assets/orange tabby.png',
      detailImage: 'assets/orange tabby.png',
      description: 'The Orange Tabby.',
      tier: 'Rare',
      obtainingMethod: 'Rare Egg',
      hatchChance: '33.33%',
      passive:
          'Every 90 seconds, naps for 15 seconds and causes new fruit within 15 studs to grow 1.5x larger.',
      obtainable: 'Yes',
      dateAdded: 'May 3rd, 2025',
      box: null,
    ),
    PetInfo(
      name: 'Pig',
      image: 'assets/pig.png',
      detailImage: 'assets/pig.png',
      description: 'The Pig.',
      tier: 'Rare',
      obtainingMethod: 'Rare Egg',
      hatchChance: '16.67%',
      passive:
          'Every 118 seconds, the pig emits a 15 second aura that grants a 2x chance for plants within 15 studs to grow variant fruits.',
      obtainable: 'Yes',
      dateAdded: 'May 3rd, 2025',
      box: null,
    ),
    PetInfo(
      name: 'Rooster',
      image: 'assets/rooster.png',
      detailImage: 'assets/rooster.png',
      description: 'The Rooster.',
      tier: 'Rare',
      obtainingMethod: 'Rare Egg',
      hatchChance: '16.67%',
      passive: 'Increases egg hatch speed by ~20%.',
      obtainable: 'Yes',
      dateAdded: 'May 3rd, 2025',
      box: null,
    ),
    PetInfo(
      name: 'Spotted Deer',
      image: 'assets/spotted deer.png',
      detailImage: 'assets/spotted deer.png',
      description: 'The Spotted Deer.',
      tier: 'Rare',
      obtainingMethod: 'Rare Egg',
      hatchChance: '25%',
      passive: 'Gives a 5% chance for berry plants to stay when harvested.',
      obtainable: 'Yes',
      dateAdded: 'May 3rd, 2025',
      box: null,
      hunger: '2,500',
    ),
    PetInfo(
      name: 'Flamingo',
      image: 'assets/flamingo.png',
      detailImage: 'assets/flamingo.png',
      description: 'A Flamingo',
      tier: 'Rare',
      obtainingMethod: 'Rare Summer Egg',
      hatchChance: '30%',
      passive:
          'Flamboyance: Occasionally stands on one leg and all nearby plants will grow incredibly fast',
      obtainable: 'Yes',
      dateAdded: 'June 21, 2025',
      box: null,
    ),
    PetInfo(
      name: 'Toucan',
      image: 'assets/toucan.png',
      detailImage: 'assets/toucan.png',
      description: 'A Toucan',
      tier: 'Rare',
      obtainingMethod: 'Rare Summer Egg',
      hatchChance: '25%',
      passive:
          'Tropical Lover: Makes all nearby Tropical type plants have increased variant chance and grow bigger',
      obtainable: 'Yes',
      dateAdded: 'June 21, 2025',
      box: null,
    ),
    PetInfo(
      name: 'Sea Turtle',
      image: 'assets/sea turtle.png',
      detailImage: 'assets/sea turtle.png',
      description: 'A Sea Turtle',
      tier: 'Rare',
      obtainingMethod: 'Rare Summer Egg',
      hatchChance: '20%',
      passive:
          'Shell Share: Occasionally shares its wisdom to a random active pet granting bonus experience & Water Splash: Occasionally has a chance to Wet a nearby fruit',
      obtainable: 'Yes',
      dateAdded: 'June 21, 2025',
      box: null,
    ),
    PetInfo(
      name: 'Orangutan',
      image: 'assets/orangutan.png',
      detailImage: 'assets/orangutan.png',
      description: 'An Orangutan',
      tier: 'Rare',
      obtainingMethod: 'Rare Summer Egg',
      hatchChance: '15%',
      passive:
          'Helping Hands: When crafting, each material has a chance for it not to be consumed',
      obtainable: 'Yes',
      dateAdded: 'June 21, 2025',
      box: null,
    ),
    PetInfo(
      name: 'Seal',
      image: 'assets/seal.png',
      detailImage: 'assets/seal.png',
      description: 'A Seal',
      tier: 'Rare',
      obtainingMethod: 'Rare Summer Egg',
      hatchChance: '10%',
      passive:
          'Seal the Deal: When selling pets, has a 2.42% chance to get the pet back as its egg equivalent',
      obtainable: 'Yes',
      dateAdded: 'June 21, 2025',
      box: null,
      hunger: '17,000',
    ),
    PetInfo(
      name: 'Honey Bee',
      image: 'assets/honey bee.png',
      detailImage: 'assets/honey bee.png',
      description: 'The Honey Bee.',
      tier: 'Rare',
      obtainingMethod: 'Bee Egg',
      hatchChance: '25%',
      passive:
          'Every ~20m, flies to a nearby fruit and pollinates it, applying the Pollinated mutation. (The time is reduced when the pet is leveled up)',
      obtainable: 'Yes',
      dateAdded: 'May 31, 2025',
      box: null,
      hunger: '25,000',
    ),
    PetInfo(
      name: 'Wasp',
      image: 'assets/wasp.png',
      detailImage: 'assets/wasp.png',
      description: 'The Wasp.',
      tier: 'Rare',
      obtainingMethod: 'Anti Bee Egg',
      hatchChance: '55%',
      passive:
          'Every 30m, the Wasp flies to a nearby fruit and pollinates it, applying the Pollinated mutation. Every 10m, the Wasp stings a random pet and advances its ability cooldown by 60s.',
      obtainable: 'Yes',
      dateAdded: 'June 7th, 2025',
      box: null,
    ),
    PetInfo(
      name: 'Disco Bee',
      image: 'assets/disco bee.png',
      detailImage: 'assets/disco bee.png',
      description: 'The Disco Bee.',
      tier: 'Divine',
      obtainingMethod: 'Anti Bee Egg',
      hatchChance: '0.25%',
      passive: 'Every ~13m, ~22% chance a nearby fruit becomes Disco',
      obtainable: 'Yes',
      dateAdded: 'June 7th, 2025',
      box: null,
      hunger: '25,000',
    ),
    PetInfo(
      name: 'Raccoon',
      image: 'assets/raccoon.png',
      detailImage: 'assets/raccoon.png',
      description: 'The Raccoon.',
      tier: 'Divine',
      obtainingMethod: 'Night Egg',
      hatchChance: 'Night Egg 0.1%\nExotic Night Egg 1%',
      passive:
          'Every ~15 minutes, goes to another player\'s plot and steals (duplicate) a random crop and gives it to the player!',
      obtainable: 'Yes',
      dateAdded: 'May 10, 2025',
      box: null,
      hunger: '45,000',
    ),
    PetInfo(
      name: 'Dragonfly',
      image: 'assets/dragonfly.png',
      detailImage: 'assets/dragonfly.png',
      description: 'The Dragonfly.',
      tier: 'Divine',
      obtainingMethod: 'Bug Egg',
      hatchChance: '1%',
      passive:
          'Transmutation: Every ~5 minutes, one random crop will turn gold.',
      obtainable: 'Yes',
      dateAdded: 'May 3, 2025',
      box: null,
      hunger: '100,000',
    ),
    PetInfo(
      name: 'Night Owl',
      image: 'assets/night owl.png',
      detailImage: 'assets/night owl.png',
      description: 'The Night Owl.',
      tier: 'Divine',
      obtainingMethod: 'Night Egg',
      hatchChance: '4%',
      passive: 'All active pets gain an additional <0.23 XP per second.',
      obtainable: 'Yes',
      dateAdded: 'May 10th, 2025',
      box: null,
      hunger: '50,000',
    ),
  ];

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
                        children: List.generate(
                            pageCount,
                            (i) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: _petPage == i
                                          ? const Color(0xFF4CAF50)
                                          : Colors.grey[700],
                                      minimumSize: const Size(36, 36),
                                      padding: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _petPage = i;
                                      });
                                    },
                                    child: Text(
                                      "${i + 1}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                )),
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
      builder: (_) => Dialog(
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

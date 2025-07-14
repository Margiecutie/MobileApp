import 'package:flutter/material.dart';
import 'main.dart';
import 'pets_data.dart';

class EggHatchingGuidePage extends StatefulWidget {
  final List<PetInfo> pets;
  const EggHatchingGuidePage({super.key, required this.pets});

  Map<String, List<PetInfo>> _groupPetsByEgg(List<PetInfo> pets) {
    final Map<String, List<PetInfo>> eggMap = {};
    for (final pet in pets) {
      final egg = pet.obtainingMethod;
      if (!eggMap.containsKey(egg)) {
        eggMap[egg] = [];
      }
      eggMap[egg]!.add(pet);
    }
    return eggMap;
  }

  @override
  State<EggHatchingGuidePage> createState() => _EggHatchingGuidePageState();
}

class _EggHatchingGuidePageState extends State<EggHatchingGuidePage> {
  int? _expandedIndex;

  // Map egg names to their image asset filenames
  final Map<String, String> eggImageMap = {
    'Anti Bee Egg': 'assets/Anti Bee Egg.png',
    'Bee Egg': 'assets/Bee Egg.png',
    'Bug Egg': 'assets/Bug Egg.png',
    'Common Egg': 'assets/common.png',
    'Common Summer Egg': 'assets/Common Summer Egg.png',
    'Dinosaur Egg': 'assets/Dinosaur Egg.png',
    'Legendary Egg': 'assets/Legendary Egg.png',
    'Mythical Egg': 'assets/Mythical Egg.png',
    'Night Egg': 'assets/Night Egg.png',
    'Paradise Egg': 'assets/Paradise Egg.png',
    'Rare Egg': 'assets/Rare Egg.png',
    'Uncommon Egg': 'assets/Uncommon Egg.png',
    'Rare Summer Egg': 'assets/Rare Summer Egg.png',
  };

  Map<String, List<PetInfo>> _groupPetsByEgg(List<PetInfo> pets) {
    final Map<String, List<PetInfo>> eggMap = {};
    for (final pet in pets) {
      final egg = pet.obtainingMethod;
      if (!eggMap.containsKey(egg)) {
        eggMap[egg] = [];
      }
      eggMap[egg]!.add(pet);
    }
    return eggMap;
  }

  @override
  Widget build(BuildContext context) {
    final eggMap = _groupPetsByEgg(widget.pets);
    final eggTypes = eggMap.keys.toList()..sort();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4CAF50),
        title: const Text('Egg & Hatching Guide',
            style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color(0xFF1A1A2E),
      body: ListView.builder(
        itemCount: eggTypes.length,
        itemBuilder: (context, i) {
          final egg = eggTypes[i];
          final eggPets = eggMap[egg]!;
          final imagePath = eggImageMap[egg] ??
              'assets/eggs/' + egg.toLowerCase().replaceAll(' ', '_') + '.png';

          // Add a short, lively description for Common Egg
          if (egg == 'Common Egg') {
            return Card(
              color: const Color(0xFF234022),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: const BorderSide(
                  color: Color(0xFF4CAF50),
                  width: 2,
                ),
              ),
              child: ExpansionTile(
                key: Key(egg),
                iconColor: Colors.white,
                collapsedIconColor: Colors.white,
                title: Row(
                  children: [
                    Image.asset(
                      imagePath,
                      width: 32,
                      height: 32,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error, color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      egg,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ],
                ),
                initiallyExpanded: _expandedIndex == i,
                onExpansionChanged: (expanded) {
                  setState(() {
                    _expandedIndex = expanded ? i : null;
                  });
                },
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green.shade900.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          const Icon(Icons.info_outline,
                              color: Colors.white70, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Always in the Pet Shop for 50,000 coins or 19 Robux. Hatches in 10 minutes—super easy and always available!',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontStyle: FontStyle.italic,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ...eggPets.map((pet) => ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            pet.image,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                            errorBuilder: (c, e, s) =>
                                const Icon(Icons.error, color: Colors.white),
                          ),
                        ),
                        title: Text(pet.name,
                            style: const TextStyle(color: Colors.white)),
                        subtitle: Text('Hatch Chance: ${pet.hatchChance}',
                            style: const TextStyle(color: Colors.white70)),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green.shade700,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            pet.tier,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                        ),
                      ))
                ],
              ),
            );
          }

          // Mythical Egg description
          if (egg == 'Mythical Egg') {
            return Card(
              color: const Color(0xFF234022),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: const BorderSide(
                  color: Color(0xFF4CAF50),
                  width: 2,
                ),
              ),
              child: ExpansionTile(
                key: Key(egg),
                iconColor: Colors.white,
                collapsedIconColor: Colors.white,
                title: Row(
                  children: [
                    Image.asset(
                      imagePath,
                      width: 32,
                      height: 32,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error, color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      egg,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ],
                ),
                initiallyExpanded: _expandedIndex == i,
                onExpansionChanged: (expanded) {
                  setState(() {
                    _expandedIndex = expanded ? i : null;
                  });
                },
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green.shade900.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          const Icon(Icons.info_outline,
                              color: Colors.white70, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Added in the Blood Moon Event! Buy for 8,000,000 coins or 119 Robux.',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontStyle: FontStyle.italic,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ...eggPets.map((pet) => ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            pet.image,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                            errorBuilder: (c, e, s) =>
                                const Icon(Icons.error, color: Colors.white),
                          ),
                        ),
                        title: Text(pet.name,
                            style: const TextStyle(color: Colors.white)),
                        subtitle: Text('Hatch Chance: ${pet.hatchChance}',
                            style: const TextStyle(color: Colors.white70)),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green.shade700,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            pet.tier,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                        ),
                      ))
                ],
              ),
            );
          }

          // Bug Egg description
          if (egg == 'Bug Egg') {
            return Card(
              color: const Color(0xFF234022),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: const BorderSide(
                  color: Color(0xFF4CAF50),
                  width: 2,
                ),
              ),
              child: ExpansionTile(
                key: Key(egg),
                iconColor: Colors.white,
                collapsedIconColor: Colors.white,
                title: Row(
                  children: [
                    Image.asset(
                      imagePath,
                      width: 32,
                      height: 32,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error, color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      egg,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ],
                ),
                initiallyExpanded: _expandedIndex == i,
                onExpansionChanged: (expanded) {
                  setState(() {
                    _expandedIndex = expanded ? i : null;
                  });
                },
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green.shade900.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          const Icon(Icons.info_outline,
                              color: Colors.white70, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Costs 50,000,000 coins, hatches in 8 hours. Only a 3% chance to appear in stock!',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontStyle: FontStyle.italic,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ...eggPets.map((pet) => ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            pet.image,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                            errorBuilder: (c, e, s) =>
                                const Icon(Icons.error, color: Colors.white),
                          ),
                        ),
                        title: Text(pet.name,
                            style: const TextStyle(color: Colors.white)),
                        subtitle: Text('Hatch Chance: ${pet.hatchChance}',
                            style: const TextStyle(color: Colors.white70)),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green.shade700,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            pet.tier,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                        ),
                      ))
                ],
              ),
            );
          }

          // Common Summer Egg description
          if (egg == 'Common Summer Egg') {
            return Card(
              color: const Color(0xFF234022),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: const BorderSide(
                  color: Color(0xFF4CAF50),
                  width: 2,
                ),
              ),
              child: ExpansionTile(
                key: Key(egg),
                iconColor: Colors.white,
                collapsedIconColor: Colors.white,
                title: Row(
                  children: [
                    Image.asset(
                      imagePath,
                      width: 32,
                      height: 32,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error, color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      egg,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ],
                ),
                initiallyExpanded: _expandedIndex == i,
                onExpansionChanged: (expanded) {
                  setState(() {
                    _expandedIndex = expanded ? i : null;
                  });
                },
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green.shade900.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          const Icon(Icons.info_outline,
                              color: Colors.white70, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'From the Summer Harvest Event! Buy for 1,000,000 coins or 29 Robux.',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontStyle: FontStyle.italic,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ...eggPets.map((pet) => ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            pet.image,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                            errorBuilder: (c, e, s) =>
                                const Icon(Icons.error, color: Colors.white),
                          ),
                        ),
                        title: Text(pet.name,
                            style: const TextStyle(color: Colors.white)),
                        subtitle: Text('Hatch Chance: ${pet.hatchChance}',
                            style: const TextStyle(color: Colors.white70)),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green.shade700,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            pet.tier,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                        ),
                      ))
                ],
              ),
            );
          }

          // Rare Summer Egg description
          if (egg == 'Rare Summer Egg') {
            return Card(
              color: const Color(0xFF234022),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: const BorderSide(
                  color: Color(0xFF4CAF50),
                  width: 2,
                ),
              ),
              child: ExpansionTile(
                key: Key(egg),
                iconColor: Colors.white,
                collapsedIconColor: Colors.white,
                title: Row(
                  children: [
                    Image.asset(
                      imagePath,
                      width: 32,
                      height: 32,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error, color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      egg,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ],
                ),
                initiallyExpanded: _expandedIndex == i,
                onExpansionChanged: (expanded) {
                  setState(() {
                    _expandedIndex = expanded ? i : null;
                  });
                },
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green.shade900.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          const Icon(Icons.info_outline,
                              color: Colors.white70, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Added in the Summer Harvest Event! Buy for 25,000,000 coins or 99 Robux.',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontStyle: FontStyle.italic,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ...eggPets.map((pet) => ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            pet.image,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                            errorBuilder: (c, e, s) =>
                                const Icon(Icons.error, color: Colors.white),
                          ),
                        ),
                        title: Text(pet.name,
                            style: const TextStyle(color: Colors.white)),
                        subtitle: Text('Hatch Chance: ${pet.hatchChance}',
                            style: const TextStyle(color: Colors.white70)),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green.shade700,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            pet.tier,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                        ),
                      ))
                ],
              ),
            );
          }

          // Paradise Egg description
          if (egg == 'Paradise Egg') {
            return Card(
              color: const Color(0xFF234022),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: const BorderSide(
                  color: Color(0xFF4CAF50),
                  width: 2,
                ),
              ),
              child: ExpansionTile(
                key: Key(egg),
                iconColor: Colors.white,
                collapsedIconColor: Colors.white,
                title: Row(
                  children: [
                    Image.asset(
                      imagePath,
                      width: 32,
                      height: 32,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error, color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      egg,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ],
                ),
                initiallyExpanded: _expandedIndex == i,
                onExpansionChanged: (expanded) {
                  setState(() {
                    _expandedIndex = expanded ? i : null;
                  });
                },
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green.shade900.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          const Icon(Icons.info_outline,
                              color: Colors.white70, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'From the Summer Harvest Event! Buy for 50,000,000 coins or 139 Robux.',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontStyle: FontStyle.italic,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ...eggPets.map((pet) => ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            pet.image,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                            errorBuilder: (c, e, s) =>
                                const Icon(Icons.error, color: Colors.white),
                          ),
                        ),
                        title: Text(pet.name,
                            style: const TextStyle(color: Colors.white)),
                        subtitle: Text('Hatch Chance: ${pet.hatchChance}',
                            style: const TextStyle(color: Colors.white70)),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green.shade700,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            pet.tier,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                        ),
                      ))
                ],
              ),
            );
          }

          // Bee Egg description
          if (egg == 'Bee Egg') {
            return Card(
              color: const Color(0xFF234022),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: const BorderSide(
                  color: Color(0xFF4CAF50),
                  width: 2,
                ),
              ),
              child: ExpansionTile(
                key: Key(egg),
                iconColor: Colors.white,
                collapsedIconColor: Colors.white,
                title: Row(
                  children: [
                    Image.asset(
                      imagePath,
                      width: 32,
                      height: 32,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error, color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      egg,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ],
                ),
                initiallyExpanded: _expandedIndex == i,
                onExpansionChanged: (expanded) {
                  setState(() {
                    _expandedIndex = expanded ? i : null;
                  });
                },
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green.shade900.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          const Icon(Icons.info_outline,
                              color: Colors.white70, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Available in the Pet Eggs Shop for 30,000,000 coins or 129 Robux.',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontStyle: FontStyle.italic,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ...eggPets.map((pet) => ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            pet.image,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                            errorBuilder: (c, e, s) =>
                                const Icon(Icons.error, color: Colors.white),
                          ),
                        ),
                        title: Text(pet.name,
                            style: const TextStyle(color: Colors.white)),
                        subtitle: Text('Hatch Chance: ${pet.hatchChance}',
                            style: const TextStyle(color: Colors.white70)),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green.shade700,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            pet.tier,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                        ),
                      ))
                ],
              ),
            );
          }

          // Dinosaur Egg description
          if (egg == 'Dinosaur Egg') {
            return Card(
              color: const Color(0xFF234022),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: const BorderSide(
                  color: Color(0xFF4CAF50),
                  width: 2,
                ),
              ),
              child: ExpansionTile(
                key: Key(egg),
                iconColor: Colors.white,
                collapsedIconColor: Colors.white,
                title: Row(
                  children: [
                    Image.asset(
                      imagePath,
                      width: 32,
                      height: 32,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error, color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      egg,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ],
                ),
                initiallyExpanded: _expandedIndex == i,
                onExpansionChanged: (expanded) {
                  setState(() {
                    _expandedIndex = expanded ? i : null;
                  });
                },
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green.shade900.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          const Icon(Icons.info_outline,
                              color: Colors.white70, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'From Update 1.13 and the Prehistoric Event! Previously in the Summer Shop for 10 Robux or 149 for a Premium Oasis Egg.',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontStyle: FontStyle.italic,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ...eggPets.map((pet) => ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            pet.image,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                            errorBuilder: (c, e, s) =>
                                const Icon(Icons.error, color: Colors.white),
                          ),
                        ),
                        title: Text(pet.name,
                            style: const TextStyle(color: Colors.white)),
                        subtitle: Text('Hatch Chance: ${pet.hatchChance}',
                            style: const TextStyle(color: Colors.white70)),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green.shade700,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            pet.tier,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                        ),
                      ))
                ],
              ),
            );
          }

          // Anti Bee Egg description
          if (egg == 'Anti Bee Egg') {
            return Card(
              color: const Color(0xFF234022),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: const BorderSide(
                  color: Color(0xFF4CAF50),
                  width: 2,
                ),
              ),
              child: ExpansionTile(
                key: Key(egg),
                iconColor: Colors.white,
                collapsedIconColor: Colors.white,
                title: Row(
                  children: [
                    Image.asset(
                      imagePath,
                      width: 32,
                      height: 32,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error, color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      egg,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ],
                ),
                initiallyExpanded: _expandedIndex == i,
                onExpansionChanged: (expanded) {
                  setState(() {
                    _expandedIndex = expanded ? i : null;
                  });
                },
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green.shade900.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          const Icon(Icons.info_outline,
                              color: Colors.white70, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Craftable at the Cosmetics / Crafting Stand!',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontStyle: FontStyle.italic,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ...eggPets.map((pet) => ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            pet.image,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                            errorBuilder: (c, e, s) =>
                                const Icon(Icons.error, color: Colors.white),
                          ),
                        ),
                        title: Text(pet.name,
                            style: const TextStyle(color: Colors.white)),
                        subtitle: Text('Hatch Chance: ${pet.hatchChance}',
                            style: const TextStyle(color: Colors.white70)),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green.shade700,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            pet.tier,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                        ),
                      ))
                ],
              ),
            );
          }

          // Night Egg description
          if (egg == 'Night Egg') {
            return Card(
              color: const Color(0xFF234022),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: const BorderSide(
                  color: Color(0xFF4CAF50),
                  width: 2,
                ),
              ),
              child: ExpansionTile(
                key: Key(egg),
                iconColor: Colors.white,
                collapsedIconColor: Colors.white,
                title: Row(
                  children: [
                    Image.asset(
                      imagePath,
                      width: 32,
                      height: 32,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error, color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      egg,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ],
                ),
                initiallyExpanded: _expandedIndex == i,
                onExpansionChanged: (expanded) {
                  setState(() {
                    _expandedIndex = expanded ? i : null;
                  });
                },
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green.shade900.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          const Icon(Icons.info_outline,
                              color: Colors.white70, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Limited-time! Introduced during the Lunar Glow Event.',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontStyle: FontStyle.italic,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ...eggPets.map((pet) => ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            pet.image,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                            errorBuilder: (c, e, s) =>
                                const Icon(Icons.error, color: Colors.white),
                          ),
                        ),
                        title: Text(pet.name,
                            style: const TextStyle(color: Colors.white)),
                        subtitle: Text('Hatch Chance: ${pet.hatchChance}',
                            style: const TextStyle(color: Colors.white70)),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green.shade700,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            pet.tier,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                        ),
                      ))
                ],
              ),
            );
          }

          // Rare Egg description
          if (egg == 'Rare Egg') {
            return Card(
              color: const Color(0xFF234022),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: const BorderSide(
                  color: Color(0xFF4CAF50),
                  width: 2,
                ),
              ),
              child: ExpansionTile(
                key: Key(egg),
                iconColor: Colors.white,
                collapsedIconColor: Colors.white,
                title: Row(
                  children: [
                    Image.asset(
                      imagePath,
                      width: 32,
                      height: 32,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error, color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      egg,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ],
                ),
                initiallyExpanded: _expandedIndex == i,
                onExpansionChanged: (expanded) {
                  setState(() {
                    _expandedIndex = expanded ? i : null;
                  });
                },
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green.shade900.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          const Icon(Icons.info_outline,
                              color: Colors.white70, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Buy for 600,000 coins or 89 Robux. 24% chance to appear, hatches in 2 hours!',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontStyle: FontStyle.italic,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ...eggPets.map((pet) => ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            pet.image,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                            errorBuilder: (c, e, s) =>
                                const Icon(Icons.error, color: Colors.white),
                          ),
                        ),
                        title: Text(pet.name,
                            style: const TextStyle(color: Colors.white)),
                        subtitle: Text('Hatch Chance: ${pet.hatchChance}',
                            style: const TextStyle(color: Colors.white70)),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green.shade700,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            pet.tier,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                        ),
                      ))
                ],
              ),
            );
          }

          // Uncommon Egg description
          if (egg == 'Uncommon Egg') {
            return Card(
              color: const Color(0xFF234022),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: const BorderSide(
                  color: Color(0xFF4CAF50),
                  width: 2,
                ),
              ),
              child: ExpansionTile(
                key: Key(egg),
                iconColor: Colors.white,
                collapsedIconColor: Colors.white,
                title: Row(
                  children: [
                    Image.asset(
                      imagePath,
                      width: 32,
                      height: 32,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error, color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      egg,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ],
                ),
                initiallyExpanded: _expandedIndex == i,
                onExpansionChanged: (expanded) {
                  setState(() {
                    _expandedIndex = expanded ? i : null;
                  });
                },
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green.shade900.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          const Icon(Icons.info_outline,
                              color: Colors.white70, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Released in the Pet Update! Buy for 150,000 coins or 39 Robux.',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontStyle: FontStyle.italic,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ...eggPets.map((pet) => ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            pet.image,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                            errorBuilder: (c, e, s) =>
                                const Icon(Icons.error, color: Colors.white),
                          ),
                        ),
                        title: Text(pet.name,
                            style: const TextStyle(color: Colors.white)),
                        subtitle: Text('Hatch Chance: ${pet.hatchChance}',
                            style: const TextStyle(color: Colors.white70)),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green.shade700,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            pet.tier,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                        ),
                      ))
                ],
              ),
            );
          }

          // Legendary Egg description
          if (egg == 'Legendary Egg') {
            return Card(
              color: const Color(0xFF234022),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: const BorderSide(
                  color: Color(0xFF4CAF50),
                  width: 2,
                ),
              ),
              child: ExpansionTile(
                key: Key(egg),
                iconColor: Colors.white,
                collapsedIconColor: Colors.white,
                title: Row(
                  children: [
                    Image.asset(
                      imagePath,
                      width: 32,
                      height: 32,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error, color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      egg,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ],
                ),
                initiallyExpanded: _expandedIndex == i,
                onExpansionChanged: (expanded) {
                  setState(() {
                    _expandedIndex = expanded ? i : null;
                  });
                },
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green.shade900.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          const Icon(Icons.info_outline,
                              color: Colors.white70, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Buy for 3,000,000 coins or 129 Robux in the Pet Eggs shop.',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontStyle: FontStyle.italic,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ...eggPets.map((pet) => ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            pet.image,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                            errorBuilder: (c, e, s) =>
                                const Icon(Icons.error, color: Colors.white),
                          ),
                        ),
                        title: Text(pet.name,
                            style: const TextStyle(color: Colors.white)),
                        subtitle: Text('Hatch Chance: ${pet.hatchChance}',
                            style: const TextStyle(color: Colors.white70)),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green.shade700,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            pet.tier,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                        ),
                      ))
                ],
              ),
            );
          }

          // Default return for other eggs
          return Card(
            color: const Color(0xFF234022),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: const BorderSide(
                color: Color(0xFF4CAF50),
                width: 2,
              ),
            ),
            child: ExpansionTile(
              key: Key(egg),
              iconColor: Colors.white,
              collapsedIconColor: Colors.white,
              title: Row(
                children: [
                  Image.asset(
                    imagePath,
                    width: 32,
                    height: 32,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error, color: Colors.white),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    egg,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                ],
              ),
              initiallyExpanded: _expandedIndex == i,
              onExpansionChanged: (expanded) {
                setState(() {
                  _expandedIndex = expanded ? i : null;
                });
              },
              children: eggPets
                  .map((pet) => ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            pet.image,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                            errorBuilder: (c, e, s) =>
                                const Icon(Icons.error, color: Colors.white),
                          ),
                        ),
                        title: Text(pet.name,
                            style: const TextStyle(color: Colors.white)),
                        subtitle: Text('Hatch Chance: ${pet.hatchChance}',
                            style: const TextStyle(color: Colors.white70)),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green.shade700,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            pet.tier,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'main.dart';

class EggHatchingGuidePage extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final eggMap = _groupPetsByEgg(pets);
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
              iconColor: Colors.white,
              collapsedIconColor: Colors.white,
              title: Text(
                egg,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              ),
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

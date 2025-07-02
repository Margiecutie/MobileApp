import 'package:flutter/material.dart';
import 'main.dart'; // For PetInfo

class FavoritePetPage extends StatefulWidget {
  final List<PetInfo> pets;
  const FavoritePetPage({super.key, required this.pets});

  @override
  State<FavoritePetPage> createState() => _FavoritePetPageState();
}

class _FavoritePetPageState extends State<FavoritePetPage> {
  final Set<int> _favoriteIndexes = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4CAF50),
        title:
            const Text('Favorite Pets', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color(0xFF1A1A2E),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.85,
          ),
          itemCount: widget.pets.length,
          itemBuilder: (context, i) {
            final pet = widget.pets[i];
            final isFavorite = _favoriteIndexes.contains(i);
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isFavorite) {
                    _favoriteIndexes.remove(i);
                  } else {
                    _favoriteIndexes.add(i);
                  }
                });
              },
              child: Card(
                color: isFavorite
                    ? const Color(0xFF234022)
                    : const Color(0xFF2E2E48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: isFavorite
                      ? const BorderSide(color: Colors.redAccent, width: 2)
                      : BorderSide.none,
                ),
                elevation: isFavorite ? 6 : 2,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              pet.image,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                              errorBuilder: (c, e, s) =>
                                  const Icon(Icons.error, color: Colors.white),
                            ),
                          ),
                          Positioned(
                            top: 4,
                            right: 4,
                            child: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorite
                                  ? Colors.redAccent
                                  : Colors.white54,
                              size: 28,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        pet.name,
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
                          color: Colors.green.shade700,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          pet.tier,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

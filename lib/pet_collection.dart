import 'package:flutter/material.dart';
import 'main.dart'; // For PetInfo

class PetCollectionProgressPage extends StatefulWidget {
  final List<PetInfo> pets;
  final Set<int> collectedIndexes;
  final void Function(Set<int>) onCollectionChanged;
  const PetCollectionProgressPage({
    super.key,
    required this.pets,
    required this.collectedIndexes,
    required this.onCollectionChanged,
  });

  @override
  State<PetCollectionProgressPage> createState() =>
      _PetCollectionProgressPageState();
}

class _PetCollectionProgressPageState extends State<PetCollectionProgressPage> {
  late Set<int> _collected;

  @override
  void initState() {
    super.initState();
    _collected = Set<int>.from(widget.collectedIndexes);
  }

  @override
  Widget build(BuildContext context) {
    final collectedCount = _collected.length;
    final totalCount = widget.pets.length;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4CAF50),
        title: const Text('Pet Collection Progress',
            style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Collected $collectedCount of $totalCount pets',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: collectedCount / totalCount,
                  backgroundColor: Colors.white24,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4CAF50)),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.pets.length,
              itemBuilder: (context, i) {
                final pet = widget.pets[i];
                final collected = _collected.contains(i);
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      pet.image,
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                      errorBuilder: (c, e, s) =>
                          const Icon(Icons.error, color: Colors.white),
                    ),
                  ),
                  title: Text(pet.name,
                      style: const TextStyle(color: Colors.white)),
                  subtitle: Text(pet.tier,
                      style: const TextStyle(color: Colors.white70)),
                  trailing: Checkbox(
                    value: collected,
                    onChanged: (val) {
                      setState(() {
                        if (val == true) {
                          _collected.add(i);
                        } else {
                          _collected.remove(i);
                        }
                        widget.onCollectionChanged(_collected);
                      });
                    },
                    activeColor: Color(0xFF4CAF50),
                  ),
                  tileColor: collected ? Color(0xFF234022) : Colors.transparent,
                  shape: const RoundedRectangleBorder(),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                );
              },
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFF1A1A2E),
    );
  }
}

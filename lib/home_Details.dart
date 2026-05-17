import 'package:flutter/material.dart';
import 'package:recipe_book/global_variable.dart';
import 'package:recipe_book/item_details.dart';

class HomeDetails extends StatefulWidget {
  const HomeDetails({super.key});

  @override
  State<HomeDetails> createState() => _HomeDetailsState();
}

class _HomeDetailsState extends State<HomeDetails> {
  final List<String> categories = [
    'All',
    'Pastries',
    'Breads',
    'Cookies',
    'Cakes',
    'Pies & Tarts',
    'Cupcakes',
    'Beverages'
  ];
  late String selectedCategory;
  String search = '';
  String lowerCase = '';

  @override
  void initState() {
    super.initState();
    selectedCategory = categories[0];
  }

  List<Map<String, Object>> get filteredRecipe {
    List<Map<String, Object>> recipesByCat;
    if (selectedCategory == 'All') {
      recipesByCat = allRecipes;
    }
    else {
      recipesByCat = allRecipes
          .where((recipe) => recipe['category'] == selectedCategory)
          .toList();
    }
    if(search.isEmpty) {
      return recipesByCat;
    }
    else {
      final lowerCase=search.toLowerCase();
            return recipesByCat.where((recipe) {
              final recipeTitle = recipe['title']?.toString().toLowerCase() ?? ''; // Handles potential null or non-String titles
              return recipeTitle.contains(lowerCase);
            }).toList();

    }
  }

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black),
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(50),
        right: Radius.circular(50),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Welcome to Sweet Crumbs',
          style: TextStyle(
            color: Colors.blueGrey,
            fontSize: 34,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: ()
        {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                onChanged: (value)
                {
                  setState(() {
                    search=value;
                  });
                },
                decoration: InputDecoration(
                  hintText: "Search for Recipe",
                  hintStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  prefixIcon: const Icon(Icons.search),
                  border: border,
                  focusedBorder: border,
                  enabledBorder: border,
                ),
              ),
            ),
            SizedBox(
              height: 60,
              child: ListView.builder(
                itemCount: categories.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: ChoiceChip(
                      selectedColor: selectedCategory == category &&
                          index % 2 == 0
                          ? const Color.fromRGBO(255, 205, 210, 1)
                          : const Color.fromRGBO(159, 177, 146, 1),
                      side: const BorderSide(
                        color: Color.fromRGBO(245, 247, 249, 1),
                      ),
                      label: Text(category),
                      selected: selectedCategory == category,
                      onSelected: (_) {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                      labelStyle: const TextStyle(fontSize: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 1080) {
                    return GridView.builder(
                      itemCount: filteredRecipe.length,
                      padding: const EdgeInsets.all(10),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.15,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                      ),
                      itemBuilder: (context, index) {
                        final recipe = filteredRecipe[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) {
                                  return ItemDetails(recipe: recipe);
                                }
                                )
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            //height: 1500,
                            decoration: BoxDecoration(
                              color: index % 2 == 0
                                  ? const Color.fromRGBO(255, 205, 210, 1)
                                  : const Color.fromRGBO(159, 177, 146, 1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (recipe['imageUrl'] != null)
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.asset(
                                        recipe['imageUrl'].toString(),
                                        height: 450,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                const SizedBox(height: 10),
                                Text(
                                  recipe['title'].toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Time: ${recipe['time'].toString()}',
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return ListView.builder(
                      itemCount: filteredRecipe.length,
                      itemBuilder: (context, index) {
                        final recipe = filteredRecipe[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) {
                                  return ItemDetails(recipe: recipe);
                                }));
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 15,
                            ),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: index % 2 == 0
                                  ? const Color.fromRGBO(255, 205, 210, 1)
                                  : const Color.fromRGBO(159, 177, 146, 1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                           // height: 800,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (recipe['imageUrl'] != null)
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.asset(
                                        recipe['imageUrl'].toString(),
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                const SizedBox(height: 10),
                                Text(
                                  recipe['title'].toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Time: ${recipe['time'].toString()}',
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
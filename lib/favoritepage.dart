import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book/favproviders.dart';
import 'package:recipe_book/item_details.dart';

class Favoritepage extends StatefulWidget {
  const Favoritepage({super.key});

  @override
  State<Favoritepage> createState() => _FavoritepageState();
}

class _FavoritepageState extends State<Favoritepage> {
  @override
  Widget build(BuildContext context) {
    final fav=context.watch<Favproviders>().fav;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(159, 177, 146, 1),
        title: Text('Favorites',style: TextStyle(
          fontSize: 34,fontWeight: FontWeight.bold,
          color: Color.fromRGBO(255, 210, 205, 1)
        ),),
        leading: Icon(Icons.favorite, color: Colors.redAccent,),
      ),
      body:
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 1080) {
                    return GridView.builder(
                      itemCount: fav.length,
                      padding: const EdgeInsets.all(10),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.65,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                      ),
                      itemBuilder: (context, index) {
                        final favo = fav[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder:(context){
                                return ItemDetails(recipe: favo);
                              }
                              )
                              );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: index % 2 == 0
                                  ? const Color.fromRGBO(255, 205, 210, 1)
                                  : const Color.fromRGBO(159, 177, 146, 1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            //height: 638,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (favo['imageUrl'] != null)
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.asset(
                                        favo['imageUrl'].toString(),
                                        //height: 300,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                const SizedBox(height: 10),
                                Text(
                                  favo['title'].toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Time: ${favo['time'].toString()}',
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
                      itemCount: fav.length,
                      itemBuilder: (context, index) {
                        final favo = fav[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder:(context){
                                return ItemDetails(recipe: favo);
                              }
                              )
                              );
                          },
                          child:Container(
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
                            //height: 800,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (favo['imageUrl'] != null)
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.asset(
                                        favo['imageUrl'].toString(),
                                       // height: 700,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                const SizedBox(height: 10),
                                Text(
                                  favo['title'].toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Time: ${favo['time'].toString()}',
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          )
                        );
                        //);
                      },
                    );
                  }
                },
              ),
            ),
    );
  }
}

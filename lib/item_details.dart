import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book/favproviders.dart';
class ItemDetails extends StatefulWidget {
  final Map<String,Object> recipe;
  const ItemDetails({super.key,
  required this.recipe});

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
   
  @override
  Widget build(BuildContext context) {
  final favProvider = Provider.of<Favproviders>(context);
  final isfav = favProvider.fav.contains(widget.recipe);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(widget.recipe['imageUrl'].toString(),
              width: double.infinity,
              fit: BoxFit.cover,
              ),
            )
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Expanded(
                  child: Text(widget.recipe['title'].toString(),style: TextStyle(
                      fontSize: 35,fontWeight: FontWeight.w900
                  ),),
                ),
                  IconButton(
                    onPressed: (){
                      if(isfav==false){
                        Provider.of<Favproviders>
                        (context,listen: false).addFav(
                          widget.recipe
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Recipe added to Favorites!'))
                        );
                      }
                      
                      else{
                        Provider.of<Favproviders>(context,listen: false).removeFav(
                          widget.recipe
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Recipe removed from Favorites!'))
                        );
                      }
                    }, 
                    icon: Icon(Icons.favorite_outlined,
                    color: isfav?Colors.redAccent:Colors.grey,)
                  )
              ]),
            ),
            SizedBox(height: 12,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                spacing: 9,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Chip(backgroundColor: Color.fromRGBO(157, 177, 146, 1),label: Text(widget.recipe['time'].toString(),
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                )
                ),
                  Chip(backgroundColor: Color.fromRGBO(157, 177, 146, 1),label: Text(widget.recipe['level'].toString(),
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                  )
                  ),]
              ),
            ),

            SizedBox(height:20),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(alignment: Alignment.centerLeft,
                child: Text('INGREDIENTS',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
            ),
            SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  textAlign: TextAlign.start,
                    (widget.recipe['ingredients'] as List<String>).join('\n'),
                ),
              ),
            ),
            SizedBox(height: 20,),
             Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(alignment: Alignment.centerLeft,
                child: Text('PROCEDURE',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
            ),
            SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  textAlign: TextAlign.start,
                    (widget.recipe['steps'] as List<String>).join(''),
                ),
              ),
            ),
          ],
        ),
      ) ,
    );
  }
}

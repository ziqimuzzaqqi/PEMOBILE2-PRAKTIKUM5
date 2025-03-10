import 'package:flutter/material.dart';
import 'package:praktikum_5/models/category_model.dart';
import 'package:praktikum_5/services/api_services.dart';

class FoodCategories extends StatefulWidget {
  const FoodCategories({Key? key}) : super(key: key);

  @override
  State<FoodCategories> createState() => _FoodCategoriesState();
}

class _FoodCategoriesState extends State<FoodCategories> {
  late Future<List<CategoryModel>> _futureCategories;

  @override
  void initState() {
    super.initState();
    _futureCategories = ApiServices.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: FutureBuilder(
        future: _futureCategories,
        builder: FoodCategoriesView,
      ),
    );
  }
}

Widget FoodCategoriesView(
  BuildContext context,
  AsyncSnapshot snapshot,
) {
  if (snapshot.connectionState == ConnectionState.waiting) {
    return CircularProgressIndicator();
  } else if (snapshot.hasError) {
    return Text('Error: ${snapshot.hasError}');
  } else if (!snapshot.hasData) {
    return Text('No data');
  } else {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data.length,
      itemBuilder: (context, index) {
        return Container(
          margin:
              index == 0
                  ? const EdgeInsets.only(left: 16, right: 8, top: 8, bottom: 8)
                  : index == snapshot.data.length - 1
                  ? const EdgeInsets.only(left: 8, right: 16, top: 8, bottom: 8)
                  :EdgeInsets.all(8),
          child: Column(
            children: [
              ClipOval(
                child: Image.network(
                  ApiServices.getAsset(snapshot.data[index].image),
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10),
              Text(snapshot.data[index].name),
            ],
          ),
        );
      },
    );
  }
}

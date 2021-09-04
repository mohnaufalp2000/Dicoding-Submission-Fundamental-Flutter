import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_1/data/api/api_service.dart';
import 'package:submission_1/provider/restaurant_provider.dart';
import 'package:submission_1/ui/categories_page/restaurant_list.dart';

class CategoriesPage extends StatefulWidget {
  static const routeName = '/restaurant_list';
  final String title;

  const CategoriesPage(this.title);

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(24, 24, 24, 12),
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back, color: Colors.black)),
                    SizedBox(
                      width: 12,
                    ),
                    Text(widget.title,
                        style: TextStyle(
                            fontFamily: 'Sansation',
                            fontSize: 24,
                            fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
              SizedBox(
                height: 24,
              ),
              ChangeNotifierProvider<RestaurantProvider>(
                  create: (_) => RestaurantProvider(apiService: ApiService()),
                  child: RestaurantList(title: widget.title),
                  )           
            ],
          ),
        ),
      ),
    );
  }
}

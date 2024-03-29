//import './providers/great_places.dart';
//import './screens/add_place_screen.dart';
import 'package:flutter/material.dart';
import 'package:mona_nasr/screens/iamges.dart';
import 'package:provider/provider.dart';

import './screens/cart_screen.dart';
import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';
import './models/notification.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          
          ChangeNotifierProvider.value(
            value: Products(),
          ),
          
         ChangeNotifierProvider.value(
           value: Orders(),
         ),
         ChangeNotifierProvider.value(
           value: Noti(),
         ),
        //  ChangeNotifierProvider.value(
        //    value: GreatPlaces(),
        //  ),    
        ],
        child: 
          MaterialApp(
            debugShowCheckedModeBanner: false,
              title: 'AdminBoard',
              theme: ThemeData(
                brightness: Brightness.light,
                primarySwatch: Colors.purple,
                accentColor: Colors.deepOrange,
                fontFamily: 'Lato',
              ),
              home:ProductsOverviewScreen(),
              routes: {
                //'/' : (ctx) => UserProductsScreen(),
                ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
              //  CartScreen.routeName: (ctx) => CartScreen(),
                OrdersScreen.routeName: (ctx) => OrdersScreen(),
                UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
                EditProductScreen.routeName: (ctx) => EditProductScreen(),
                ProductsOverviewScreen.name: (ctx) => ProductsOverviewScreen(),
                //AddPlaceScreen.routeName : (ctx) => AddPlaceScreen(),
              }),
        );
  }
}

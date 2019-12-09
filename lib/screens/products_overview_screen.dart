import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../providers/orders.dart';
import './orders_screen.dart';
import '../providers/products.dart';
import '../models/notification.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  static const String name = '/overview';

  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;
  bool _isLoading = true;
  //String _notiNumber;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      // notifications = Provider.of<Orders>(context).notifications;
      Provider.of<Products>(context).fetchData().then((_) {
        Provider.of<Noti>(context).getNotification().then((_) {
          setState(() {
            _isLoading = false;
          });
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              ),
            ],
          ),
          Consumer<Noti>(
            builder: (_, not, ch) => Badge(
              child: ch,
              value: not.notifications.toString(),
            ),
            child: IconButton(
              icon: Icon(
                Icons.notifications,
              ),
              onPressed: () {
                Provider.of<Noti>(context).clearNotification();
                Navigator.of(context).pushNamed(OrdersScreen.routeName);
              },                                  
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ProductsGrid(_showOnlyFavorites),
    );
  }
}

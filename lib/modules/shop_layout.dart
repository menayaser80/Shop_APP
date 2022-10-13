import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:shop_appliction/modules/cubit/bloc.dart';
import 'package:shop_appliction/modules/cubit/states.dart';
import 'package:shop_appliction/modules/map.dart';
import 'package:shop_appliction/modules/search/search%20screen.dart';
import 'package:shop_appliction/shared/reusable%20components.dart';
class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,Shopstates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Salla',
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.location_on),
                onPressed: () async {
                  Navigator.push(context, MaterialPageRoute(
                    builder:(context)=>Archized(),
                  ));
                  Location x=new Location();
                  dynamic y=await x.getLocation();
                  double a=y.latitude;
                  double b=y.longitude;
                  print("خط الطول"+b.toString());
                  print("خط العرض"+a.toString());
                },
              ),
              IconButton(
                onPressed: (){
                  navigateTo(context, ShopSearchScreen(),);
                },
                icon:Icon(Icons.search,),
              ),
            ],
          ),
          body:cubit.BottomScreens[cubit.currentindex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index)
            {
              cubit.changebottom(index);
            },
            currentIndex: cubit.currentindex,
            items: [
              BottomNavigationBarItem(icon: Icon(
                Icons.home,
              ),
                label: 'Home',
              ),
              BottomNavigationBarItem(icon: Icon(
                Icons.apps,
              ),
                label: 'Categories',
              ),
              BottomNavigationBarItem(icon: Icon(
                Icons.favorite,
              ),
                label: 'favorites',
              ),
              BottomNavigationBarItem(icon: Icon(
                Icons.settings,
              ),
                label: 'settings',
              ),
            ],
          ),


        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_appliction/models/categories%20model.dart';
import 'package:shop_appliction/modules/cubit/bloc.dart';
import 'package:shop_appliction/modules/cubit/states.dart';
import 'package:shop_appliction/shared/reusable%20components.dart';
class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,Shopstates>(
      listener:(context,state){},
      builder:(context,state)
      {
        return ListView.separated(
          itemBuilder:(context,index)=> BuildCatItem(ShopCubit.get(context).categoriesModel!.data.datamodel[index]),
          separatorBuilder:(context,index)=>myDivider(),
          itemCount:ShopCubit.get(context).categoriesModel!.data.datamodel.length,
        );
      },
    );
  }
  Widget BuildCatItem(DataModel model)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(
          image: NetworkImage(model.image),
          width: 80.0,
          height: 80.0,
          fit: BoxFit.cover,
        ),
        SizedBox(
          width: 20.0,
        ),
        Text(model.name,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        Icon(Icons.arrow_forward_ios,),
      ],
    ),
  );
}

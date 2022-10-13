import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_appliction/modules/cubit/bloc.dart';
import 'package:shop_appliction/modules/cubit/states.dart';
import 'package:shop_appliction/shared/reusable%20components.dart';
class FavouriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, Shopstates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).favouritesModel != null,
          builder: (context) => ConditionalBuilder(condition: ShopCubit
              .get(context)
              .favouritesModel!
              .data!
              .data!.isNotEmpty, builder: (context) =>
              ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      buildListProduct(
                          ShopCubit
                              .get(context)
                              .favouritesModel!
                              .data!
                              .data![index]
                              .product,
                          context),
                  separatorBuilder: (context, index) =>
                  const Divider(
                    height: 2,
                  ),
                  itemCount:
                  ShopCubit
                      .get(context)
                      .favouritesModel!
                      .data!
                      .data!
                      .length),
              fallback: (context) => const Center(child: Text('No Items'),)),
          fallback: (context) => const Center(
              child: CircularProgressIndicator()),
        );
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_appliction/modules/search/cubit.dart';
import 'package:shop_appliction/modules/search/states.dart';
import 'package:shop_appliction/shared/reusable%20components.dart';
class ShopSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultformfield(
                      onchange: (text){
                        SearchCubit.get(context).search(text);
                      } ,
                      controller: searchController,
                      label: 'Search',
                      prefix: Icons.search,
                      validator: (value){
                        if(value == null)
                        {
                          return 'search is emtpy';
                        }
                        return null;
                      },
                      type: TextInputType.text,
                    ),
                    SizedBox(height: 20,),
                    if(state is SearchLoadingState)
                      LinearProgressIndicator(),
                    SizedBox(height: 20,),
                    if(state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context,index)=>
                              buildListProduct(SearchCubit.get(context).model!.data!.data![index],context,isOldPrice: false),
                          separatorBuilder: (context,index)=>
                              myDivider(),
                          itemCount: SearchCubit.get(context).model!.data!.data!.length,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
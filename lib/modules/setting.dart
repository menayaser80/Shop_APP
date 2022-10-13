import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_appliction/modules/cubit/bloc.dart';
import 'package:shop_appliction/modules/cubit/states.dart';
import 'package:shop_appliction/shared/Constants.dart';
import 'package:shop_appliction/shared/reusable%20components.dart';
class SettingsScreen extends StatelessWidget {
  var namecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,Shopstates>(
      listener: (context, state)
      {

      },
      builder:(context, state) {
        var model = ShopCubit.get(context).userModel;
        namecontroller.text = model!.data!.name;
        emailcontroller.text = model.data!.email;
        phonecontroller.text = model.data!.phone;
        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if(state is ShopLoadingUpdateProfile)
                        LinearProgressIndicator(),
                      SizedBox(height: 20,),
                      defaultformfield(
                        controller: namecontroller,
                        label: 'Name',
                        prefix: Icons.person,
                        validator: ( value){
                          if (value!.isEmpty)
                          {
                            return 'Name must not be emtpy';
                          }
                          return null;
                        }, type: TextInputType.name,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultformfield(
                        controller: emailcontroller,
                        label: 'Email Address',
                        prefix: Icons.email,
                        validator: (value){
                          if (value!.isEmpty)
                          {
                            return 'Email must not be emtpy';
                          }
                          return null;
                        },
                        type: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultformfield(
                          controller: phonecontroller,
                          label: 'Phone',
                          type:TextInputType.phone,
                          prefix: Icons.phone,
                          validator: (value){
                            if(value!.isEmpty)
                            {
                              return 'Phone must not be emtpy';
                            }
                            return null;
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 40.0,
                        width: double.infinity,
                        color: Colors.grey[300],
                        child: defaulttextbutton(
                          function:(){
                            if(formKey.currentState!.validate())
                            {
                              ShopCubit.get(context).updateProfile(
                                phone:phonecontroller.text,
                                name: namecontroller.text,
                                email: emailcontroller.text,
                              );
                            }
                          },
                          text:'update',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 40.0,
                        width: double.infinity,
                        color: Colors.grey[300],
                        child: defaulttextbutton(
                          function:(){
                            signout(context);
                          },
                          text:'LOGOUT',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
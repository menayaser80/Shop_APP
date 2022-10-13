import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_appliction/Login/cubit.dart';
import 'package:shop_appliction/Login/states.dart';
import 'package:shop_appliction/Popular%20Cubit/cashe%20helper.dart';
import 'package:shop_appliction/Register/register%20screen.dart';
import 'package:shop_appliction/modules/cubit/bloc.dart';
import 'package:shop_appliction/modules/shop_layout.dart';
import 'package:shop_appliction/shared/Constants.dart';
import 'package:shop_appliction/shared/colors.dart';
import 'package:shop_appliction/shared/reusable%20components.dart';
class ShopLogin extends StatelessWidget {
  var formkey=GlobalKey<FormState>();
  var namecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var passwordcontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(BuildContext context)=>ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context,state)
        {
          if(state is ShopLoginSuccessState)
          {
            if(state.loginModel.status)
            {
              CachHelper.saveData(
                  key: 'token',
                  value: state.loginModel.data!.token
              ).then((value) {
                token = state.loginModel.data!.token;
                ShopCubit.get(context).updateProfile(name: namecontroller.text, phone: phonecontroller.text, email: emailcontroller.text);
                showToast(
                  state: ToastColor.SUCCESS,
                  text: state.loginModel.message.toString(),
                );
                navigateandFinish(context, ShopLayout());
              });
            }
            else
            {
              showToast(
                state: ToastColor.ERROR,
                text: state.loginModel.message.toString(),
              );
            }
          }
        },
        builder:(context,state){
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style:Theme.of(context).textTheme.headline4?.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.grey
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultformfield(
                          controller: emailcontroller,
                          type: TextInputType.emailAddress,
                          validator: (value)
                          {
                            if(value!.isEmpty&&value!=null)
                            {
                              return ' email address must not be empty';
                            }
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultpassword(controller: passwordcontroller,
                            type: TextInputType.visiblePassword,
                            onsubmit: (value)
                            {
                              if(formkey.currentState!.validate())
                              {
                                ShopLoginCubit.get(context).
                                userlogin(email:emailcontroller.text,
                                    password:passwordcontroller.text);
                              }
                            },
                            validator: (value)
                            {
                              if(value!.isEmpty&&value!=null)
                              {
                                return ' password is too short';
                              }
                            },
                            label: 'password',
                            ispassword:  ShopLoginCubit.get(context).isPassword,
                            prefix: Icons.lock_outline,
                            suffix:  ShopLoginCubit.get(context).suffix,
                            suffixpressed: (){
                              ShopLoginCubit.get(context).changepasswordvisibility();
                            }
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition:state is!ShopLoginLoadingState,
                          builder: (context)=>Container(
                              width: double.infinity,
                              color: defaultcolor,
                              child: MaterialButton(onPressed: (){
                                if(formkey.currentState!.validate())
                                {
                                  ShopLoginCubit.get(context).
                                  userlogin(email:emailcontroller.text,
                                      password:passwordcontroller.text);
                                }
                              },child: Text('Login',style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Colors.white,
                              ),),)),
                          fallback:(context)=>Center(child: CircularProgressIndicator()),
                        ),

                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?'),
                            defaulttextbutton(
                              function: (){
                                Navigator.push(context, MaterialPageRoute(
                                  builder:(context)=>ShopRegister(),
                                ));
                              },
                              text:'register',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } ,
      ),
    );
  }
}

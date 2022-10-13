import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_appliction/Login/login%20screen.dart';
import 'package:shop_appliction/Popular%20Cubit/bloc%20observer.dart';
import 'package:shop_appliction/Popular%20Cubit/bloc.dart';
import 'package:shop_appliction/Popular%20Cubit/cashe%20helper.dart';
import 'package:shop_appliction/Popular%20Cubit/dio%20helper.dart';
import 'package:shop_appliction/Popular%20Cubit/states.dart';
import 'package:shop_appliction/modules/cubit/bloc.dart';
import 'package:shop_appliction/modules/on%20boarding%20screen.dart';
import 'package:shop_appliction/modules/shop_layout.dart';
import 'package:shop_appliction/shared/Constants.dart';
import 'package:shop_appliction/shared/themes.dart';
void main()async
{
  WidgetsFlutterBinding.ensureInitialized();
  await CachHelper.init();
  DioHelper.init();
  Widget widget;
  bool? isDark = CachHelper.getData(key: 'isDark')??true;
  bool? onBoarding = CachHelper.getData(key: 'onBoarding');
  token = CachHelper.getData(key: 'token');
  print(token.toString());
  if(onBoarding != null)
  {
    if(token!=null&& token!.isNotEmpty)
    {
      widget = ShopLayout();
    }
    else
    {
      widget = ShopLogin();
    }
  }
  else
  {
    widget = Onboarding();
  }
  BlocOverrides.runZoned(
        (){
      // byt2kd en kol 7aga f el method 5lst w b3den yft7 el application
      runApp(MyApp(
        isdark: isDark,
        startwidget: widget,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}
class MyApp extends StatelessWidget {
  final bool? isdark;
  final Widget? startwidget;
  MyApp({
    this.isdark,
    this.startwidget,
  });
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create:(context)=>NewsCubit()..getbusiness()..getsports()..getscience()),
        BlocProvider(create:  (BuildContext context)=>AppCubit()..changeappmode(fromshared:isdark,
        ),),
        BlocProvider(
          create:  (BuildContext context)=>ShopCubit()..getHomeData()..getcategories()..getFavourites()..getUserData(),
        ),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            theme:lighttheme,
            darkTheme:darkTheme ,
            themeMode:AppCubit.get(context).isdark?ThemeMode.dark:ThemeMode.light,
            home:startwidget,
          );
        },
      ),
    );
  }
}


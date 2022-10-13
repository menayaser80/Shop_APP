import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_appliction/Popular%20Cubit/cashe%20helper.dart';
import 'package:shop_appliction/Popular%20Cubit/dio%20helper.dart';
import 'package:shop_appliction/Popular%20Cubit/states.dart';
import 'package:sqflite/sqflite.dart';

class NewsCubit extends Cubit <NewsStates>
{
  NewsCubit():super(NewsInitialState());
  static NewsCubit get (context)=>BlocProvider.of(context);
  int currentindex=0;
  List<BottomNavigationBarItem>BottomItems=[
    BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
      ),
      label: 'business',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'science',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'sports',
    ),
  ];
  void changeindex (int index)
  {
    currentindex=index;
    if(index==1)
      getsports();
    if(index==2)
      getscience();
    emit(NewsChangeBottomState());
  }
  List<dynamic>business=[];
  void getbusiness()
  {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query:
    {
      'country':'eg',
      'category':'business',
      'apiKey':'679a7f25a8dc43568359b9c1a60edbfd',
    },
    ).then((value) {
      //print(value.data['articles'][0]['title']);
      business=value.data['articles'];
      print(business[0]['title']);
      emit(NewsgetbusinessSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsgetbusinessErrorState(error.toString()));
    });
  }
  List<dynamic>sports=[];
  void getsports()
  {
    emit(NewsGetSportsLoadingState());
    if(sports.length==0)
    {DioHelper.getData(url: 'v2/top-headlines', query:
    {
      'country':'eg',
      'category':'sports',
      'apiKey':'679a7f25a8dc43568359b9c1a60edbfd',
    },
    ).then((value) {
      //print(value.data['articles'][0]['title']);
      sports=value.data['articles'];
      print(sports[0]['title']);
      emit(NewsgetSportsSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsgetSportsErrorState(error.toString()));
    });
    }
    else
    {
      emit(NewsgetSportsSuccessState());
    }
  }
  List<dynamic>science=[];
  void getscience()
  {
    emit(NewsGetScienceLoadingState());
    if(science.length==0)
    {
      DioHelper.getData(url: 'v2/top-headlines', query:
      {
        'country':'eg',
        'category':'science',
        'apiKey':'679a7f25a8dc43568359b9c1a60edbfd',
      },
      ).then((value) {
        //print(value.data['articles'][0]['title']);
        science=value.data['articles'];
        print(science[0]['title']);
        emit(NewsgetScienceSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsgetScienceErrorState(error.toString()));
      });
    }else
    {
      emit(NewsgetScienceSuccessState());
    }


  }
  List<dynamic>search=[];
  void getsearch(String value)
  {
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(url: 'v2/everything', query:
    {
      'q':'$value',
      'apiKey':'679a7f25a8dc43568359b9c1a60edbfd',
    },
    ).then((value) {
      //print(value.data['articles'][0]['title']);
      search=value.data['articles'];
      print(search[0]['title']);
      emit(NewsgetSearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsgetSearchErrorState(error.toString()));
    });
  }
}
class AppCubit extends Cubit <AppStates>
{
  AppCubit():super(AppInitialState());
  static AppCubit get (context)=>BlocProvider.of(context);
  int currentindex=0;
  List<String>title=[
    'new tasks',
    'done tasks',
    'archized tasks',
  ];
  void changeindex (int index)
  {
    currentindex=index;
    emit(AppChangeBottomState());
  }
  late Database database;
  List<Map>newtasks=[];
  List<Map>donetasks=[];
  List<Map>archizedtasks=[];
  Future<void>createdatabase()
  async {
    openDatabase(
      'mena.db',
      version: 1,
      onCreate: (database,version)async
      {
        print('database created');
        await database.execute('CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)').then((value){
          print ('tablecreated');
        } ).catchError((error){
          print('error${error.toString()}');
        }
        );
      },
      onOpen: (database)
      {
        getdatafromdatabase(database);
        print('database opened');
      },
    ).then((value){
      database=value;
      emit(AppCreateDataBase());
    });
  }
  insertdatabase(
      {
        required String title,
        required String time,
        required String date,
      }
      )
  async {
    await database.transaction((txn) async {
      txn.rawInsert(
          'INSERT INTO tasks(title,date,time,status) VALUES("$title","$date","$time","")')
          .then((value) {
        print(' inserted successfully');
        emit(AppInsertDataBase());
        getdatafromdatabase(database);
      }).catchError((error){
        print('error when inserting ${error.toString()}');
      });
      return null;
    });
  }
  void getdatafromdatabase(database)
  {
    newtasks=[];
    donetasks=[];
    archizedtasks=[];
    emit(AppGetDataBaseLoading());
    database.rawQuery('SELECT * FROM tasks').then((value) {

      value.forEach((element) {

        if(element['status']=='new')
          newtasks.add(element);
        else if(element['status']=='done')
          donetasks.add(element);
        else
          archizedtasks.add(element);

      });
      emit(AppGetDataBase());
    });
  }
  void UpdateData({
    required String status,
    required int id,
  })async
  {
    database.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      ['$status', id ],
    ).then((value) {
      getdatafromdatabase(database);
      emit(AppUpdateDataBase());
    });
  }
  void DeleteData({
    required int id,
  })async
  {
    database.rawDelete(
      'DELETE FROM tasks WHERE id = ?', [id],
    ).then((value) {
      getdatafromdatabase(database);
      emit(AppDeleteDataBase());
    });
  }
  bool isclosed=false;
  IconData fabicon=Icons.edit;
  void Changebottomsheet({
    required bool isshow,
    required IconData icon,
  })
  {
    isclosed=isshow;
    fabicon=icon;
    emit(Isclosedstate());
  }
  bool isdark =false;
  void changeappmode({bool? fromshared})
  {
    if(fromshared !=null)
    {
      isdark=fromshared;
      emit(AppChangeDarkState());
    }
    else
    {
      isdark=!isdark;
      CachHelper.putBoolean(key:'isdark', value:isdark).then((value){
        emit(AppChangeDarkState());
      });
    }
  }
}
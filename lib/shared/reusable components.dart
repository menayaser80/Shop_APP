import 'package:flutter/material.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_appliction/Popular%20Cubit/bloc.dart';
import 'package:shop_appliction/modules/cubit/bloc.dart';
import 'package:shop_appliction/shared/colors.dart';
Widget myDivider()=>Padding(
  padding: EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],

  ),
);
Widget TasksBuilder({
  required List<Map>tasks,
})=>ConditionalBuilder(
  condition: tasks.length>0,
  builder:(context)=> ListView.separated(itemBuilder:(context,index)=>builditem(
      tasks[index],context), separatorBuilder: (context,index)=>Padding(
    padding: EdgeInsetsDirectional.only(
      start: 20.0,
    ),
    child: Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.grey[300],
    ),
  ), itemCount: tasks.length),
  fallback:(context)=>Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.menu,
          size: 100.0,
          color: Colors.grey,
        ),
        Text(
          'No Tasks yet,please add some tasks',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ],
    ),
  ) ,
);
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Widget builditem(Map model,context)=>Dismissible(
  key: Key(model['id'].toString()),
  child:Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children: [

        CircleAvatar(

          radius: 40.0,

          child: Text(
              '${model['time']}'
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${model['title']}',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),),

              Text('${model['date']}',

                style: TextStyle(

                  color: Colors.grey,

                ),),



            ],

          ),

        ),

        SizedBox(

          width: 20.0,

        ),

        IconButton(onPressed: (){

          AppCubit.get(context).UpdateData(status: 'done', id: model['id'],);

        },

          icon: Icon(

            Icons.check_box,

            color: Colors.green,

          ),

        ),

        IconButton(onPressed: (){

          AppCubit.get(context).UpdateData(status: 'archive', id: model['id'],);



        },

          icon: Icon(

            Icons.archive,

            color: Colors.blueGrey ,

          ),

        ),



      ],

    ),

  ),
  onDismissed:(direction)
  {
    AppCubit.get(context).DeleteData(id: model['id']);
  } ,
);
Widget defaultformfield({
  required TextEditingController controller,
  required TextInputType type,
  Function(String x)?onchange,
  required String? Function(String?val)?validator,
  required String label,
  required IconData prefix,
})=> TextFormField(
    controller: controller,
    decoration: InputDecoration(
      prefixIcon: Icon(
        prefix,
      ),
      labelText: label,
      border: OutlineInputBorder(),
    ),
    validator: validator,

    keyboardType:type,
    onChanged:onchange
);
Widget defaultpassword({
  required TextEditingController controller,
  required TextInputType type,
  Function(String x)?onchange,
  Function(String x)?onsubmit,
  required String? Function(String?val)?validator,
  required String label,
  required IconData prefix,
  IconData? suffix,
  bool ispassword=false,
  VoidCallback? suffixpressed,
})=>TextFormField(
  controller: controller,
  decoration: InputDecoration(
    prefixIcon: Icon(
      prefix,
    ),
    suffixIcon: suffix!=null?IconButton(
      onPressed:suffixpressed,
      icon:   Icon(
        suffix,
      ),
    ):null,
    labelText: label,
    border: OutlineInputBorder(),
  ),
  validator: validator,
  keyboardType:type,
  obscureText: ispassword,
  onChanged: onchange,
  onFieldSubmitted:onsubmit,
);
void navigateTo(context,Widget)=>Navigator.push(context, MaterialPageRoute(
  builder:(context)=>Widget,
));

void navigateandFinish(context,Widget)=>Navigator.pushAndRemoveUntil(context,MaterialPageRoute(
  builder: (context)=>Widget,
),
      (route)
  {
    return false;
  },
);
Widget defaulttextbutton({
  required VoidCallback function,
  required String text,
})=>  TextButton(
  onPressed: function,
  child:Text(text.toUpperCase(),),
);
void showToast({
  required String text ,
  required ToastColor state ,
}) =>  Fluttertoast.showToast(
  msg: text,
  toastLength: Toast.LENGTH_SHORT,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIosWeb: 5,
  backgroundColor: ChangeToastColor(state),
  textColor: Colors.white,
  fontSize: 16.0,
);
enum ToastColor {SUCCESS,ERROR,WARNING}
Color ChangeToastColor(ToastColor state)
{
  Color color;
  switch(state){
    case ToastColor.SUCCESS:
      color = Colors.green;
      break;
    case ToastColor.ERROR:
      color = Colors.red;
      break;
    case ToastColor.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}
Widget buildListProduct(model, context, {bool isOldPrice = true}) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120.0,
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage('${model!.image!}'),
              width: 120.0,
              height: 120.0,
            ),
            if ((model.discount?? 0) != 0 && isOldPrice)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                color: Colors.red,
                child: Text(
                  'Discount',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
          ],
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model.name!}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    height: 1.3),
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    '${model.price!.toString()}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: defaultcolor),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  if ((model.discount?? 0) != 0 && isOldPrice)
                    Text(
                      '${model.oldPrice!.toString()}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough),
                    ),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        ShopCubit.get(context)
                            .changeFavorites(model.id!);
                      },
                      icon: CircleAvatar(
                        radius: 15.0,
                        backgroundColor: ShopCubit
                            .get(context)
                            .favourite[model.id]!
                            ? defaultcolor
                            : Colors.grey,
                        child: Icon(
                          Icons.favorite_border,
                          size: 20,
                          color: Colors.white,
                        ),
                      ))
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);

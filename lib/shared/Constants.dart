import 'package:shop_appliction/Login/login%20screen.dart';
import 'package:shop_appliction/Popular%20Cubit/cashe%20helper.dart';
import 'package:shop_appliction/shared/reusable%20components.dart';

String? token ='';
void signout(context)
{
  CachHelper.removeData(key: 'token',).then((value){
    if(value)
    {
      navigateandFinish(context, ShopLogin());
    }
  });
}
void printFullText(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
abstract class NewsStates{}
class NewsInitialState extends NewsStates
{}
class NewsChangeBottomState extends NewsStates
{}
class NewsGetBusinessLoadingState extends NewsStates{}
class NewsgetbusinessSuccessState extends NewsStates
{}
class NewsgetbusinessErrorState extends NewsStates
{
  late final String error;
  NewsgetbusinessErrorState(this.error);
}
class NewsGetSportsLoadingState extends NewsStates{}
class NewsgetSportsSuccessState extends NewsStates
{}
class NewsgetSportsErrorState extends NewsStates
{
  late final String error;
  NewsgetSportsErrorState(this.error);
}
class NewsGetScienceLoadingState extends NewsStates{}
class NewsgetScienceSuccessState extends NewsStates
{}
class NewsgetScienceErrorState extends NewsStates
{
  late final String error;
  NewsgetScienceErrorState(this.error);
}
//
abstract class AppStates{}
class AppInitialState extends AppStates
{}
class AppChangeBottomState extends AppStates
{
}
class AppCreateDataBase extends AppStates
{}
class AppInsertDataBase extends AppStates
{}
class AppGetDataBase extends AppStates
{}
class Isclosedstate extends AppStates
{}
class AppGetDataBaseLoading extends AppStates
{}
class AppUpdateDataBase extends AppStates
{}
class AppDeleteDataBase extends AppStates
{}
class AppChangeDarkState extends AppStates
{}
class NewsGetSearchLoadingState extends NewsStates{}
class NewsgetSearchSuccessState extends NewsStates
{}
class NewsgetSearchErrorState extends NewsStates
{
  late final String error;
  NewsgetSearchErrorState(this.error);
}
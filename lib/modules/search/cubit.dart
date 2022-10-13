import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_appliction/Popular%20Cubit/dio%20helper.dart';
import 'package:shop_appliction/models/search%20model.dart';
import 'package:shop_appliction/modules/search/states.dart';
import 'package:shop_appliction/shared/Constants.dart';
import 'package:shop_appliction/shared/end%20points.dart';
class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());
  static SearchCubit get(context) => BlocProvider.of(context);
  SearchModel? model;
  void search(String text) {
    emit(SearchLoadingState());
    DioHelper.postData(
      token: token,
      url: SEARCH,
      data: {
        'text':text,
      },
    ).then((value) {
      model = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error){
      emit(SearchErrorState());
      print(error.toString());
    });
  }
}
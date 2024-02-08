import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_ahlul_quran_app/Data/model/service_api.dart';
import 'package:flutter_ahlul_quran_app/Data/model/surahmodel.dart';

part 'surah_state.dart';

class SurahCubit extends Cubit<SurahState> {
  SurahCubit(this.apiService) : super(SurahInitial());

  final ApiService apiService;


  void getALLSurah() async {
    emit(SurahLoading());
    final result = await apiService.getALLSurah();
    result.fold(
      (l) => emit(SurahError(message: l)), 
      (r) => emit(SurahLoaded(listSurah: r))
    );
  }
}

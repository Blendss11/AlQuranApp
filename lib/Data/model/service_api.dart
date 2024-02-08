import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_ahlul_quran_app/Data/model/Detail_surah.dart';
import 'package:flutter_ahlul_quran_app/Data/model/surahmodel.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final http.Client client;
  ApiService({required this.client});

  Future<Either<String, List<SurahModel>>> getALLSurah() async {
    try{
      final resonseName = 
      await client.get(Uri.parse('https://equran.id/api/surat'));

      return Right(
        List<SurahModel>.from(
          jsonDecode(resonseName.body).map(
            (x) => SurahModel.fromJson(x),
          ),

        ).toList(),
      );

    } catch (e){
      return left(e.toString());
    }
  }


  Future<Either<String, DetailSurahModel>> getDetailSurah(
    int nomorSurah) async {
      try  {
        final Response =  await client.get(Uri.parse('https://equran.id/api/surat/$nomorSurah'));
        return Right(DetailSurahModel.fromJson(jsonDecode(Response.body)));
      } catch (e) {
        return left(e.toString());
      }
    }

}
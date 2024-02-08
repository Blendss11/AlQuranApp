import 'package:flutter/material.dart';
import 'package:flutter_ahlul_quran_app/UI/ayat_page.dart';
import 'package:flutter_ahlul_quran_app/common/contants.dart';
import 'package:flutter_ahlul_quran_app/cubit/Surah/surah_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SurahPage extends StatefulWidget{
  const SurahPage({super.key});

  @override
  State<SurahPage> createState() => _SurahPageState();
}

class _SurahPageState extends State<SurahPage> {
  @override
  void initState() {
    context.read<SurahCubit>().getALLSurah();
    super.initState();
  }

@override
Widget build(BuildContext context){
  return Scaffold(
    appBar: AppBar(
      title: const Text(
        "Al Qur'an",
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
    ),
    body: BlocBuilder<SurahCubit, SurahState>(
      builder: (context, state) {
        if(state is SurahLoading) {
          return const Center(child: CircularProgressIndicator.adaptive(),
          );
        }
        if(state is SurahLoaded) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final surah = state.listSurah[index];
              return InkWell(
                onTap: () {
                  
                  Navigator.push(context, MaterialPageRoute(builder:(context){
                    return AyatPage(surah: surah);
                  }));
                },
                child: Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.red,
                      child: Text(
                        '${surah.nomor}',
                        style: const TextStyle(color: AppColors.white),
                      ),
                    ),
                    title: Text('${surah.latinName}, ${surah.name}'),
                    subtitle: Text('${surah.translate}, ${surah.numayat} Ayat'),
                  ),
                ),
              );
            } ,
            itemCount: state.listSurah.length,
          );
        }

        if(state is SurahError){
          return Center(
            child: Text(state.message),
          );
        }
        return const Center(
          child: Text('No Data'),
        );
      },
    ),
  );
}
}
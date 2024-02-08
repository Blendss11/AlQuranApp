// To parse this JSON data, do
//
//     final surahModel = surahModelFromJson(jsonString);


class SurahModel {
    int nomor;
    String name;
    String latinName;
    int numayat;
    TempatTurun tempatTurun;
    String translate;
    String deskripsi;
    String audio;

    SurahModel({
        required this.nomor,
        required this.name,
        required this.latinName,
        required this.numayat,
        required this.tempatTurun,
        required this.translate,
        required this.deskripsi,
        required this.audio,
    });

    factory SurahModel.fromJson(Map<String, dynamic> json) => SurahModel(
        nomor: json["nomor"],
        name: json["nama"],
        latinName: json["nama_latin"],
        numayat: json["jumlah_ayat"],
        tempatTurun: tempatTurunValues.map[json["tempat_turun"]]!,
        translate: json["arti"],
        deskripsi: json["deskripsi"],
        audio: json["audio"],
    );

    Map<String, dynamic> toJson() => {
        "nomor": nomor,
        "nama": name,
        "nama_latin": latinName,
        "jumlah_ayat": numayat,
        "tempat_turun": tempatTurunValues.reverse[tempatTurun],
        "arti": translate,
        "deskripsi": deskripsi,
        "audio": audio,
    };
}

enum TempatTurun {
    Madinah,
    MEKAH
}

final tempatTurunValues = EnumValues({
    "madinah": TempatTurun.Madinah,
    "mekah": TempatTurun.MEKAH
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}

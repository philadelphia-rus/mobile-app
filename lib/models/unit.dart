// To parse this JSON data, do
//
//     final unit = unitFromJson(jsonString);

import 'dart:convert';

List<Unit> unitFromJson(String str) => List<Unit>.from(json.decode(str).map((x) => Unit.fromJson(x)));

String unitToJson(List<Unit> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Unit {
    Unit({
        required this.name,
        required this.number,
        required this.steps,
    });

    String name;
    int number;
    List<Step> steps;

    factory Unit.fromJson(Map<String, dynamic> json) => Unit(
        name: json["name"],
        number: json["number"],
        steps: List<Step>.from(json["steps"].map((x) => Step.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "number": number,
        "steps": List<dynamic>.from(steps.map((x) => x.toJson())),
    };
}

class Step {
    Step({
        required this.type,
        required this.name,
        this.video,
        this.mdFile,
        this.question,
    });

    Type type;
    String name;
    String? video;
    String? mdFile;
    dynamic question;

    factory Step.fromJson(Map<String, dynamic> json) => Step(
        type: typeValues.map[json["type"]]!,
        name: json["name"],
        video: json["video"],
        mdFile: json["mdFile"],
        question: json["question"],
    );

    Map<String, dynamic> toJson() => {
        "type": typeValues.reverse[type],
        "name": name,
        "video": video,
        "mdFile": mdFile,
        "question": question,
    };
}

enum Type { MDFILE, VIDEO, QUESTIONS }

final typeValues = EnumValues({
    "MDFILE": Type.MDFILE,
    "QUESTIONS": Type.QUESTIONS,
    "VIDEO": Type.VIDEO
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

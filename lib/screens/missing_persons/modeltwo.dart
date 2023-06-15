import 'dart:convert';

Item itemFromJson(String str) => Item.fromJson(json.decode(str));

String itemToJson(Item data) => json.encode(data.toJson());

class Item {
    String id;
    String ukey;
    String age;
    String cellnumber;
    String name;
    String nic;
    String residence;
    String gender;
    //String location;
    String identity;
    String lostdate;
    String losttime;
    String dress;
    String height;
    String religion;
    String image;
    


    Item({
        required this.id,
        required this.age,
        required this.cellnumber,
        required this.name,
        required this.nic,
        required this.residence,
        required this.gender,
       // required this.location,
        required this.identity,
        required this.lostdate,
        required this.losttime,
        required this.dress,
        required this.height,
        required this.religion,
        required this.image,
        required this.ukey,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        age: json["age"],
        cellnumber: json["cellnumber"],
        name: json["name"],
        nic: json["nic"],
        residence: json["residence"],
        gender: json["gender"],
       // location: json["location"],
        identity: json["identity"],
        lostdate: json["lostdate"],
        losttime: json["losttime"],
        dress: json["dress"],
        height: json["height"],
        religion: json["religion"],
        image: json["image"],
        ukey: json["ukey"],

    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "age": age,
        "cellnumber": cellnumber,
        "name": name,
        "nic": nic,
        "residence": residence,
        "gender": gender,
        //"location": location,
        "identity": identity,
        "lostdate": lostdate,
        "losttime": losttime,
        "dress": dress,
        "height": height,
        "religion": religion,
        "image": image,
        "ukey": ukey,
    };
}

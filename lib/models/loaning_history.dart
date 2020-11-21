import 'dart:convert';

LoaningHistory loaningHistoryFromJson(String str) =>
    LoaningHistory.fromJson(json.decode(str));

String loaningHistoryToJson(LoaningHistory data) => json.encode(data.toJson());

class LoaningHistory {
  LoaningHistory({
    this.message,
    this.data,
  });

  String message;
  Data data;

  factory LoaningHistory.fromJson(Map<String, dynamic> json) => LoaningHistory(
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int currentPage;
  List<Datum> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<Link> links;
  dynamic nextPageUrl;
  String path;
  String perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Datum {
  Datum({
    this.id,
    this.userId,
    this.urgent,
    this.reason,
    this.necessity,
    this.teacherInCharge,
    this.borrowDate,
    this.approved,
    this.teacherReason,
    this.created,
  });

  int id;
  int userId;
  bool urgent;
  dynamic reason;
  String necessity;
  String teacherInCharge;
  DateTime borrowDate;
  dynamic approved;
  dynamic teacherReason;
  String created;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        urgent: json["urgent"],
        reason: json["reason"],
        necessity: json["necessity"],
        teacherInCharge: json["teacher_in_charge"],
        borrowDate: DateTime.parse(json["borrow_date"]),
        approved: json["approved"],
        teacherReason: json["teacher_reason"],
        created: json["created"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "urgent": urgent,
        "reason": reason,
        "necessity": necessity,
        "teacher_in_charge": teacherInCharge,
        "borrow_date": borrowDate.toIso8601String(),
        "approved": approved,
        "teacher_reason": teacherReason,
        "created": created,
      };
}

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  String url;
  dynamic label;
  bool active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"] == null ? null : json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
        "label": label,
        "active": active,
      };
}

class ReturnOrdersModel {
  List<Data>? data;

  ReturnOrdersModel({this.data});

  ReturnOrdersModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? returnReasonId;
  String? note;
  int? orderId;
  String? orderDatetime;
  String? returnDatetime;
  int? returnItems;
  String? returnTotalCurrencyPrice;
  String? returnTotalPrice;
  int? userId;
  String? userName;
  int? orderSerialNo;
  int? status;

  Data(
      {this.id,
      this.returnReasonId,
      this.note,
      this.orderId,
      this.orderDatetime,
      this.returnDatetime,
      this.returnItems,
      this.returnTotalCurrencyPrice,
      this.returnTotalPrice,
      this.userId,
      this.userName,
      this.orderSerialNo,
      this.status});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    returnReasonId = json['return_reason_id'];
    note = json['note'];
    orderId = json['order_id'];
    orderDatetime = json['order_datetime'];
    returnDatetime = json['return_datetime'];
    returnItems = json['return_items'];
    returnTotalCurrencyPrice = json['return_total_currency_price'];
    returnTotalPrice = json['return_total_price'];
    userId = json['user_id'];
    userName = json['user_name'];
    orderSerialNo = json['order_serial_no'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['return_reason_id'] = this.returnReasonId;
    data['note'] = this.note;
    data['order_id'] = this.orderId;
    data['order_datetime'] = this.orderDatetime;
    data['return_datetime'] = this.returnDatetime;
    data['return_items'] = this.returnItems;
    data['return_total_currency_price'] = this.returnTotalCurrencyPrice;
    data['return_total_price'] = this.returnTotalPrice;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['order_serial_no'] = this.orderSerialNo;
    data['status'] = this.status;
    return data;
  }
}
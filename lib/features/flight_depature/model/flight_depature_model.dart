class FlightDepatureResponseModel {
  int? airLineId;
  String? flightNoName;
  int? aircraftRegId;
  int? fidsFlightId;
  int? airportIdTo;
  int? airportIdFrom;
  String? landingDate;
  String? takeOffDate;
  int? status;
  String? date;
  String? ata;
  String? atd;
  int? companyInfoId;
  String? registration;
  String? airportFromNameAr;
  String? airportFromNameEn;
  String? airportToNameAr;
  String? airportToNameEn;
  int? id;

  FlightDepatureResponseModel(
      {this.airLineId,
      this.flightNoName,
      this.aircraftRegId,
      this.fidsFlightId,
      this.airportIdTo,
      this.airportIdFrom,
      this.landingDate,
      this.takeOffDate,
      this.status,
      this.date,
      this.ata,
      this.atd,
      this.companyInfoId,
      this.registration,
      this.airportFromNameAr,
      this.airportFromNameEn,
      this.airportToNameAr,
      this.airportToNameEn,
      this.id});

  FlightDepatureResponseModel.fromJson(Map<String, dynamic> json) {
    airLineId = json['airLineId'];
    flightNoName = json['flightNoName'];
    aircraftRegId = json['aircraftRegId'];
    fidsFlightId = json['fidsFlightId'];
    airportIdTo = json['airportIdTo'];
    airportIdFrom = json['airportIdFrom'];
    landingDate = json['landingDate'];
    takeOffDate = json['takeOffDate'];
    status = json['status'];
    date = json['date'];
    ata = json['ata'];
    atd = json['atd'];
    companyInfoId = json['companyInfoId'];
    registration = json['registration'];
    airportFromNameAr = json['airportFromNameAr'];
    airportFromNameEn = json['airportFromNameEn'];
    airportToNameAr = json['airportToNameAr'];
    airportToNameEn = json['airportToNameEn'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['airLineId'] = this.airLineId;
    data['flightNoName'] = this.flightNoName;
    data['aircraftRegId'] = this.aircraftRegId;
    data['fidsFlightId'] = this.fidsFlightId;
    data['airportIdTo'] = this.airportIdTo;
    data['airportIdFrom'] = this.airportIdFrom;
    data['landingDate'] = this.landingDate;
    data['takeOffDate'] = this.takeOffDate;
    data['status'] = this.status;
    data['date'] = this.date;
    data['ata'] = this.ata;
    data['atd'] = this.atd;
    data['companyInfoId'] = this.companyInfoId;
    data['registration'] = this.registration;
    data['airportFromNameAr'] = this.airportFromNameAr;
    data['airportFromNameEn'] = this.airportFromNameEn;
    data['airportToNameAr'] = this.airportToNameAr;
    data['airportToNameEn'] = this.airportToNameEn;
    data['id'] = this.id;
    return data;
  }
}

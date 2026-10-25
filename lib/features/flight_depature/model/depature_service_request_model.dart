class DepatureServiceRequestModel {
  int? id;
  int? towerDataId;
  int? handlingAgentId;
  int? fuelCompanyId;
  int? fuelLiter;
  int? pax;
  int? paxInter;
  int? firstClassCount;
  int? freightLoadingExp;
  int? normalMailLoadingExp;
  int? rapidMailLoadingExp;
  int? ambulanceCarCount;
  int? fireFightingCarCount;
  bool? hasPushPack;

  DepatureServiceRequestModel(
      {this.id,
      this.towerDataId,
      this.handlingAgentId,
      this.fuelCompanyId,
      this.fuelLiter,
      this.pax,
      this.paxInter,
      this.firstClassCount,
      this.freightLoadingExp,
      this.normalMailLoadingExp,
      this.rapidMailLoadingExp,
      this.ambulanceCarCount,
      this.fireFightingCarCount,
      this.hasPushPack});

  DepatureServiceRequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    towerDataId = json['towerDataId'];
    handlingAgentId = json['handlingAgentId'];
    fuelCompanyId = json['fuelCompanyId'];
    fuelLiter = json['fuelLiter'];
    pax = json['pax'];
    paxInter = json['paxInter'];
    firstClassCount = json['firstClassCount'];
    freightLoadingExp = json['freightLoadingExp'];
    normalMailLoadingExp = json['normalMailLoadingExp'];
    rapidMailLoadingExp = json['rapidMailLoadingExp'];
    ambulanceCarCount = json['ambulanceCarCount'];
    fireFightingCarCount = json['fireFightingCarCount'];
    hasPushPack = json['hasPushPack'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['towerDataId'] = this.towerDataId;
    data['handlingAgentId'] = this.handlingAgentId;
    data['fuelCompanyId'] = this.fuelCompanyId;
    data['fuelLiter'] = this.fuelLiter;
    data['pax'] = this.pax;
    data['paxInter'] = this.paxInter;
    data['firstClassCount'] = this.firstClassCount;
    data['freightLoadingExp'] = this.freightLoadingExp;
    data['normalMailLoadingExp'] = this.normalMailLoadingExp;
    data['rapidMailLoadingExp'] = this.rapidMailLoadingExp;
    data['ambulanceCarCount'] = this.ambulanceCarCount;
    data['fireFightingCarCount'] = this.fireFightingCarCount;
    data['hasPushPack'] = this.hasPushPack;
    return data;
  }
}

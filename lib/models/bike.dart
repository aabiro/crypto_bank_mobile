
class Bike {
  int id;
  int userId;
  int qrCode; // image?
  String model;
  double lat;
  double lng;
  int passengerId;
  bool isVerified; // other users have verified
  bool isActivated;
  bool isAvailable;
  bool isOutOfOrder;
  bool outOfBounds;
  String imageUrl;
  double totalIncomeGenerated;
  //need daily income model to update for each ride

  Bike(
    this.id, 
    this.model, 
    this.userId, 
    this.isAvailable, 
    this.isVerified, 
    this.isActivated, 
    // this.outOfBounds, 
    this.imageUrl
  );

    int get _id {
    return id;
  }

    int get ownerId {
    return ownerId;
  }
}
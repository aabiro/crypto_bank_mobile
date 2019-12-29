class Order {

String address;
String name;
String zipcode;
String street;
String city;
String country;
bool isApproved;
String planType;
int quantity;

Order(
  {
  this.planType,  
  this.quantity,
  this.address, 
  this.name, 
  this.zipcode,
  this.country,
  this.city,
  this.street,
  this.isApproved
  
  }
  );

}
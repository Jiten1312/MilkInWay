class Order{
  String id;
  String custId,itemName;
  int amount,itemPrice;
  int noOfItems;
  DateTime sdate,edate; 
  Order({this.id,this.custId, this.itemName,this.itemPrice,this.noOfItems,this.amount,this.sdate,this.edate});
}
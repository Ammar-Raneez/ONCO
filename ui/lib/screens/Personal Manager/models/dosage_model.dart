class Dose {
  final int id;
  final int quantity;
  final String type;


  Dose({this.id,this.quantity,this.type}); // Constructor

  Map<String, dynamic> toMap(){
    return{
      'id':id,
      'quantity':quantity,
      'type':type,
    };
  }
}
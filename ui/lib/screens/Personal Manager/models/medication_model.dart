class Medication {
  final int id;
  final String title;

  Medication({this.id,this.title}); // Constructor

  Map<String, dynamic> toMap(){
    return{
      'id':id,
      'title':title
    };
  }

}
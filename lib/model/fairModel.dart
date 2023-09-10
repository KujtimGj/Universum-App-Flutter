class Fair{
  String title, description;

  Fair({required this.title,required this.description});


  factory Fair.fromJson(Map<String, dynamic>fromJson){
    return Fair(
        title: fromJson['title'],
        description: fromJson['description']
    );
  }
}
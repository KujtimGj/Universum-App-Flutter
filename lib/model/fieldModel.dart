class Field{
   String field,description;

  Field({required this.field, required this.description});

  factory Field.fromJson(Map<String, dynamic> fromJson) {
    return Field(
        field: fromJson['title'],
        description: fromJson['description']
    );
  }
}
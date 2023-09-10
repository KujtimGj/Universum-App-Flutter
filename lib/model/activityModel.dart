class Activity{
  String actName, actType, actDate,actField;

  Activity({required this.actName, required this.actType, required this.actDate, required this.actField});


  factory Activity.fromJson(Map<String, dynamic> fromJson) {
    return Activity(
        actName: fromJson['actName'],
        actType: fromJson['actType'],
        actDate: fromJson['actDate'],
        actField: fromJson['actField']
    );
  }
}
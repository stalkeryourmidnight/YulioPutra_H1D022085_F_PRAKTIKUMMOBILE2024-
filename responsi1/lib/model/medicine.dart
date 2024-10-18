class Medicine {
  final int id;
  final String medicineName;
  final int dosageMg;
  final int timesPerDay;

  Medicine({
    required this.id,
    required this.medicineName,
    required this.dosageMg,
    required this.timesPerDay,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'medicine_name': medicineName,
      'dosage_mg': dosageMg,
      'times_per_day': timesPerDay,
    };
  }

  factory Medicine.fromMap(Map<String, dynamic> map) {
    return Medicine(
      id: map['id'],
      medicineName: map['medicine_name'],
      dosageMg: map['dosage_mg'],
      timesPerDay: map['times_per_day'],
    );
  }
}

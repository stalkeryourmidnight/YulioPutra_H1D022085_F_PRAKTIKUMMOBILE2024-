import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:responsi1/helpers/api_url.dart';
import 'package:responsi1/model/medicine.dart';


class MedicineState {
  final List<Medicine> medicines;

  
  MedicineState({required this.medicines});
}

abstract class MedicineEvent {}

class LoadMedicines extends MedicineEvent {}

class AddMedicine extends MedicineEvent {
  final Medicine medicine;

  AddMedicine(this.medicine);
}

class UpdateMedicine extends MedicineEvent {
  final Medicine medicine;

  UpdateMedicine(this.medicine);
}

class DeleteMedicine extends MedicineEvent {
  final int id;

  DeleteMedicine(this.id);
}

class MedicineBloc extends Bloc<MedicineEvent, MedicineState> {
  MedicineBloc() : super(MedicineState(medicines: [])) {
    on<LoadMedicines>(_onLoadMedicines);
    on<AddMedicine>(_onAddMedicine);
    on<UpdateMedicine>(_onUpdateMedicine);
    on<DeleteMedicine>(_onDeleteMedicine);
  }


  Future<void> _onLoadMedicines(
      LoadMedicines event, Emitter<MedicineState> emit) async {
    try {
      final response = await http.get(Uri.parse(ApiUrl.getMedicines));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<Medicine> medicines = data.map((item) {
          return Medicine(
            id: item['id'],
            medicineName: item['medicine_name'],
            dosageMg: item['dosage_mg'],
            timesPerDay: item['times_per_day'],
          );
        }).toList();
        emit(MedicineState(medicines: medicines));
      } else {
        throw Exception('Failed to load medicines');
      }
    } catch (error) {
      print('Error loading medicines: $error');
    }
  }

  Future<void> _onAddMedicine(
      AddMedicine event, Emitter<MedicineState> emit) async {
    try {
      final response = await http.post(
        Uri.parse(ApiUrl.addMedicine),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'medicine_name': event.medicine.medicineName,
          'dosage_mg': event.medicine.dosageMg,
          'times_per_day': event.medicine.timesPerDay,
        }),
      );

      if (response.statusCode == 201) {
        add(LoadMedicines());
      } else {
        throw Exception('Failed to add medicine');
      }
    } catch (error) {
      print('Error adding medicine: $error');
    }
  }

  Future<void> _onUpdateMedicine(
      UpdateMedicine event, Emitter<MedicineState> emit) async {
    try {
      final response = await http.put(
        Uri.parse('${ApiUrl.updateMedicine}/${event.medicine.id}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'medicine_name': event.medicine.medicineName,
          'dosage_mg': event.medicine.dosageMg,
          'times_per_day': event.medicine.timesPerDay,
        }),
      );

      if (response.statusCode == 200) {
        add(LoadMedicines());
      } else {
        throw Exception('Failed to update medicine');
      }
    } catch (error) {
      print('Error updating medicine: $error');
    }
  }

  Future<void> _onDeleteMedicine(
      DeleteMedicine event, Emitter<MedicineState> emit) async {
    try {
      final response = await http.delete(
        Uri.parse('${ApiUrl.deleteMedicine}/${event.id}'),
      );

      if (response.statusCode == 200) {
        add(LoadMedicines());
      } else {
        throw Exception('Failed to delete medicine');
      }
    } catch (error) {
      print('Error deleting medicine: $error');
    }
  }
}

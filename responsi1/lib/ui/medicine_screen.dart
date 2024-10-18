import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsi1/bloc/medicine_bloc.dart';
import 'package:responsi1/model/medicine.dart';

class MedicineScreen extends StatelessWidget {
  MedicineScreen({super.key});

  final MedicineBloc _medicineBloc = MedicineBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text(
          'Pengingat Obat CRUD',
          style: TextStyle(
            fontFamily: 'Georgia', 
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () {
              _showMedicineForm(context);
            },
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => _medicineBloc..add(LoadMedicines()),
        child: BlocBuilder<MedicineBloc, MedicineState>(
          builder: (context, state) {
            if (state.medicines.isEmpty) {
              return const Center(
                child: Text(
                  "No Medicines",
                  style: TextStyle(
                    fontFamily: 'Georgia',
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              );
            }
            return ListView.builder(
              itemCount: state.medicines.length,
              itemBuilder: (context, index) {
                final medicine = state.medicines[index];
                return Card(
                  color: Colors.grey[850],
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: ListTile(
                    title: Text(
                      medicine.medicineName,
                      style: const TextStyle(
                        fontFamily: 'Georgia',
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      'Dosage: ${medicine.dosageMg} mg, Times per day: ${medicine.timesPerDay}',
                      style: const TextStyle(
                        fontFamily: 'Georgia',
                        color: Colors.grey,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.white),
                          onPressed: () {
                            _showMedicineForm(context, medicine: medicine);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            context.read<MedicineBloc>().add(DeleteMedicine(medicine.id));
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _showMedicineForm(BuildContext context, {Medicine? medicine}) {
    final nameController = TextEditingController(
        text: medicine != null ? medicine.medicineName : '');
    final dosageController = TextEditingController(
        text: medicine != null ? medicine.dosageMg.toString() : '');
    final timesController = TextEditingController(
        text: medicine != null ? medicine.timesPerDay.toString() : '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[800],
          title: Text(
            medicine != null ? 'Edit Medicine' : 'Add Medicine',
            style: const TextStyle(
              fontFamily: 'Georgia',
              color: Colors.white,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Medicine Name',
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              TextField(
                controller: dosageController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Dosage (mg)',
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              TextField(
                controller: timesController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Times per Day',
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[700],
              ),
              onPressed: () {
                if (medicine != null) {
                  context.read<MedicineBloc>().add(
                        UpdateMedicine(Medicine(
                          id: medicine.id,
                          medicineName: nameController.text,
                          dosageMg: int.parse(dosageController.text),
                          timesPerDay: int.parse(timesController.text),
                        )),
                      );
                } else {
                  context.read<MedicineBloc>().add(
                        AddMedicine(Medicine(
                          id: DateTime.now().millisecondsSinceEpoch,
                          medicineName: nameController.text,
                          dosageMg: int.parse(dosageController.text),
                          timesPerDay: int.parse(timesController.text),
                        )),
                      );
                }
                Navigator.pop(context);
              },
              child: const Text('Save', style: TextStyle(fontFamily: 'Georgia')),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(fontFamily: 'Georgia', color: Colors.grey)),
            ),
          ],
        );
      },
    );
  }
}

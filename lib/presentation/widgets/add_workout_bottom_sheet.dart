import 'package:cube_workouts/domain/bloc/workout_bloc.dart';
import 'package:cube_workouts/domain/bloc/workout_events.dart';
import 'package:cube_workouts/domain/bloc/workout_state.dart';
import 'package:cube_workouts/domain/models/workout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class AddWorkoutBottomSheet extends StatefulWidget {
  const AddWorkoutBottomSheet({super.key});

  @override
  State<AddWorkoutBottomSheet> createState() => _AddWorkoutBottomSheetState();
}

class _AddWorkoutBottomSheetState extends State<AddWorkoutBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _selectedImage;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (!mounted) {
      return;
    }
    setState(() {
      _selectedImage = image;
    });
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final state = context.read<WorkoutBloc>().state;
    var nextWorkoutId = DateTime.now().millisecondsSinceEpoch;

    if (state is WorkoutLoaded && state.workouts.isNotEmpty) {
      final maxId = state.workouts
          .map((workout) => workout.id)
          .reduce((a, b) => a > b ? a : b);
      nextWorkoutId = maxId + 1;
    }
    bool isFromfavorite =
        GoRouter.of(context).state.path?.contains("favorites") ?? false;

    final workout = Workout(
      id: nextWorkoutId,
      name: _nameController.text.trim(),
      exercises: const [],
      img: _selectedImage?.path,
      isFavorite: isFromfavorite,
    );

    context.read<WorkoutBloc>().add(WorkoutAdded(workout));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 12,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Workout',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
              ),
              OutlinedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.image_outlined),
                label: Text(
                  _selectedImage == null
                      ? 'Add Image (optional)'
                      : 'Change Image',
                ),
              ),
              if (_selectedImage != null)
                Text(
                  _selectedImage!.name,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit,
                  child: const Text('Save Workout'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

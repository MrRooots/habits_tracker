import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habits_tracker/core/constants/constants.dart';
import 'package:habits_tracker/core/services/extensions.dart';

import 'package:habits_tracker/core/themes/palette.dart';
import 'package:habits_tracker/features/domain/entities/habit_entity.dart';
import 'package:habits_tracker/features/presentation/bloc/habit/habit_bloc.dart';
import 'package:habits_tracker/features/presentation/pages/create_habit/components/selectable_day_chip.dart';
import 'package:habits_tracker/features/presentation/widgets/custom_snack_bar.dart';
import 'package:habits_tracker/features/presentation/widgets/default_button.dart';
import 'package:habits_tracker/features/presentation/pages/create_habit/components/dropdown_select.dart';
import 'package:habits_tracker/features/presentation/pages/create_habit/components/numeric_step_counter.dart';

class HabitFormBody extends StatefulWidget {
  final HabitEntity? habit;

  const HabitFormBody({super.key, this.habit});

  @override
  State<HabitFormBody> createState() => _HabitFormBodyState();
}

class _HabitFormBodyState extends State<HabitFormBody> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  /// Habit.frequency
  int _frequency = 0;

  /// Habit.type
  HabitType _habitType = HabitType.good;

  /// Habit.priority
  Priority _habitPriority = Priority.low;

  /// Habit.count
  int _dailyGoal = 1;

  /// Habit.title
  String get title => _titleController.text.capitalize();

  /// Habit.description
  String get description => _descriptionController.text.capitalize();

  @override
  void initState() {
    if (widget.habit != null) {
      _frequency = widget.habit!.frequency;
      _habitType = widget.habit!.type;
      _habitPriority = widget.habit!.priority;
      _dailyGoal = widget.habit!.count;
      _titleController.text = widget.habit!.title;
      _descriptionController.text = widget.habit!.description;
    }

    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTextInput(
          controller: _titleController,
          label: 'Title',
          hint: 'Enter title...',
          suffixIcon: const ImageIcon(
            AssetImage('assets/images/title_input.png'),
          ),
          isTitle: true,
        ),
        const SizedBox(height: 16.0),
        _buildTextInput(
          controller: _descriptionController,
          label: 'Description',
          hint: 'Enter description...',
          suffixIcon: const ImageIcon(AssetImage(
            'assets/images/description_input.png',
          )),
        ),
        const SizedBox(height: 16.0),
        const Text(
          'Repeat',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        const SizedBox(height: 16.0),
        NumericStepButton(
          initialValue: _dailyGoal,
          onChanged: (value) => setState(() => _dailyGoal = value),
        ),
        const SizedBox(height: 16.0),
        const Text(
          'Per',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        const SizedBox(height: 16.0),
        Row(
          children: Constants.frequencies.map(
            (final String frequency) {
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(
                    () => _frequency = Constants.frequencies.indexOf(frequency),
                  ),
                  child: SelectableDayChip(
                    day: frequency,
                    isSelected: frequency == Constants.frequencies[_frequency],
                  ),
                ),
              );
            },
          ).toList(),
        ),
        const SizedBox(height: 16.0),
        const Text(
          'Select type',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        const SizedBox(height: 16.0),
        Column(
          children: [
            RadioListTile(
              title: const Text('Good'),
              activeColor: Palette.lightGreen,
              value: HabitType.good,
              selected: _habitType == HabitType.good,
              selectedTileColor: Palette.lightGreenSalad.withOpacity(.1),
              groupValue: _habitType,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              onChanged: (final value) => setState(() => _habitType = value!),
            ),
            RadioListTile(
              title: const Text('Bad'),
              groupValue: _habitType,
              activeColor: Palette.lightRed,
              selected: _habitType == HabitType.bad,
              selectedTileColor: Palette.lightRed.withOpacity(.1),
              value: HabitType.bad,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              onChanged: (final value) => setState(() => _habitType = value!),
            )
          ],
        ),
        const SizedBox(height: 16.0),
        const Text(
          'Select priority',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        const SizedBox(height: 16.0),
        DropDownSelect(
          initialPriority: _habitPriority,
          onChanged: (value) => setState(() => _habitPriority = value),
        ),
        const SizedBox(height: 32.0),
        BlocConsumer<HabitBloc, HabitState>(
          listener: (context, state) {
            if (state.isCreateFailed || state.isEditFailed) {
              CustomSnackBar.showError(
                context,
                'Failed to save habit\n${state.message}',
              );
            } else if (state.isCreateSuccess || state.isEditSuccess) {
              Future.delayed(const Duration(milliseconds: 500))
                  .then((_) => Navigator.of(context).pop());
            }
          },
          builder: (context, state) {
            if (state.isLoading) {
              return DefaultButton(
                onPressed: () {},
                buttonColor: Palette.lightGreenSalad,
                width: 70,
              );
            }

            return DefaultButton(
              onPressed: _onSubmitButtonPressed,
              buttonColor: Palette.lightGreenSalad,
              width: 250.0,
              text: widget.habit == null ? 'Add' : 'Save',
            );
          },
        ),
        const SizedBox(height: 16.0),
        const Text(
          '-- Long press on card to delete --',
          style: TextStyle(color: Palette.grey),
        ),
      ],
    );
  }

  /// Called when add or save submit button pressed. Determinate the event.
  ///
  /// If [widget.habit] == null then "create"
  /// Else "update"
  void _onSubmitButtonPressed() {
    widget.habit == null
        ? BlocProvider.of<HabitBloc>(context).add(CreateHabitEvent(
            title: title,
            description: description,
            type: _habitType,
            priority: _habitPriority,
            count: _dailyGoal,
            frequency: _frequency,
          ))
        : BlocProvider.of<HabitBloc>(context).add(UpdateHabitEvent(
            oldHabit: widget.habit!,
            title: title,
            description: description,
            type: _habitType,
            priority: _habitPriority,
            count: _dailyGoal,
            frequency: _frequency,
          ));
  }

  TextFormField _buildTextInput({
    required TextEditingController controller,
    required final String label,
    required final String hint,
    required final Widget suffixIcon,
    bool isNumbers = false,
    bool isTitle = false,
  }) {
    return TextFormField(
      controller: controller,
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      style: const TextStyle(decoration: TextDecoration.none),
      keyboardType: isNumbers ? TextInputType.number : TextInputType.text,
      maxLines: 4,
      minLines: 1,
      inputFormatters: [
        LengthLimitingTextInputFormatter(isTitle ? 32 : 128),
      ],
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIconConstraints: const BoxConstraints(
          maxHeight: 32.0,
          maxWidth: 32.0,
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}

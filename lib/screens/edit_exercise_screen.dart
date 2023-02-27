import 'package:bloc_journey/bloc/workout_cubit.dart';
import 'package:bloc_journey/models/workout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numberpicker/numberpicker.dart';

import '../helpers/helpers.dart';

class EditExerciseScreen extends StatefulWidget {
  final Workout? workout;
  final int index;
  final int exIndex;
  const EditExerciseScreen({Key? key, this.workout, required this.index, required this.exIndex}) : super(key: key);

  @override
  State<EditExerciseScreen> createState() => _EditExerciseScreenState();
}

class _EditExerciseScreenState extends State<EditExerciseScreen> {
  TextEditingController? _title;
  @override
  void initState() {

    _title = TextEditingController(
      text: widget.workout!.exercises[widget.exIndex].title
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
     children: [
       Row(
         children: [
           Expanded(child: InkWell(
             child: NumberPicker(
               minValue: 0,
               maxValue: 3599,
               value: widget.workout!.exercises[widget.exIndex].prelude!,
              onChanged: (value)=>setState(() {
                widget.workout!.exercises[widget.exIndex] = widget.workout!.exercises[widget.exIndex].copyWith(
                    prelude: value
                );
                BlocProvider.of<WorkoutCubit>(context).saveWorkout(widget.workout!, widget.index);
              }),
               textMapper: (strVal)=>formatTime(int.parse(strVal),false),

             ),
           )),
           Expanded(
             flex: 3,
               child: TextField(
             textAlign: TextAlign.center,
             controller: _title,
             onChanged: (value)=>setState(() {
              widget.workout!.exercises[widget.exIndex] = widget.workout!.exercises[widget.exIndex].copyWith(
                title: value
              );
              BlocProvider.of<WorkoutCubit>(context).saveWorkout(widget.workout!, widget.index);
             })
           )),
           Expanded(child: InkWell(
             child: NumberPicker(
               minValue: 0,
               maxValue: 3599,
               value: widget.workout!.exercises[widget.exIndex].duration!,
               onChanged: (value)=>setState(() {
                 widget.workout!.exercises[widget.exIndex] = widget.workout!.exercises[widget.exIndex].copyWith(
                     duration: value
                 );
                 BlocProvider.of<WorkoutCubit>(context).saveWorkout(widget.workout!, widget.index);
               }),
               textMapper: (strVal)=>formatTime(int.parse(strVal),false),

             ),
           )),
         ],
       )
     ],
    );
  }
}

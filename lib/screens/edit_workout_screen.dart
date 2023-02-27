import 'package:bloc_journey/bloc/exercise_workout_cubit.dart';
import 'package:bloc_journey/helpers/helpers.dart';
import 'package:bloc_journey/screens/edit_exercise_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/states/workout_state.dart';

class EditWorkOutScreen extends StatelessWidget {
  const EditWorkOutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: BlocBuilder<ExerciseWorkOutCubit,WorkoutState>(
               builder: (context,state){
                 WorkoutEditing wo = state as WorkoutEditing;
                 return Scaffold(
                   appBar: AppBar(
                     title: Text(wo.workout!.title.toString()),
                     leading: BackButton(
                         onPressed: ()=>BlocProvider.of<ExerciseWorkOutCubit>(context).goHome()
                     ),
                   ),
                   body: ListView.builder(
                     itemCount: wo.workout!.exercises.length,
                       itemBuilder: (context,index){
                         print('index: $index, wo.exIndex: ${wo.exIndex}');
                       if(wo.exIndex != null && wo.exIndex == index){
                         return EditExerciseScreen(workout : wo.workout,index: index, exIndex: wo.exIndex!);
                       }else{
                         return ListTile(
                           leading:Text(formatTime(wo.workout!.exercises[index].prelude!, true)),
                           title:Text(wo.workout!.exercises[index].title!),
                           onTap: ()=>BlocProvider.of<ExerciseWorkOutCubit>(context).editExercise(index),
                           trailing:Text(formatTime(wo.workout!.exercises[index].duration!, true)),

                         );

                       }


                       }
                   ),
                 );
               },
        ),
        onWillPop: ()=>BlocProvider.of<ExerciseWorkOutCubit>(context).goHome()

    );
  }
}

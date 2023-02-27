import 'package:bloc_journey/bloc/states/workout_state.dart';
import 'package:bloc_journey/models/workout.dart';
import 'package:bloc_journey/screens/edit_workout_screen.dart';
import 'package:bloc_journey/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/exercise_workout_cubit.dart';
import 'bloc/workout_cubit.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
          providers: [
      BlocProvider<WorkoutCubit>(
      create: (BuildContext context){
          WorkoutCubit workoutCubit = WorkoutCubit();
          if(workoutCubit.state.isEmpty){
          workoutCubit.getWorkouts();
          }
            return workoutCubit;
        }),
            BlocProvider<ExerciseWorkOutCubit>(
                create: (BuildContext context)=>ExerciseWorkOutCubit())
      ],
        child: BlocBuilder<ExerciseWorkOutCubit,WorkoutState>(
            builder: (context,state){
              if(state is WorkoutInitial){
                return HomePage();
              }else if(state is WorkoutEditing){
                return EditWorkOutScreen();
              }
              return Container();
            },
        ),
    )

    );
  }
}

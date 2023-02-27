import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_journey/bloc/states/workout_state.dart';
import 'package:bloc_journey/models/exercise.dart';
import 'package:flutter/services.dart';

import '../models/workout.dart';

class WorkoutCubit extends Cubit<List<Workout>>{
  WorkoutCubit():super([]);

  getWorkouts() async {
    List<Workout> workouts = [];
    final workoutJson = jsonDecode(await rootBundle.loadString("assets/workouts.json"));
    for(var el in (workoutJson as Iterable)){
      workouts.add(Workout.fromJson(el));
    }
    emit(workouts);
  }

  saveWorkout(Workout workout, int index){
    Workout newWorkOut =  Workout(title: workout.title, exercises: []);
    int exIndex=0;
    int startTime = 0;

    for(var el in workout.exercises){
      newWorkOut.exercises.add(
        Exercise(
            title: el.title,
            prelude: el.prelude,
            duration: el.duration,
            index: el.index,
            startTime: el.index
        )
      );
      exIndex++;
      startTime += el.prelude! + el.duration!;
    }
    state[index] = newWorkOut;
    emit([...state]);
  }
}
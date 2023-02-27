import 'package:bloc_journey/bloc/workout_cubit.dart';
import 'package:bloc_journey/helpers/helpers.dart';
import 'package:bloc_journey/models/workout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/exercise_workout_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Trainer'),
        actions: const [
          IconButton(onPressed: null, icon: Icon(Icons.event)),
          IconButton(onPressed: null, icon: Icon(Icons.settings))
        ],
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<WorkoutCubit,List<Workout>>(
          builder:(context,workouts)=>
            ExpansionPanelList.radio(
              children: workouts.map((e) => ExpansionPanelRadio(
                  value: e,
                  headerBuilder: (BuildContext context, bool isExpanded)=>ListTile(
                   visualDensity: const VisualDensity(
                     horizontal: 0,vertical: VisualDensity.maximumDensity
                   ),
                   leading: IconButton(
                     onPressed: (){
                       BlocProvider.of<ExerciseWorkOutCubit>(context).editWorkout(e, workouts.indexOf(e));
                     }
                     ,icon: Icon(Icons.edit),
                   ),
                   title: Text(e.title!),
                    trailing: Text(formatTime(e.getTotal(), true)),
                  ),
                  body: ListView.builder(
                    shrinkWrap: true,
                      itemCount: e.exercises.length,
                      itemBuilder: (BuildContext context,idx)=>
                         ListTile(
                           onTap: null,
                           visualDensity: const VisualDensity(horizontal: 0, vertical:VisualDensity.maximumDensity,
                           ),
                           leading:Text(formatTime(e.exercises[idx].prelude!, true)),
                         trailing: Text(formatTime(e.exercises[idx].duration!, true)),
                         title:  Text(e.exercises[idx].title!),
                         )
                  ))).toList(),
            )
        ),
      ),
    );
  }
}

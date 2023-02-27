
import 'package:bloc/bloc.dart';
import 'package:bloc_journey/bloc/states/workout_state.dart';
import 'package:bloc_journey/models/workout.dart';

class ExerciseWorkOutCubit extends Cubit<WorkoutState>{
      ExerciseWorkOutCubit():super( const WorkoutInitial());

      editWorkout(Workout workout,int index){
        return emit(WorkoutEditing(workout, index,null));
      }

      editExercise(int? exIndex){
        return emit(WorkoutEditing(state.workout, (state as WorkoutEditing).index, exIndex));
      }

      goHome(){
        emit (const WorkoutInitial());
      }

}
import 'exercise.dart';
import 'package:equatable/equatable.dart';

class Workout extends Equatable{
  final String? title;
  final List<Exercise> exercises;

  Workout({
    required this.title,
    required this.exercises,
  });

  factory Workout.fromJson(Map<String, dynamic> json) {
    List<Exercise> exercises =  [];
    int index = 0;
    int startTime = 0;
    for(var el in (json['exercises'] as Iterable)){
      exercises.add(Exercise.fromJson(el, index, startTime));
      index++;
      startTime = exercises.last.prelude! + exercises.last.duration!;
    }


    return Workout(
      title: json['title'] as String?,
      exercises: exercises,
    );



  }


  Map<String, dynamic> toJson() => {
    'title': title,
    'exercises': exercises,
  };

  int getTotal(){
    int totalTime = exercises.fold(0, (previousValue, element) => previousValue + element.prelude! + element.duration!);
    return totalTime;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [title,exercises];

   @override
  // TODO: implement stringify
  bool? get stringify => true;

}
import 'package:flutter_test/flutter_test.dart';
import 'package:work_around/models/user_set.dart';
import 'package:work_around/services/exercise_service.dart';

void main(){
  ExerciseService exerciseService = ExerciseService();
  UserSet set;

  group('Exercise Service Tests', (){
    setUp((){
      set = UserSet(setId: '1', exerciseId: '1', effort: 60, isCompleted: false);
    });

    test('isSetWithinDuration returns true when set is within duration', (){
      exerciseService.setWorkoutDuration(Duration(minutes: 2));
      bool isWithinDuration = exerciseService.isSetWithinDuration(set);
      expect(isWithinDuration, true);
    });

    test('isSetWithinDuration returns false when set is not within duration', (){
      exerciseService.setWorkoutDuration(Duration(seconds: 45));
      bool isWithinDuration = exerciseService.isSetWithinDuration(set);
      expect(isWithinDuration, false);
    });

    test('isSetWithinDuration returns true when set is already completed', (){
      set.isCompleted = true;
      exerciseService.setWorkoutDuration(Duration(minutes: 2));
      bool isWithinDuration = exerciseService.isSetWithinDuration(set);
      expect(isWithinDuration, true);
    });
  });
}
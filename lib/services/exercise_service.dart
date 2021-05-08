import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:work_around/models/ExerciseSet.dart';
import 'package:work_around/models/exercise.dart';
import 'package:work_around/models/exercise_data.dart';
import 'package:work_around/models/user_exercise.dart';
import 'package:work_around/models/user_set.dart';
import 'package:work_around/models/workout.dart';
import 'package:work_around/models/workout_data.dart';
import 'package:work_around/services/authentication_service.dart';
import 'package:work_around/services/repository/exercise_repository.dart';
import 'package:work_around/services/repository/workout_repository.dart';

class ExerciseService {
  final AuthenticationService _authenticationService;
  final ExerciseRepository _exerciseRepository;
  final WorkoutRepository _workoutRepository;
  final ExerciseData _exerciseData;
  final WorkoutData _workoutData;

  bool isEditPath = false;

  setEditPath(bool editPath) {
    isEditPath = editPath;
  }

  //MAKE THESE PRIVATE
  List<UserExercise> historyExercises = [];
  List<UserSet> historySets = [];
  List<UserExercise> newExercises = [];
  List<UserSet> newExercisesSets = [];
  String workoutId;
  String get currentWorkoutId => workoutId;

  String workoutIdToEdit;
  String get getWorkoutIdToEdit => workoutIdToEdit;

  String newTempWorkoutId;
  String get getNewTempWorkoutId => newTempWorkoutId;

  String workoutHistoryId;
  String get getWorkoutHistoryId => workoutHistoryId;

  String exerciseId;
  String get currentExerciseId => exerciseId;

  String exerciseIdToEdit;
  String get getExerciseIdToEdit => exerciseIdToEdit;

  String exerciseHistoryId;
  String get getExerciseHistoryId => exerciseHistoryId;

  String setId;
  String get currentSetId => setId;

  String tempWorkoutId;
  String get newWorkoutId => tempWorkoutId;

  String tempExerciseId;
  String get newExerciseId => tempExerciseId;

  String tempSetId;
  String get newSetId => tempSetId;

  void setCurrentWorkoutId(String id) {
    workoutId = id;
  }

  void setCurrentEditWorkoutId(String id) {
    workoutIdToEdit = id;
  }

  setNewTempWorkoutId(String id) {
    newTempWorkoutId = id;
  }

  setWorkoutHistoryId(String id) {
    workoutHistoryId = id;
  }

  void setCurrentExerciseId(String id) {
    exerciseId = id;
  }

  setCurrentExerciseIdToEdit(String id) {
    exerciseIdToEdit = id;
  }

  setExerciseHistoryId(String id) {
    exerciseHistoryId = id;
  }

  void setCurrentSetId(String id) {
    setId = id;
  }

  void setNewWorkoutId(String id) {
    tempWorkoutId = id;
  }

  void setNewExerciseId(String id) {
    tempExerciseId = id;
  }

  void setNewSetId(String id) {
    tempExerciseId = id;
  }

  ExerciseService(this._authenticationService, this._exerciseData,
      this._workoutData, this._exerciseRepository, this._workoutRepository);

  Stopwatch _workoutTimer = Stopwatch();
  Duration _initialWorkoutDuration;
  Duration _workoutDuration;

  void setTemp(Workout temp) => _workoutData.setTempWorkout(temp);

  void addWorkout(String workoutName) {
    _workoutData.temp.name = workoutName;
    _workoutData.workouts.add(_workoutData.temp);
  }

  void addToTempWorkout(UserExercise exercise) {
    newExercises.add(exercise);
  }

  void addToHistoricExercises(UserExercise exercise) {
    historyExercises.add(exercise);
  }

  void addToHistoricSets(UserSet set) {
    historySets.add(set);
  }

  UserExercise getTempWorkout(int index) {
    return newExercises[index];
  }

  UserExercise getExerciseFromHistory(int index) {
    return historyExercises[index];
  }

  UserSet getSetFromHistory(int index) {
    return historySets[index];
  }

  Workout getWorkout(int index) {
    return _workoutData.workouts[index];
  }

  int getNumOfExercises() {
    return _workoutData.temp.exerciseList.length;
  }

  int getNumOfWorkouts() {
    return _workoutData.workouts.length;
  }

  void generateSets(Duration duration, List<Exercise> workout) {
    _exerciseData.generateSets(duration, workout);
  }

  String getCurrentWorkoutId() {
    return workoutId;
  }

  void startWorkoutTimer() {
    _workoutTimer.start();
  }

  Duration getWorkoutTimeElapsed() {
    return _workoutTimer.elapsed;
  }

  void setInitialWorkoutDuration(Duration duration) {
    _initialWorkoutDuration = duration;
    _workoutDuration = duration;
  }

  void setWorkoutDuration(Duration duration) {
    _workoutDuration = duration;
  }

  Duration getInitialWorkoutDuration() {
    return _initialWorkoutDuration;
  }

  bool isSetWithinDuration(UserSet set) {
    bool withinDuration;
    if (set.isCompleted) {
      withinDuration = true;
      return withinDuration;
    }
    if (_workoutDuration -
            Duration(seconds: int.parse(set.effort.toString())) >=
        Duration.zero) {
      _workoutDuration -= Duration(seconds: int.parse(set.effort.toString()));
      withinDuration = true;
      return withinDuration;
    }
    return false;
  }

  List<UserSet> resetList = [];
  addSetToResetList(UserSet set) => resetList.add(set);
  resetResetList() => resetList.clear();

  Map<String, int> effortMap = {
    'Bicep Curl': 60,
    'Hammer Curl': 60,
    'Barbell Curl': 60,
    'Goblet Curl': 60,
    'Single Arm Curl': 60,
    'Preacher Curl': 60,
    'Concentration Curl': 60,
    'Chin-Ups': 60,
    'Biceps Stretch': 60,
    'Biceps Stretch II': 60,
    'Chest Stretch': 60,
    'Chest Stretch II': 60,
    'Dips': 60,
    'Push Ups': 60,
    'Bench Dips': 60,
    'Diamond Push Ups': 60,
    'Barbell Bench Press': 60,
    'Incline Barbell Bench Press': 60,
    'Dumbbell Flys': 60,
    'Dumbbell Bench Press': 60,
    'Incline Dumbbell Press': 60,
    'Chest Press': 60,
    'Single Arm Press': 60,
    'Single Arm Chest Fly': 60,
    'Abdominal Stretch': 60,
    'Abdominal Stretch II': 60,
    'Crunches': 60,
    'Laying Leg Raises': 60,
    'Hanging Knee Raises': 60,
    'Forearm Plank': 60,
    'Barbell Roll-Outs': 60,
    'Windmill': 60,
    'Kettlebell Situp': 60,
    'Woodchopper': 60,
    'Russian Twist': 60,
    'Barbell Overhead Press': 60,
    'Side Lateral Raises': 60,
    'Front Raises': 60,
    'Shoulder Stretch': 60,
    'Shoulder Stretch II': 60,
    'Elevated Pike Press': 60,
    'Bent-Over Rear Delt Fly': 60,
    'Kettlebell Front Raise': 60,
    'Rear Delt Row': 60,
    'Single Arm Lateral Raise': 60,
    'Traps Stretch': 60,
    'Traps Stretch II': 60,
    'Barbell Silverback Shrugs': 60,
    'Seated DB Shrugs': 60,
    'Upright Row': 60,
    'Shrugs': 60,
    'Kettlebell Silverback Shrugs': 60,
    'Forearms Stretch': 60,
    'Forearms Stretch II': 60,
    'Reverse Curl': 60,
    'Barbell Wrist Curl': 60,
    'Wrist Curl': 60,
    'Wrist Extension': 60,
    'Farmers Carry': 60,
    'Quads Stretch': 60,
    'Quads Stretch II': 60,
    'Squats': 60,
    'Forward Lunges': 60,
    'Bulgarian Split Squats': 60,
    'Jump Squats': 60,
    'Side Lunges': 60,
    'Barbell Squats': 60,
    'Barbell Curtsy Lunge': 60,
    'Goblet Squat': 60,
    'Step Up': 60,
    'Triceps Stretch': 60,
    'Triceps Stretch II': 60,
    'Laying Triceps Extensions': 60,
    'Close Grip Bench Press': 60,
    'Seated Tricep Extensions': 60,
    'Decline Skull Crusher': 60,
    'Tate Press': 60,
    'Standing Tricep Extensions': 60,
    'Skull Crusher': 60,
    'Traps (mid-back) Stretch': 60,
    'Pull Ups': 60,
    'Lats Stretch': 60,
    'Lats Stretch II': 60,
    'Bent Over Barbell Row': 60,
    'Dumbbell Row': 60,
    'Kettlebell Row': 60,
    'Single Arm Row': 60,
    'Pullover': 60,
    'Shoulder Extensions': 60,
    'Lower Back Stretch': 60,
    'Lower Back Stretch II': 60,
    'Lower Back Stretch III': 60,
    'Good Mornings': 60,
    'Supermans': 60,
    'Deadlift': 60,
    'Staggered Deadlift': 60,
    'Kettlebell Swing': 60,
    'Goblet Good Morning': 60,
    'Kettlebell Deadlift': 60,
    'Glutes Stretch': 60,
    'Glutes Stretch II': 60,
    'Glute Bridge': 60,
    'Single Leg Glute Bridge': 60,
    'Barbell Hip Thrust': 60,
    'Kettlebell Hip Thrust': 60,
    'Kettlebell Glute Bridge': 60,
    'Single Leg Hip Thrust': 60,
    'Hamstrings Stretch': 60,
    'Hamstrings Stretch II': 60,
    'Single Legged Romanian Deadlifts': 60,
    'Kickbacks': 60,
    'Nordic Hamstring Curl': 60,
    'Stiff Leg Deadlift': 60,
    'Single Leg Deadlift': 60,
    'Calves Stretch': 60,
    'Calves Stretch II': 60,
    'Walking Calf Raises': 60,
    'Calf Raises': 60,
    'Barbell Calf Raises': 60,
    'Seated Calf Raises': 60,
    'Single Leg Calf Raises': 60,
  };

  List<UserExercise> get exercises => _exercises;

  List<UserExercise> _exercises = [
    UserExercise(
      name: 'Bicep Curl',
      instructions: '1. Stand up straight with a dumbbell in each hand at arm\'s length.\n2. Raise one dumbbell and twist your forearm until it is vertical and your palm faces the shoulder.\n3. Lower to original position and repeat with opposite arm',
      gifUrl: 'https://musclewiki.com/media/uploads/BicepCurl-Front-021316.gif',
      muscleGroup: 'Biceps',
      equipment: 'Dumbbells',
    ),
    UserExercise(
      name: 'Hammer Curl',
      instructions: '1. Hold the dumbbells with a neutral grip (thumbs facing the ceiling).\n2. Slowly lift the dumbbell up to chest height.\n3. Return to starting position and repeat.',
      gifUrl: 'https://musclewiki.com/media/uploads/female-hammer-curl-front.gif',
      muscleGroup: 'Biceps',
      equipment: 'Dumbbells',
    ),
    UserExercise(
      name: 'Barbell Curl',
      instructions: '1. Stand up straight with a dumbbell in each hand at arm\'s length.\n2. Raise one dumbbell and twist your forearm until it is vertical and your palm faces the shoulder.\n3. Lower to original position and repeat with opposite arm',
      gifUrl: 'https://musclewiki.com/media/uploads/female-barbell-bicep-curl-front.gif',
      muscleGroup: 'Biceps',
      equipment: 'Barbell',
    ),
    UserExercise(
      name: 'Goblet Curl',
      instructions: '1. Stand up straight with a kettlebell in both hands in front of your pelvis.\n2. Raise the kettlebell bending your arms at the elbow until the kettlebell is level with your chest.\n3. Lower to the starting position and repeat.',
      gifUrl: 'https://musclewiki.com/media/uploads/kettlebell-female-goblet-curl-front.gif',
      muscleGroup: 'Biceps',
      equipment: 'kettlebell',
    ),
    UserExercise(
      name: 'Single Arm Curl',
      instructions: '1. Stand up straight with a kettlebell in one hand with your forearm facing out.\n2. Raise the kettlebell, bending your arm at the elbow and keeping your forearm vertical until your palm faces the shoulder.\n3. Lower to the starting position and repeat.',
      gifUrl: 'https://musclewiki.com/media/uploads/kettlebell-female-sacurl-front.gif',
      muscleGroup: 'Biceps',
      equipment: 'Dumbbells Kettlebell',
    ),
    UserExercise(
      name: 'Preacher Curl',
      instructions: '1. Stand behind a bench, with your chest leaning over the edge of the bench.\n2. With one arm resting on the bench, hold the kettlebell, bending the arm at the elbow.\n3. Lower your arm using the bench as a guide, keeping your forearm straight.\n4. Return to the starting position and repeat.',
      gifUrl: 'https://musclewiki.com/media/uploads/kettlebell-female-preacher-curl-front_QSjBfea.gif',
      muscleGroup: 'Biceps',
      equipment: 'Dumbbells Kettlebell Bench',
    ),
    UserExercise(
      name: 'Concentration Curl',
      instructions: '1. Sitting on a chair with your legs apart, rest your arm against your thigh and hold the kettlebell with your arm extended towards the floor.\n2. Bending your arm at the elbow, lift the kettlebell until your palm faces your shoulder.\n3. Lower to the starting position and repeat.',
      gifUrl: 'https://musclewiki.com/media/uploads/kettlebell-female-Concentration_Curl-front.gif',
      muscleGroup: 'Biceps',
      equipment: 'Dumbbells',
    ),
    UserExercise(
      name: 'Chin-Ups',
      instructions: '1. Grab the bar shoulder width apart with a supinated grip (palms facing you).\n2. With your body hanging and arms fully extended, pull yourself up until your chin is past the bar.\n3. Slowly return to starting position. Repeat.',
      gifUrl: 'https://musclewiki.com/media/uploads/bodyweight-female-chinup-side.gif',
      muscleGroup: 'Biceps Forearms',
      equipment: 'Hanging Bodyweight',
    ),
    UserExercise(
      name: 'Biceps Stretch',
      instructions: '1. Stand one foot in front of the other with the wall to your right, an arms width away.\n2. Place your hand on the wall, fingers pointing away from you.\n3. Gently lean forward, keeping your hand stationary.\n4. Repeat with the other arm.',
      gifUrl: 'https://musclewiki.com/media/uploads/female-strech-7-front_yjcaFA0.gif',
      muscleGroup: 'Biceps',
      equipment: 'Stretch',
    ),
    UserExercise(
      name: 'Biceps Stretch II',
      instructions: '1. Bend your arm at the elbow, raising your hand to your shoulder.\n2. Using your other hand, stretch the arm down to its full extent.',
      gifUrl: 'https://musclewiki.com/media/uploads/female-strech-17-front.gif',
      muscleGroup: 'Biceps',
      equipment: 'Stretch',
    ),
    UserExercise(
      name: 'Chest Stretch',
      instructions: 'Place your arms behind your back and clasp your hands together.\n2. Slowly extend your elbows until they are locked then lift them away from you.\n3. Pause in this position for a few seconds and then return them to starting position.',
      gifUrl: 'https://musclewiki.com/media/uploads/male-strech-14-front.gif',
      muscleGroup: 'Chest',
      equipment: 'Stretch',
    ),
    UserExercise(
      name: 'Chest Stretch II',
      instructions: '1. Raise your arms to shoulder height, fully extended in front of you.\n2. Slowly bring your arms behind your back still at shoulder height.\n3. Pause for a few seconds and then return to starting position.',
      gifUrl: 'https://musclewiki.com/media/uploads/male-strech-13-front.gif',
      muscleGroup: 'Chest',
      equipment: 'Stretch',
    ),
    UserExercise(
      name: 'Dips',
      instructions: '1. Hold your body with arms locked above the equipment\n2. Lower your body slowly while leaning forward, flare out your elbows\n3. Raise your body above the bars until your arms are locked.',
      gifUrl: 'https://musclewiki.com/media/uploads/bodyweight-male-dips-front_5pJM6Vh.gif',
      muscleGroup: 'Chest Triceps',
      equipment: 'Bodyweight',
    ),
    UserExercise(
      name: 'Push Ups',
      instructions: '1. Place your hands firmly on the ground, directly under shoulders.\n2. Flatten your back so your entire body is straight and slowly lower your body\n3. Draw shoulder blades back and down, keeping elbows tucked close to your body\n4. Exhale as you push back to the starting position.',
      gifUrl: 'https://musclewiki.com/media/uploads/bodyweight-male-pushup-front_jOCMyoK.gif',
      muscleGroup: 'Chest Triceps',
      equipment: 'Bodyweight',
    ),
    UserExercise(
      name: 'Bench Dips',
      instructions: '1. Grip the edge of the bench with your hands, Keep your feet together and legs straight.\n2. Lower your body straight down.\n3. Slowly press back up to the starting point.\nTIP: Make this harder by raising your feet off the floor and adding weight.',
      gifUrl: 'https://musclewiki.com/media/uploads/male-bench-tricep-dip-front_3xfJOT4.gif',
      muscleGroup: 'Chest Shoulders Triceps',
      equipment: 'Bodyweight',
    ),
    UserExercise(
      name: 'Diamond Push Ups',
      instructions: '1. Position your index fingers and thumbs so they’re touching, forming a diamond shape.\n2. Use a standard push up position.\n3. Lower your chest towards your hands, keep your elbows close to your body\n4. Stop just before your chest touches the floor, then push back up to the starting position.',
      gifUrl: 'https://musclewiki.com/media/uploads/bodyweight-male-diamondpushup-front.gif',
      muscleGroup: 'Chest Triceps',
      equipment: 'Bodyweight',
    ),
    UserExercise(
      name: 'Barbell Bench Press',
      instructions: '1. Lay flat on the bench with your feet on the ground. With straight arms unrack the bar.\n2. Lower the bar to your mid chest\n3. Raise the bar until you\'ve locked your elbows.',
      gifUrl: 'https://musclewiki.com/media/uploads/BenchPress-Side-021316.gif',
      muscleGroup: 'Chest',
      equipment: 'Bench Barbell',
    ),
    UserExercise(
      name: 'Incline Barbell Bench Press',
      instructions: '1. Position the bench between 30 and 45 degrees.\n2. Lay flat on the bench with your feet on the ground. With straight arms unrack the bar.\n3. Lower the bar to your mid chest\n4. Raise the bar (slowly and controlled) until you\'ve locked your elbows.',
      gifUrl: 'https://musclewiki.com/media/uploads/male-incline-barbell-press-front_5tlUnQ9.gif',
      muscleGroup: 'Chest',
      equipment: 'Bench Barbell',
    ),
    UserExercise(
      name: 'Dumbbell Flys',
      instructions: '1. Lay flat on the bench and place your feet on the ground.\n2. Begin the exercise with the dumbbells held together above your chest, elbows slightly bent.\n3. Simultaneously lower the weights to either side.\n4. Pause when the weights are parallel to the bench, then raise your arms to the starting position.',
      gifUrl: 'https://musclewiki.com/media/uploads/Flyes-Front-021316.gif',
      muscleGroup: 'Chest',
      equipment: 'Dumbbell Bench',
    ),
    UserExercise(
      name: 'Dumbbell Bench Press',
      instructions: '1. Lay flat on the bench with your feet on the ground. Raise the dumbbells until you have straight arms.\n2. Lower the dumbbells to your mid chest\n3. Raise the dumbbells until you\'ve locked your elbows.',
      gifUrl: 'https://musclewiki.com/media/uploads/dumbbell-benchpress-male-side.gif',
      muscleGroup: 'Chest',
      equipment: 'Dumbbell Bench',
    ),
    UserExercise(
      name: 'Incline Dumbbell Press',
      instructions: '1. Position your inur hands, keep your elbows close to your body\n4. Stop just before your chest touches the floor, then push back up to the starting position.',
      gifUrl: 'https://musclewiki.com/media/uploads/DumbbellCP-Side-021316.gif',
      muscleGroup: 'Chest',
      equipment: 'Dumbbell Bench',
    ),
    UserExercise(
      name: 'Chest Press',
      instructions: '1. Laying on the floor with your knees bent and feet firmly on the floor, hold the kettlebell at your chest with both hands.\n2. Fully extend your arms, raising the kettlebell until your elbows are locked.\n3. Lower the kettlebell to the starting position and repeat.',
      gifUrl: 'https://musclewiki.com/media/uploads/kettlebell-male-chest-press-front.gif',
      muscleGroup: 'Chest',
      equipment: 'Kettlebell',
    ),
    UserExercise(
      name: 'Single Arm Press',
      instructions: '1. Laying on the floor with your knees bent and feet firmly on the floor, leave one arm resting to the side of the body.\n2. Using the other arm, hold the kettlebell at arms length directly upwards of your shoulder.\n3. Lower your arm until your upper arm to elbow is resting on the floor.\n4. Return to starting position.',
      gifUrl: 'https://musclewiki.com/media/uploads/kettlebell-male-sa-chest-press-front.gif',
      muscleGroup: 'Chest',
      equipment: 'Kettlebell',
    ),
    UserExercise(
      name: 'Single Arm Chest Fly',
      instructions: 'Lie on the floor with your knees bent and feet firmly on the floor, with your arms to the side of your body.\n2. Holding a kettlebell in one hand, keeping your arm fully extended with a slight bend in the elbow and your forearms facing upwards, lift the kettlebell above your chest.\n3. Lower the kettlebell to the starting position and repeat.',
      gifUrl: 'https://musclewiki.com/media/uploads/kettlebell-male-SA-chest-fly-front.gif',
      muscleGroup: 'Chest',
      equipment: 'Kettlebell',
    ),
    UserExercise(
      name: 'Abdominals Stretch',
      instructions: '1. Lay on your stomach on the floor with your forearms flat on the ground.\n2. Extend your elbows and push your upper body upwards.\n3. Push your upper body upwards until you feel a stretch in your abs, then return to the starting position and repeat.',
      gifUrl: 'https://musclewiki.com/media/uploads/female-strech-4-side.gif',
      muscleGroup: 'Chest',
      equipment: 'Bodyweight',
    ),
    UserExercise(
      name: 'Abdominals Stretch II',
      instructions: '1. Reach up with your left arm and then lean slowly to the right. Lean until a stretch is felt in the obliques.\n2. Stand upright.\n3. After completing the desired amount of reps with the left arm, switch to the right arm and lean to the left.',
      gifUrl: 'https://musclewiki.com/media/uploads/female-strech-2-front.gif',
      muscleGroup: 'Chest',
      equipment: 'Bodyweight',
    ),
    UserExercise(
      name: 'Crunches',
      instructions: '1. Lay flat on your back with your knees bent and your feet flat on the ground, about a foot from your lower back.\n2. Place your fingertips on your temples with your palms facing out.\n3. Draw your belly into the base of your spine to engage the muscles, then raise your head and shoulders off the floor. Return to starting position and repeat.',
      gifUrl: 'https://musclewiki.com/media/uploads/female-crunches-side.gif',
      muscleGroup: 'Abdominals',
      equipment: 'Bodyweight',
    ),
    UserExercise(
      name: 'Laying Leg Raises',
      instructions: '1. Lay on your back with your arms palms down on either side.\n2. Keep your legs together and as straight as possible.\n3. Slowly raise your legs to a 90° angle, pause at this position, or as high as you can reach your legs, and then slowly lower your legs back down.\n4. Duration of these movements should be slow so that you do not utilize momentum, enabling you to get the most out of the exercise.',
      gifUrl: 'https://musclewiki.com/media/uploads/bodyweight-legraises-female-side.gif',
      muscleGroup: 'Abdominals',
      equipment: 'Bodyweight',
    ),
    UserExercise(
      name: 'Hanging Knee Raises',
      instructions: '1. Grab the bar and hang, your body still and your legs straight.\n2. Slowly draw your knees up to your chest\n3. Once you have raised your knees as high as possible, lower your legs and repeat. Duration of these movements should be slow so that you do not utilize momentum, enabling you to get the most out of the exercise.\n4. Duration of these movements should be slow so that you do not utilize momentum, enabling you to get the most out of the exercise.',
      gifUrl: 'https://musclewiki.com/media/uploads/bodyweight-female-hanging-knee-raises-side.gif',
      muscleGroup: 'Abdominals',
      equipment: 'Bodyweight Hanging',
    ),
    UserExercise(
      name: 'Forearm Plank',
      instructions: '1. Place forearms on the ground with your elbows bent at a 90° angle aligned beneath your shoulders, with your arms parallel at shoulder-width.\n2. Your feet should be together, with only your toes touching the floor.\n3. Lift your belly off the floor and form a straight line from your heels to the crown of your head and hold.',
      gifUrl: 'https://musclewiki.com/media/uploads/bodyweight-female-forearm-plank-side.gif',
      muscleGroup: 'Abdominals',
      equipment: 'Bodyweight',
    ),
    UserExercise(
      name: 'Barbell Roll-Outs',
      instructions: '1. Hold the Barbell with both hands and kneel on the floor with your feet up\n2. Slowly roll the Barbell straight forward, stretching your body into a straight position.\n3. After a pause at the stretched position, start pulling yourself back to the starting position. This should be a slow and controlled movement.',
      gifUrl: 'https://musclewiki.com/media/uploads/barbell-female-ab-rollout-front.gif',
      muscleGroup: 'Abdominals',
      equipment: 'Barbell',
    ),
    UserExercise(
      name: 'Windmill',
      instructions: '1. Stand with feet slightly wider than shoulder width apart. Hold the kettlebell in one hand and extend your arm above your head.\n2. Keeping your legs straight and the kettlebell above your head, lower the relaxed arm towards the ground, twisting your body towards the side of the raised arm.\n3. Return to the starting potion, tilt your pelvis forward and repeat.',
      gifUrl: 'https://musclewiki.com/media/uploads/kettlebell-female-windmill-front.gif',
      muscleGroup: 'Abdominals',
      equipment: 'Kettlebell',
    ),
    UserExercise(
      name: 'Kettlebell Situp',
      instructions: '1. Lay flat on your back with straight legs and hold the kettle bell above your chest at arm’s length.\n2. Draw your belly into the base of your spine to engage the muscles, then raise your head and shoulders off the floor with the kettlebell raised at arm’s length above your chest.\n3. Return to the starting position and repeat.',
      gifUrl: 'https://musclewiki.com/media/uploads/kettlebell-female-situp-side.gif',
      muscleGroup: 'Abdominals',
      equipment: 'Kettlebell',
    ),
    UserExercise(
      name: 'Woodchopper',
      instructions: '1. Stand with feet slightly wider than shoulder width apart and hold the kettle bell with both hands against your hip.\n2. Keeping your arms straight, swing the kettlebell upwards and across your body towards your shoulder, raising the kettlebell to head height rotating your hips as you do so.\n3. Return to the starting position and repeat.',
      gifUrl: 'https://musclewiki.com/media/uploads/kettlebell-female-woodchopper-front.gif',
      muscleGroup: 'Abdominals',
      equipment: 'Kettlebell',
    ),
    UserExercise(
      name: 'Russian Twist',
      instructions: '1. Sit on the floor with your legs bent, knees together and feet raised slightly off the floor.\n2. Starting on one side and sitting up straight with your core muscles engaged, lift the kettlebell off the floor with both hands and bring it across your body to the other side, rotating your chest towards the floor as you do so.\n3. Tap the kettlebell lightly on the floor and bring the kettlebell back across your body to the starting position, rotating your chest towards the floor.\n4. Repeat, keeping the legs bent and feet raised throughout the exercise.',
      gifUrl: 'https://musclewiki.com/media/uploads/DumbbellCP-Side-021316.gif',
      muscleGroup: 'Abdominals',
      equipment: 'Kettlebell',
    ),
    UserExercise(
      name: 'Barbell Overhead Press',
      instructions: '1. Start the barbell across your upper chest below your chin.\n2. Raise the barbell upwards and pause at the contracted position above your head.\n3. Lower the weights back to starting position.',
      gifUrl: 'https://musclewiki.com/media/uploads/barbell-male-overheadpress-side.gif',
      muscleGroup: 'Shoulders',
      equipment: 'Barbell',
    ),
    UserExercise(
      name: 'Side Lateral Raises',
      instructions: '1. Stand up straight with dumbbells at either side, palms facing your hips.\n2. Raise your arms on either side with a slight bend in your elbow until they are parallel with the floor. Pause at the top of the motion.\n3. Slowly return your arms down to starting position.',
      gifUrl: 'https://musclewiki.com/media/uploads/SideLateralRaise-Front-021316_FIRCTda.gif',
      muscleGroup: 'Shoulders',
      equipment: 'Dumbbell',
    ),
    UserExercise(
      name: 'Front Raises',
      instructions: '1. Grab two dumbbells while standing upright with the dumbbells at your side.\n2. Raise the two dumbbells with your elbows being fully extended until the dumbbells are eye level.\n3. Lower the weights in a controlled manner to the starting position and repeat.',
      gifUrl: 'https://musclewiki.com/media/uploads/dumbbell-male-frontraise-front.gif',
      muscleGroup: 'Shoulders',
      equipment: 'Dumbbell',
    ),
    UserExercise(
      name: 'Shoulder Stretch',
      instructions: '1. Reach one arm behind your body, with your elbow pointing upward behind your head.\n2. Assist the stretch with your other hand on your elbow to engage your shoulder.\n3. Pause for a few seconds, then repeat the stretch with your other arm.',
      gifUrl: 'https://musclewiki.com/media/uploads/male-strech-9-front.gif',
      muscleGroup: 'Shoulders',
      equipment: 'Stretch',
    ),
    UserExercise(
      name: 'Shoulder Stretch II',
      instructions: '1. Stand with you feet shoulder width apart. Place one arm across the front of your chest at shoulder height, press the forearm of your other arm above the elbow, hooking the stretching arm with your hand.\n2. Press the arm until it is straight and rotate your upper torso to engage the stretch even deeper.\n3. Repeat with your other arm.',
      gifUrl: 'https://musclewiki.com/media/uploads/male-strech-43-side_aZYiJHg.gif',
      muscleGroup: 'Shoulders Mid-Back',
      equipment: 'Stretch',
    ),
    UserExercise(
      name: 'Elevated Pike Press',
      instructions: '1. Use a bench or an object to elevate your feet.\n2. Lower your head towards the floor by bending your elbows\n3. Push through your hands and return to the starting pike position.\n4. Repeat',
      gifUrl: 'https://musclewiki.com/media/uploads/bodyweight-male-pikepushup-side.gif',
      muscleGroup: 'Shoulders Traps Triceps',
      equipment: 'Bodyweight',
    ),
    UserExercise(
      name: 'Bent-Over Rear Delt Fly',
      instructions: '1. With dumbbells in either hand, bend your knees with your feet slightly bowed out. Arch your back above your knees, and start with the weights touching in front of your chest.\n2. With bent elbows, raise your arms up to shoulder level, pausing at the at the end of the motion.\n3. Slowly lower your arms back to starting position.',
      gifUrl: 'https://musclewiki.com/media/uploads/RearDF-Side-021316.gif',
      muscleGroup: 'Shoulders',
      equipment: 'Dumbbells',
    ),
    UserExercise(
      name: 'Kettlebell Front Raise',
      instructions: '1. Stand up straight with feet shoulder width apart, holding the kettlebell in front of your pelvis.\n3. Keeping arms straight, raise the kettlebell slightly higher than head level.\n3. Return to the starting position and repeat.',
      gifUrl: 'https://musclewiki.com/media/uploads/kettlebell-male-frontraise-front.gif',
      muscleGroup: 'Shoulders',
      equipment: 'Kettlebell',
    ),
    UserExercise(
      name: 'Rear Delt Row',
      instructions: '1. Stand with your feet shoulder width apart, holding the kettlebell with both hands in front of your thighs.\n2. Bend forward at the hips bringing the kettlebell to the floor while you slightly bend your knees, keeping your back straight.\n3. Lift the kettlebell upwards towards your upper chest and then lower the kettlebell- repeat.',
      gifUrl: 'https://musclewiki.com/media/uploads/kettlebell-male-reardeltrow-side.gif',
      muscleGroup: 'Shoulders',
      equipment: 'Kettlebell Dumbbell',
    ),
    UserExercise(
      name: 'Single Arm Lateral Raise',
      instructions: '1. Stand with feet shoulder width apart holding a kettlebell with one hand at your side.\n2. Keeping your arm straight, swing the kettlebell up and out, away from your body to around head height.\n3. Return to the starting position and repeat.',
      gifUrl: 'https://musclewiki.com/media/uploads/kettlebell-male-salateralraise-front.gif',
      muscleGroup: 'Shoulders',
      equipment: 'Kettlebell Dumbbell',
    ),
    UserExercise(
      name: 'Traps Stretch',
      instructions: '1. Stand upright with your feet shoulder width apart.\n2. Place your left hand on your head and gently pull your head down towards your left shoulder. Then return to centre point.\n3. Repeat, using your right hand pulling towards your right shoulder.',
      gifUrl: 'https://musclewiki.com/media/uploads/female-strech-40-front.gif',
      muscleGroup: 'Traps',
      equipment: 'Stretch',
    ),
    UserExercise(
      name: 'Traps Stretch II',
      instructions: '1.Stand upright with your feet shoulder width apart.\n 2. Nod your head forward, bringing your chin to your chest.\n3. You will feel the stretch across your neck.',
      gifUrl: 'https://musclewiki.com/media/uploads/female-strech-38-front_puNUXtD.gif',
      muscleGroup: 'Traps',
      equipment: 'Stretch',
    ),
    UserExercise(
      name: 'Barbell Silverback Shrugs',
      instructions: '1. Stand with your feet shoulder width apart holding the Barbell with both hands in front just past shoulder width.\n2. Bend forward at the hips with a slight bend in your knees, keeping your back straight.\n3. Engage your shoulder blades, as if you are trying to touch them together.\n4. Release the shrug.',
      gifUrl: 'https://musclewiki.com/media/uploads/barbell-female-silverbackshrug-side.gif',
      muscleGroup: 'Traps',
      equipment: 'Barbell',
    ),
    UserExercise(
      name: 'Seated DB Shrugs',
      instructions: '1. Sit on a bench with dumbbells in both hands, palms facing your body, back straight.\n2. Elevate your shoulders and hold the contracted position at the apex of the motion.\n3. Slowly lower your shoulders back to starting position.',
      gifUrl: 'https://musclewiki.com/media/uploads/female-seated-db-shrugs-front.gif',
      muscleGroup: 'Traps',
      equipment: 'Dumbbell',
    ),
    UserExercise(
      name: 'Upright Row',
      instructions: '1. Stand with your feet shoulder width apart holding the kettlebell with both hands in front of your thighs.\n2. Bend forward at the hips bringing the kettlebell to the floor while you slightly bend your knees, keeping your back straight.\n3. Lift the kettlebell upwards towards your chest and lower - repeat.',
      gifUrl: 'https://musclewiki.com/media/uploads/kettlebell-female-uprightrow-side.gif',
      muscleGroup: 'Traps',
      equipment: 'Kettlebell',
    ),
    UserExercise(
      name: 'Shrugs',
      instructions: '1. Standing up straight with feet shoulder width apart.\n2. Holding the kettlebell in both hands in front of your pelvis, engage your shoulder blades, as if you are trying to touch them together.\n3. Release the shrug and repeat',
      gifUrl: 'https://musclewiki.com/media/uploads/kettlebell-female-shrug-front.gif',
      muscleGroup: 'Traps',
      equipment: 'Kettlebell',
    ),
    UserExercise(
      name: 'Kettlebell Silverback Shrugs',
      instructions: '1. Stand with your feet shoulder width apart holding the kettlebell with both hands in front of your thighs.\n2. Bend forward at the hips bringing the kettlebell to the floor while you slightly bend your knees, keeping your back straight.\n3. Holding the kettlebell in both hands engage your shoulder blades, as if you are trying to touch them together. Release the shrug.',
      gifUrl: 'https://musclewiki.com/media/uploads/kettlebell-female-silverbacksshrug-side.gif',
      muscleGroup: 'Traps',
      equipment: 'Kettlebell',
    ),
    UserExercise(
      name: 'Forearms Stretch',
      instructions: '1. Place your palm flush against the wall.\n2. Take one step forward and straighten your arm slowly to extend your bicep.\n3. Hold at the peak of the stretch.\n4. Return to starting position.',
      gifUrl: 'https://musclewiki.com/media/uploads/male-strech-7-side.gif',
      muscleGroup: 'Forearms',
      equipment: 'Stretch',
    ),
    UserExercise(
      name: 'Forearms Stretch II',
      instructions: '1. Place your hands together.\n2. Rotate your arms and hands 180°.\n3. Hold at the peak of the stretch.\n4. Return to starting position.',
      gifUrl: 'https://musclewiki.com/media/uploads/male-strech-18-front.gif',
      muscleGroup: 'Forearms',
      equipment: 'Stretch',
    ),
    UserExercise(
      name: 'Reverse Curl',
      instructions: '1. Grab an EZ bar (or barbell) with a shoulder width pronated (overhand) grip.\n2. Curl the weight until your forearms and your biceps touch one another.\n3. Lower the weight in a controlled manner and repeat.',
      gifUrl: 'https://musclewiki.com/media/uploads/dumbbell-reversecurl-male-front.gif',
      muscleGroup: 'Forearms',
      equipment: 'Barbell ',
    ),
    UserExercise(
      name: 'Barbell Wrist Curl',
      instructions: '1. Grab a straight bar with a supinated (underhand) grip.\n2. Kneel down next to a flat bench and place your forearms on the bench with your wrists just off the bench.\n3. Let the barbell pull down on your wrists until they are extended.\n4. Curl the barbell until your wrists are fully flexed.\n5. Lower in a controlled manner and repeat.',
      gifUrl: 'https://musclewiki.com/media/uploads/barbell-wristcurl-male-side.gif',
      muscleGroup: 'Forearms',
      equipment: 'Barbell',
    ),
    UserExercise(
      name: 'Wrist Curl',
      instructions: '1.Grip the dumbbell with your palm facing upwards with your forearm rested against the bench.\n2. Slowly curl your wrist upwards in a semicircular motion.\n3. Return to starting position and repeat.',
      gifUrl: 'https://musclewiki.com/media/uploads/ForearmCurls-Side-021316.gif',
      muscleGroup: 'Forearms',
      equipment: 'Dumbbell',
    ),
    UserExercise(
      name: 'Wrist Extension',
      instructions: '1. Stand up straight with a kettlebell in both hands in front of your pelvis, with your forearms facing inwards.\n2. Flex your wrist upwards until wrists are fully extended.\n3. Lower to the starting position and repeat.',
      gifUrl: 'https://musclewiki.com/media/uploads/kettlebell-male-wrist-extension-side.gif',
      muscleGroup: 'Forearms',
      equipment: 'Kettlebell',
    ),
    UserExercise(
      name: 'Farmers Carry',
      instructions: '1. Standing straight with a kettlebell in one hand, lift the knee of one leg off the floor to knee height.\n2. Bring the leg back to standing and repeat with the other leg, keeping the kettlebell on the same side.\n3. Repeat.',
      gifUrl: 'https://musclewiki.com/media/uploads/kettlebell-male-farmers-carry-front.gif',
      muscleGroup: 'Forearms',
      equipment: 'Kettlebell',
    ),
    UserExercise(
      name: 'Quads Stretch',
      instructions: '1. Stand perpendicular to a wall, using one arm against the wall for balance. With your other arm, grab the top of your foot.\n2. Pull your leg upwards and back to engage your quads, pausing at the apex of the stretch for a few seconds.\n3. Return to starting position and repeat with your other leg.',
      gifUrl: 'https://musclewiki.com/media/uploads/female-strech-32-side_NIOMBXt.gif',
      muscleGroup: 'Quads',
      equipment: 'Stretch',
    ),
    UserExercise(
      name: 'Quads Stretch II',
      instructions: '1. Lay flat on your belly. Extend one arm out in front of you, placing your palm on the floor. With your other arm, grab the top of your foot.\n2. Keeping your upper leg flat on the floor, pull your foot towards your buttocks to engage the stretch.\n3. Pause for a few seconds, and then repeat the stretch with your other leg.',
      gifUrl: 'https://musclewiki.com/media/uploads/female-strech-29-side.gif',
      muscleGroup: 'Quads',
      equipment: 'Stretch',
    ),
    UserExercise(
      name: 'Squats',
      instructions: '1. Stand with your feet shoulder width apart.\n2. flex your knees and hips and sit back into the squat while lowering your body.\n3. Continue down to full depth.\n4. Return to starting position.',
      gifUrl: 'https://musclewiki.com/media/uploads/bodyweight-female-squat-side_euqQ2Jr.gif',
      muscleGroup: 'Quads Glutes Hamstrings',
      equipment: 'Bodyweight',
    ),
    UserExercise(
      name: 'Forward Lunges',
      instructions: '1. Step forward with one leg.\n2. Lower your body until your rear knee nearly touches the ground.\n3. Ensure you remain upright, and your front knee stay above the front foot.\n4. Push off the floor with your front foot until you return to the starting position. Switch legs.',
      gifUrl: 'https://musclewiki.com/media/uploads/bodyweight-female-frontlunge-side.gif',
      muscleGroup: 'Quads Glutes',
      equipment: 'Bodyweight',
    ),
    UserExercise(
      name: 'Bulgarian Split Squats',
      instructions: '1. Stand with your back to a bench (or raised surface) and place one of your feet on the bench.\n2. Squat down until your front leg is about parallel to the floor.\n3. Go back to the starting position. After completing the desired amount of reps, switch legs and repeat.',
      gifUrl: 'https://musclewiki.com/media/uploads/bodyweight-female-bulgariansplitsquat-side.gif',
      muscleGroup: 'Quads Hamtstring',
      equipment: 'Bodyweight',
    ),
    UserExercise(
      name: 'Jump Squats',
      instructions: '1. Stand with your feet shoulder-width apart.\n2. Start by doing a regular squat, then engage your core and jump up explosively.\n3. When you land, lower your body back into the squat position.',
      gifUrl: 'https://musclewiki.com/media/uploads/bodyweight-female-jump-squats-side.gif',
      muscleGroup: 'Quads Glutes Hamstring',
      equipment: 'Bodyweight',
    ),
    UserExercise(
      name: 'Side Lunges',
      instructions: '1. Take a slow, lateral step to the right.\n2. Extend the left knee, and drive your weight into your right side.\n3. Flex your knee and lower your body.\n4. Push back to the starting position.',
      gifUrl: 'https://musclewiki.com/media/uploads/bodyweight-female-sidelunge-front.gif',
      muscleGroup: 'Quads Glutes',
      equipment: 'Bodyweight',
    ),
    UserExercise(
      name: 'Barbell Squats',
      instructions: '1. Stand with your feet shoulder-width apart. Maintain the natural arch in your back, squeezing your shoulder blades and raising your chest.\n2. Grip the bar across your shoulders and support it on your upper back. Unwrack the bar by straightening your legs, and take a step back.\n3. Bend your knees as you lower the weight without altering the form of your back until your hips are below your knees.\n4. Raise the bar back to starting position, lift with your legs and exhale at the top.',
      gifUrl: 'https://musclewiki.com/media/uploads/barbell-female-highbarsquat-front.gif',
      muscleGroup: 'Quads Glutes Hamstring',
      equipment: 'Barbell',
    ),
    UserExercise(
      name: 'Barbell Curtsy Lunge',
      instructions: '1. Place the barbell on your back\n2. Step your foot back and around while simultaneously bringing the weight down.\n3. Return to start and repeat on other leg.',
      gifUrl: 'https://musclewiki.com/media/uploads/barbell-female-curtsylunge-front.gif',
      muscleGroup: 'Quads Glutes Hamstring',
      equipment: 'Barbell',
    ),
    UserExercise(
      name: 'Goblet Squat',
      instructions: '1. Hold the weight tucked into your upper chest area, keeping your elbows in. Your feet should be slightly wider than shoulder width.\n2. Sink down into the squat, keeping your elbows inside the track of your knees.\n3. Push through your heels while keeping your chest up and return to starting position.',
      gifUrl: 'https://musclewiki.com/media/uploads/female-goblet-squat-front.gif',
      muscleGroup: 'Quads Glutes Hamstring',
      equipment: 'Dumbbell',
    ),
    UserExercise(
      name: 'Step Up',
      instructions: '1. Standing up straight, using a bench as a step, raise one foot onto the bench and hold the kettlebell in the same arm as the straight leg.\n2. Stand and bring both feet onto the bench. Slowly lower your leg back down to the starting position.\n3. Repeat.',
      gifUrl: 'https://musclewiki.com/media/uploads/kettlebell-female-stepup-front.gif',
      muscleGroup: 'Quads Glutes Hamstring',
      equipment: 'Kettlebell',
    ),
    UserExercise(
      name: 'Triceps Stretch',
      instructions: '1. Use the opposite hand to gently apply pressure to the elbow.\n2. Hold the stretch for a few seconds then repeat with the other arm.\n3. Raise your left arm above your head, and bend at the elbow so your hand is resting at the top of your back.',
      gifUrl: 'https://musclewiki.com/media/uploads/male-strech-9-side_GjerjGd.gif',
      muscleGroup: 'Triceps',
      equipment: 'Stretch',
    ),
    UserExercise(
      name: 'Triceps Stretch II',
      instructions: '1. Bend your left arm so your hand is at your shoulder, and hold your elbow with the opposite hand.\n2. Gently push on your elbow so it is raised by your head.\n3. Hold the stretch for a few seconds then repeat with the other arm.',
      gifUrl: 'https://musclewiki.com/media/uploads/male-strech-10-side.gif',
      muscleGroup: 'Triceps',
      equipment: 'Stretch',
    ),
    UserExercise(
      name: 'Laying Triceps Extensions',
      instructions: '1. Lay on a flat bench while holding a barbell with a shoulder-width grip.\n2. Fully extend your elbows until the barbell is directly over your chest.\n3. Begin to flex your elbows and allow the barbell to nearly touch your forehead.\n4. Extend your elbows back to the starting position and repeat.',
      gifUrl: 'https://musclewiki.com/media/uploads/barbell-male-laytingtricepextensions-side.gif',
      muscleGroup: 'Triceps',
      equipment: 'Barbell',
    ),
    UserExercise(
      name: 'Close Grip Bench Press',
      instructions: '1. Lay flat on the bench with your feet on the ground. With a narrow grip on the bar, straighten your arms\n2. Lower the bar to your lower-mid chest\n3. Slowly raise the bar until you\'ve locked your elbows.',
      gifUrl: 'https://musclewiki.com/media/uploads/barbell-male-closegripbenchpress-side.gif',
      muscleGroup: 'Triceps',
      equipment: 'Barbell',
    ),
    UserExercise(
      name: 'Seated Triceps Extensions',
      instructions: '1. Sit on the bench and hold a dumbbell with both hands. Raise the dumbbell overhead at arms length, holding the weight up with the palms of your hands.\n2. Keep your elbows in while you lower the weight behind your head, your upper arms stationary.\n3. Raise the weight back to starting position.',
      gifUrl: 'https://musclewiki.com/media/uploads/TricepExtensions-Side-021316.gif',
      muscleGroup: 'Triceps',
      equipment: 'Dumbbell',
    ),
    UserExercise(
      name: 'Decline Skull Crusher',
      instructions: '1. Lie on the floor with your upper back and soles of feet on the floor, knees bent, and pelvis and lower back suspended in the air.\n2. Hold the kettlebell in both hands directly above your chest.\n3. Keeping your upper arms in place, bend your elbows to bring the kettlebell to the floor above your head.\n4. Return the kettlebell to the starting position and repeat.',
      gifUrl: 'https://musclewiki.com/media/uploads/kettlebell-male-declineskullcrusher-side_nesXT5l.gif',
      muscleGroup: 'Triceps',
      equipment: 'Kettlebell',
    ),
    UserExercise(
      name: 'Tate Press',
      instructions: '1. Lie flat on your back. Keeping your arm straight, hold the kettlebell above your chest with your palm facing away from your body.\n2. Bend your arm, touching the kettlebell to the top of the shoulder opposite to the arm being worked.\n3. Return to the starting position and repeat.',
      gifUrl: 'https://musclewiki.com/media/uploads/kettlebell-male-tatepress-front.gif',
      muscleGroup: 'Triceps',
      equipment: 'Kettlebell',
    ),
    UserExercise(
      name: 'Standing Tricep Extensions',
      instructions: '1. Stand with legs shoulder width apart.\n2. Hold the kettlebell in both hands behind your head.\n3. Straighten arms bringing kettlebell above your head.\n4. Return to the starting position and repeat.',
      gifUrl: 'https://musclewiki.com/media/uploads/kettlebell-male-tricep-extension-side.gif',
      muscleGroup: 'Triceps',
      equipment: 'Kettlebell',
    ),
    UserExercise(
      name: 'Skull Crusher',
      instructions: '1. Stand with legs shoulder width apart.\n2. Hold the kettlebell in both hands behind your head.\n3. Straighten arms bringing kettlebell above your head.\n4. Return to the starting position and repeat.',
      gifUrl: 'https://musclewiki.com/media/uploads/kttlebell-male-skullcrusher-side.gif',
      muscleGroup: 'Triceps',
      equipment: 'Kettlebell',
    ),
    UserExercise(
      name: 'Traps (mid-back) Stretch',
      instructions: '1. Sit on the ground and lay one leg flat and the other over the top.\n2. Hold your leg with the same side arm and slowly rotate your hips and back.\n3. Hold at the peak of the stretch, then slowly return to starting position.\n4. Switch sides and repeat.',
      gifUrl: 'https://musclewiki.com/media/uploads/male-strech-23-side.gif',
      muscleGroup: 'Traps (mid-back)',
      equipment: 'Stretch',
    ),
    UserExercise(
      name: 'Pull Ups',
      instructions: '1. Grasp the bar with an overhand grip, arms and shoulders fully extended.\n2. Pull your body up until your chin is above the bar.\n3. Lower your body back to starting position.',
      gifUrl: 'https://musclewiki.com/media/uploads/bodyweight-male-pullup-side.gif',
      muscleGroup: 'Traps(Mid-Back) Lats',
      equipment: 'Bodyweight',
    ),
    UserExercise(
      name: 'Lats Stretch',
      instructions: '1. Stand up right and raise your hand to a full stretch above your head.\n2. Slowly lean across your body and trace the opposite hand down your leg.\n3. Hold at the bottom of the stretch, return to starting position and then switch sides.',
      gifUrl: 'https://musclewiki.com/media/uploads/male-strech-2-front.gif',
      muscleGroup: 'Lats',
      equipment: 'Stretch',
    ),
    UserExercise(
      name: 'Lats Stretch II',
      instructions: '1. Find a wall to lean against, lay your tricep against the wall with your hand behind your back.\n2. Slowly lean into the wall.\n3. Return to starting position, then switch sides.',
      gifUrl: 'https://musclewiki.com/media/uploads/male-strech-11-side.gif',
      muscleGroup: 'Lats',
      equipment: 'Stretch',
    ),
    UserExercise(
      name: 'Bent Over Barbell Row',
      instructions: '1. Grab a barbell with a shoulder width pronated or supinated grip.\n2. Bend forward at your hips while maintaining a flat back.\n3. Pull the weight toward your upper abdomen.\n4. Lower the weight in a controlled manner and repeat.',
      gifUrl: 'https://musclewiki.com/media/uploads/Male-bent-over-barbell-row-front_jwFqqeH.gif',
      muscleGroup: 'Lats',
      equipment: 'Barbell',
    ),
    UserExercise(
      name: 'Dumbbell Row',
      instructions: '1. Place your right leg on the top end of the bench so that your knee and shin rest flat on the bench, your foot hanging off the end.\n2. Bend your torso towards the floor and support yourself with your right arm by placing your palm flat against the bench.\n3. Grip the weight with your left and, and pull it straight up to the side of your chest. Repeat the motion.\n4. Switch the supporting leg and arm to work the other side.',
      gifUrl: 'https://musclewiki.com/media/uploads/DumbbellRow-Front-021316.gif',
      muscleGroup: 'Lats',
      equipment: 'Dumbbell',
    ),
    UserExercise(
      name: 'Kettlebell Row',
      instructions: '1. Stand with legs shoulder width apart.\n2. Hold the kettlebell in both hands behind your head.\n3. Straighten arms bringing kettlebell above your head.\n4. Return to the starting position and repeat.',
      gifUrl: 'https://musclewiki.com/media/uploads/kettlebell-male-row-side.gif',
      muscleGroup: 'Lats',
      equipment: 'Kettlebell',
    ),
    UserExercise(
      name: 'Single Arm Row',
      instructions: '1. Stand with your feet shoulder width apart, shifting one foot behind you. Hold the kettlebell in the same hand as the leg shifted backwards.\n2. Bend forwards at the hips bringing the kettlebell to the floor while you slightly bend your knee, keeping your back straight.\n3. Lift the kettlebell upwards towards your chest and lower - repeat.',
      gifUrl: 'https://musclewiki.com/media/uploads/kettlebell-male-sarow-side.gif',
      muscleGroup: 'Lats',
      equipment: 'Kettlebell',
    ),
    UserExercise(
      name: 'Pullover',
      instructions: '1. Rest your upper back on the bench and place soles of your feet firmly on the floor keeping torso and thighs suspended and parallel to the floor.\n2. Hold the kettlebell with both hands above your chest, keeping your arms straight.\n3. Keeping your arms straight, move the kettlebell in the direction of your head until your arms are parallel to the floor.\n4. Return to starting to position and repeat.',
      gifUrl: 'https://musclewiki.com/media/uploads/kettlebell-male-pullover-side.gif',
      muscleGroup: 'Lats',
      equipment: 'Kettlebell',
    ),
    UserExercise(
      name: 'Shoulder Extensions',
      instructions: '1. Stand with your feet shoulder width apart bending forward at the hips as far as comfortable. Place off-hand on the same side thigh for stability.\n2. Hold the kettlebell in one hand, straight armed and pointing towards the floor.\n3. Keeping your arm straight, swing the kettlebell behind you as far as comfortable.\n4. Return to the starting position and repeat.',
      gifUrl: 'https://musclewiki.com/media/uploads/kettlebell-male-shoulderextension-side.gif',
      muscleGroup: 'Lats',
      equipment: 'Kettlebell',
    ),
    UserExercise(
      name: 'Lower back Stretch',
      instructions: '1. Sit on the floor with the tops of your feet pointed and flat on the ground. Move your arms out in front of you in the diving position, placing your palms flat against the ground.\n2. With your arms fully extended, rest your buttocks on the heels of your feet, you can crawl your hands forward to extend the stretch if need be.\n3. Hold the extended position for a few seconds, and return to starting position.',
      gifUrl: 'https://musclewiki.com/media/uploads/female-strech-36-side.gif',
      muscleGroup: 'Lower Back',
      equipment: 'Stretch',
    ),
    UserExercise(
      name: 'Lower back Stretch II',
      instructions: '1. Lay flat on the floor with your arms at either side.\n2. With one leg, hook one foot under the joint of your other leg.\n3. Rotate your hips so that your knees are pointing sideways, keeping your hooked leg flat against the floor.\n4. Pause at the apex of the stretch and repeat with your other leg.',
      gifUrl: 'https://musclewiki.com/media/uploads/female-strech-35-front.gif',
      muscleGroup: 'Lower Back',
      equipment: 'Stretch',
    ),
    UserExercise(
      name: 'Lower back Stretch III',
      instructions: '1. Lay flat against the ground with your knees at an angle and your feet flat against the floor.\n2. Grab your legs just below the knees, and pull your legs towards your chest.\n3. Pause at the apex of the stretch, then return to the starting position.',
      gifUrl: 'https://musclewiki.com/media/uploads/female-strech-33-side.gif',
      muscleGroup: 'Lower Back',
      equipment: 'Stretch',
    ),
    UserExercise(
      name: 'Good Mornings',
      instructions: '1. Stand with your feet a little past shoulder width apart with a slight bend at your knee. Place your hands behind the back of your head.\n2. Keeping your back straight, rotate your hips to bring your shoulders down towards the floor. Stop when your chest is parallel with the floor.',
      gifUrl: 'https://musclewiki.com/media/uploads/bodyweight-female-goodmornings-side.gif',
      muscleGroup: 'Lower Back Glutes Hamstring',
      equipment: 'Bodyweight',
    ),
    UserExercise(
      name: 'Supermans',
      instructions: '1. Lie face down on the floor with your arms fully extended in front of you.\n2. Simultaneously raise your arms, legs and chest off of the floor and hold the position.\n3. Slowly lower your arms, legs and chest back to the starting position. Repeat.',
      gifUrl: 'https://musclewiki.com/media/uploads/bodyweight-female-superman-side_8oyEFmG.gif',
      muscleGroup: 'Lower Back',
      equipment: 'Bodyweight',
    ),
    UserExercise(
      name: 'Deadlift',
      instructions: '1. Stand with your mid-foot under the bar and grip the bar with your hands, about a shoulder width apart.\n2. Bend your knees, then lift the bar by straightening your back. It is important to keep your back straight.\n3. Stand to your full height and hold.\n4. Lower the bar to the floor by bending your knees and keeping your back straight.',
      gifUrl: 'https://musclewiki.com/media/uploads/female-deadlift-front.gif',
      muscleGroup: 'Lower Back Hamstring',
      equipment: 'Barbell',
    ),
    UserExercise(
      name: 'Staggered Deadlift',
      instructions: '1. Stand with your feet shoulder width apart, shifting one foot behind you. Hold the kettlebell in both hands in front of your thighs.\n2. Bend forward at the hips bringing the kettlebell to the floor while you slightly bend your knees and keep your back straight.\n3. Return to the upright position and repeat.',
      gifUrl: 'https://musclewiki.com/media/uploads/kettlebell-female-staggereddeadlift-side.gif',
      muscleGroup: 'Lower Back Hamstring',
      equipment: 'Kettlebell',
    ),
    UserExercise(
      name: 'Kettlebell Swing',
      instructions: '1. Stand with your feet slightly wider than shoulder width apart holding the kettlebell between your legs, with your knees slightly bent.\n2. Keeping your back straight, swing the kettlebell upwards until the kettlebell is level with your chest and carefully lower.\n3. Repeat',
      gifUrl: 'https://musclewiki.com/media/uploads/kettlebell-female-kb-swing-side.gif',
      muscleGroup: 'Lower Back Hamstring',
      equipment: 'Kettlebell',
    ),
    UserExercise(
      name: 'Goblet Good Morning',
      instructions: '1. Stand with your feet shoulder width apart holding the kettlebell with both hands in front of your chest.\n2. Bend forward at the hips keeping your back and knees straight and the kettlebell close to your chest.\n3. Return to standing position and thrust your pelvis forward.',
      gifUrl: 'https://musclewiki.com/media/uploads/kettlebell-female-gobletgoodmorning-side.gif',
      muscleGroup: 'Lower Back',
      equipment: 'Kettlebell',
    ),
    UserExercise(
      name: 'Kettlebell Deadlift',
      instructions: '1. Stand with your feet shoulder width apart holding the kettlebell with both hands in front of your thighs.\n2. Bend forward at the hips bringing the kettlebell to the floor while you slightly bend your knees, keeping your back straight.\n3. Return to standing position and repeat.',
      gifUrl: 'https://musclewiki.com/media/uploads/kettlebell-female-deadlift-front.gif',
      muscleGroup: 'Lower Back Hamstring',
      equipment: 'Kettlebell',
    ),
    UserExercise(
      name: 'Glutes Stretch ',
      instructions: '1. On your front, place one leg forward and then stretch out the same side arm across the mat/floor.\n2. Fully extend your leg and arm.\n3. Hold at the peak of the stretch, then slowly return to starting position.\n4. Switch sides and repeat.',
      gifUrl: 'https://musclewiki.com/media/uploads/male-strech-24-side.gif',
      muscleGroup: 'Glutes',
      equipment: 'Stretch',
    ),
    UserExercise(
      name: 'Glutes Stretch II',
      instructions: '1. Lay flat and bring your left leg to 90°.\n2. Hold your left leg with both hands and slowly rotate your hips to the right hand side.\n3. Hold at the peak of the stretch, then slowly return to starting position.\n4. Switch sides and repeat.',
      gifUrl: 'https://musclewiki.com/media/uploads/male-strech-22-side.gif',
      muscleGroup: 'Glutes',
      equipment: 'Stretch',
    ),
    UserExercise(
      name: 'Glute Bridge',
      instructions: '1. Lie down with your knees bent and your feet flat on the floor.\n2. Push your hips up so that your butt is elevated and your back straight.\n3. Tense your glutes and raise your hips towards the ceiling.\n4. Once you are at the highest point you can manage, hold the position for a few seconds, and then slowly return to the starting position',
      gifUrl: 'https://musclewiki.com/media/uploads/bodyweight-male-glutebridge-side.gif',
      muscleGroup: 'Glutes',
      equipment: 'Bodyweight',
    ),
    UserExercise(
      name: 'Single Leg Glute Bridge',
      instructions: '1. Lie down with one knee bent and and one with a slight bend.\n2. Push your hips up, so that your butt is elevated and your back straight.\n3. Tense your glutes and raise your hips towards the ceiling.\n4. Once you are at the highest point you can manage, hold the position for a few seconds, and then slowly return to the starting position.',
      gifUrl: 'https://musclewiki.com/media/uploads/bodyweight-slglutebridge-male-side.gif',
      muscleGroup: 'Glutes',
      equipment: 'Bodyweight',
    ),
    UserExercise(
      name: 'Barbell Hip Thrust',
      instructions: '1. Sit on the ground with a bench behind you. Have the barbell over your legs just above your hips.\n2. Lean back against the bench so that your shoulders are resting upon it, stretch your arms out to either side using the bench as support.\n3. Raise the weight by driving through your feet and extending your hips upwards. Support the weight with your shoulders and feet.\n4. Slowly extend as far as you can, and then slowly return to the starting position.',
      gifUrl: 'https://musclewiki.com/media/uploads/BarbellHT-Front-021316.gif',
      muscleGroup: 'Glutes',
      equipment: 'Barbell',
    ),
    UserExercise(
      name: 'Kettlebell Hip Thrust',
      instructions: '1. Sitting on the floor with your knees bent and feet planted firmly on the floor, lean your back against the bench.\n2. Resting the kettlebell on your pelvis, raise your pelvis until your stomach, pelvis and thighs are in line.\n3. Slowly lower until you are in the starting position and repeat.',
      gifUrl: 'https://musclewiki.com/media/uploads/kettlebell-male-hip-thrust-front.gif',
      muscleGroup: 'Glutes',
      equipment: 'Kettlebell',
    ),
    UserExercise(
      name: 'Kettlebell Glute Bridge',
      instructions: '1. Laying on the floor with your knees bent and feet firmly on the floor, rest the kettlebell on your pelvis.\n2. Pushing through the legs and keeping the core muscles engaged, raise your pelvis off the floor until your stomach, pelvis and thighs make a straight line.\n3. Slowly lower to the ground to the starting position and repeat.',
      gifUrl: 'https://musclewiki.com/media/uploads/kettlebell-male-glute-bridge-front.gif',
      muscleGroup: 'Glutes',
      equipment: 'Kettlebell',
    ),
    UserExercise(
      name: 'Single Leg Hip Thrust',
      instructions: '1. Sitting on the floor with one knee bent with the foot firmly on the floor and one leg extended, lean your back against the bench.\n2. Resting the kettlebell on your pelvis, raise your pelvis until your stomach, pelvis and thighs are in line.\n3. Slowly lower until you are in the starting position and repeat.',
      gifUrl: 'https://musclewiki.com/media/uploads/kettlebell-male-SL-hip-thrust-front.gif',
      muscleGroup: 'Glutes',
      equipment: 'Kettlebell',
    ),
    UserExercise(
      name: 'Hamstrings Stretch',
      instructions: '1. Bend your rear leg as much as you can, keeping the front leg straight.\n2. Hold the stretch for a few seconds then return to starting position.\n3. Stand with one foot in front of the other.',
      gifUrl: 'https://musclewiki.com/media/uploads/male-strech-27-side.gif',
      muscleGroup: 'Hamstring',
      equipment: 'Stretch',
    ),
    UserExercise(
      name: 'Hamstrings Stretch II',
      instructions: '1. Sit on the floor with your legs out in front of you.\n2. Reach forward to try and touch your toes. Reach as far forward as you can go.\n3. Hold the stretch for a few seconds then return to starting position.',
      gifUrl: 'https://musclewiki.com/media/uploads/male-strech-25-side.gif',
      muscleGroup: 'Hamstring',
      equipment: 'Stretch',
    ),
    UserExercise(
      name: 'Single Legged Romanian Deadlifts',
      instructions: '1. Stand with your feet shoulder-width apart and knees slightly bent and raise one leg.\n2. Without changing the bend in your knee, bend at your hips, and lower your torso until it\'s almost parallel to the floor.\n3. Tense your glutes and then bring yourself back to the starting position.',
      gifUrl: 'https://musclewiki.com/media/uploads/bodyweight-male-single-leg-romainian-deadlift-side.gif',
      muscleGroup: 'Hamstring',
      equipment: 'Bodyweight',
    ),
    UserExercise(
      name: 'Kickbacks',
      instructions: '1. Get down on all fours and position your hands under your shoulders and your knees under your hips.\n2. Kick back with one leg and squeeze your glutes.\n3. Slowly return to starting position by bending your knee and lowering your leg.\n4. Switch Legs. Repeat.',
      gifUrl: 'https://musclewiki.com/media/uploads/bodyweight-male-glutekickback-side.gif',
      muscleGroup: 'Hamstring',
      equipment: 'Bodyweight',
    ),
    UserExercise(
      name: 'Nordic Hamstring Curl',
      instructions: '1. Go to your knees and ask someone to hold your ankles.\n2. Put your hands in front of you.\n3. With a slight bend in your knees slowly bring your body to the ground (slower is better).\n4. Push up and reset to the starting position.',
      gifUrl: 'https://musclewiki.com/media/uploads/bodyweight-male-noridchamstringcurl-side.gif',
      muscleGroup: 'Hamstring',
      equipment: 'Bodyweight',
    ),
    UserExercise(
      name: 'Stiff Leg Deadlist',
      instructions: '1. Stand with a barbell at your shins with your feet shoulder width apart.\n2. Bend forward at your hips and keep your knees as fully extended as possible.\n3. Grab the barbell and then extend your hips while maintaining a straight back.\n4. From the standing position, lower the weight in a controlled manner.\n5. You can either lower the weight to the floor or before you touch the floor, depending on your mobility.',
      gifUrl: 'https://musclewiki.com/media/uploads/Male-Stiff-Leg-Deadlifts-front.gif',
      muscleGroup: 'Hamstring',
      equipment: 'Barbell',
    ),
    UserExercise(
      name: 'Single Leg Deadlift',
      instructions: '1. Stand with your feet shoulder width apart, lifting one foot off the floor behind you. Hold the kettlebell in the same arm as the lifted leg.\n2. Bend forward at the hips bringing the kettlebell to the floor while you extend your lifted leg behind you, keeping your back straight - holding out your arm to the side for balance.\n3. Return to the upright position and repeat.',
      gifUrl: 'https://musclewiki.com/media/uploads/kettlebell-male-sldeadlift-side.gif',
      muscleGroup: 'Hamstring',
      equipment: 'Kettlebell',
    ),
    UserExercise(
      name: 'Calves Stretch',
      instructions: '1. With both feet flat on the ground, place one leg in front of your shoulder, your other leg should mirror this position behind your other shoulder. In the starting position both of your knees should be straight.\n2. Place the palms of your hands against the wall at shoulder height in front of you, lean towards the wall and bend your front leg at the knee while keeping your back leg straight.\n3. Pause at the apex of the stretch and return to the starting position. Switch the position of your legs and repeat.',
      gifUrl: 'https://musclewiki.com/media/uploads/female-strech-20-side.gif',
      muscleGroup: 'Calves',
      equipment: 'Stretch',
    ),
    UserExercise(
      name: 'Calves Stretch II',
      instructions: '1. Balance the balls of your feet on the platform, leaning forward to use the wall to assist with balance. Engage your calves so that your feet are flat before beginning the stretch.\n2. Lower the heels of your feet towards the ground and pause, then push through the balls of your feet like you are standing tip toe, pausing at the apex of the stretch.\n3. Repeat as necessary.',
      gifUrl: 'https://musclewiki.com/media/uploads/female-strech-19-side.gif',
      muscleGroup: 'Calves',
      equipment: 'Stretch',
    ),
    UserExercise(
      name: 'Walking Calf Raises',
      instructions: '1. Walk forward and push your toe into the ground.\n2. Lift you heel off the ground each step and tense your calf muscle.\n3. Repeat on each leg and walk forward slowly.',
      gifUrl: 'https://musclewiki.com/media/uploads/bodyweight-female-walkingcalveraise-side.gif',
      muscleGroup: 'Calves',
      equipment: 'Bodyweight',
    ),
    UserExercise(
      name: 'Calf Raises',
      instructions: '1. Balance on the balls of your feet on the platform or plates, leaning forward to use the wall to assist with balance.\n2. Lower the heels of your feet towards the ground and pause, then push through the balls of your feet like you are standing tip toe, pausing at the apex of the motion.\n3. Repeat as necessary.',
      gifUrl: 'https://musclewiki.com/media/uploads/bodyweight-female-calveraise-side.gif',
      muscleGroup: 'Calves',
      equipment: 'Bodyweight',
    ),
    UserExercise(
      name: 'Barbell Calf Raises',
      instructions: '1. Place the bar on your back\n2. Start with feet flat on the ground\n3. Extend your heels upwards while keeping your knees stationary, and pause at the contracted position.\n4. Slowly return to the starting position. Repeat.',
      gifUrl: 'https://musclewiki.com/media/uploads/barbell-female-calveraise-side.gif',
      muscleGroup: 'Calves',
      equipment: 'Barbell',
    ),
    UserExercise(
      name: 'Seated Calf Raise',
      instructions: '1. Sitting comfortably on a chair with your core stomach muscles engaged, place your feet on the floor.\n2. Place the kettlebell on your legs, just above the knees and raise your heels upwards off the floor.\n3. Pause when your heels are fully extended and then slowly return to the starting position and repeat.',
      gifUrl: 'https://musclewiki.com/media/uploads/kettlebell-female-seated-calf-raises-side.gif',
      muscleGroup: 'Calves',
      equipment: 'Kettlebell',
    ),
    UserExercise(
      name: 'Single Leg Calf Raise',
      instructions: '1. Standing straight with a kettlebell in one hand, lift the same foot as the side without the kettlebell off the floor.\n2. Raise your heel upwards while keeping your knees stationary.\n3. Pause when your heels are fully extended and then slowly return to the starting position and repeat.',
      gifUrl: 'https://musclewiki.com/media/uploads/kettlebell-female-sl-calf-raises-front.gif',
      muscleGroup: 'Hamstring',
      equipment: 'Kettlebell',
    ),
  ];
}


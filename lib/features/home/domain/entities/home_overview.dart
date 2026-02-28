import 'package:equatable/equatable.dart';

class HomeOverview extends Equatable {
  final String name;
  final String title;
  final String location;
  final String timezone;

  final String currentFocus;
  final String focusStatus; // In Progress

  final int activeProjects;
  final String activeDelta; // +1 this month

  final String availability; // Busy
  final String availabilityNote; // Until March 2026

  final int tasksDone;
  final int tasksTotal;

  const HomeOverview({
    required this.name,
    required this.title,
    required this.location,
    required this.timezone,
    required this.currentFocus,
    required this.focusStatus,
    required this.activeProjects,
    required this.activeDelta,
    required this.availability,
    required this.availabilityNote,
    required this.tasksDone,
    required this.tasksTotal,
  });

  @override
  List<Object?> get props => [
    name, title, location, timezone,
    currentFocus, focusStatus,
    activeProjects, activeDelta,
    availability, availabilityNote,
    tasksDone, tasksTotal,
  ];
}
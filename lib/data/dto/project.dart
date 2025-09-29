class Project {
  final String title;
  final String date;
  final List<String> members;
  final String description;
  final double progress;
  final int comments;
  final String timeAgo;

  Project({
    required this.title,
    required this.date,
    required this.members,
    required this.description,
    required this.progress,
    required this.comments,
    required this.timeAgo,
  });
}

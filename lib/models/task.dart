class Task {
  String id;
  String title;
  String description;
  DateTime date;
  String? time;
  String status; // 'completed', 'in_progress', 'on_hold'
  int colorIndex;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    this.time,
    required this.status,
    required this.colorIndex,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'date': date.toIso8601String(),
    'time': time,
    'status': status,
    'colorIndex': colorIndex,
  };

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    date: DateTime.parse(json['date']),
    time: json['time'],
    status: json['status'],
    colorIndex: json['colorIndex'],
  );
}
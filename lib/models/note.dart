class Note {
  String id;
  String title;
  String content;
  DateTime createdAt;
  int colorIndex;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.colorIndex,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'content': content,
    'createdAt': createdAt.toIso8601String(),
    'colorIndex': colorIndex,
  };

  factory Note.fromJson(Map<String, dynamic> json) => Note(
    id: json['id'],
    title: json['title'],
    content: json['content'],
    createdAt: DateTime.parse(json['createdAt']),
    colorIndex: json['colorIndex'],
  );
}
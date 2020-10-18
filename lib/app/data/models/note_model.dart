class NoteModel {
  String id;
  String content;
  String publishedAt;
  String createdAt;
  String updatedAt;

  NoteModel(
      {this.id,
      this.content,
      this.publishedAt,
      this.createdAt,
      this.updatedAt});

  NoteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    publishedAt = json['publishedAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    data['published_at'] = this.publishedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class AlertPost {
  String? post_id;
  String? title;
  String? content;
  String? author_id;
  String? place;
  DateTime? time;

  AlertPost(
      this.post_id,
      this.title,
      this.content,
      this.author_id,
      this.place,
      this.time
      );
  AlertPost.only(
      {this.post_id,
        this.title,
        this.content,
        this.author_id,
        this.place,
        this.time});

  void setPostId(String? id) {
    this.post_id = id;
  }



}


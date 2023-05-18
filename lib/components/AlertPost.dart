
class AlertPost {
  String? post_id;
  String? title;
  String? content;
  String? author_name;

  AlertPost(
      this.post_id,
      this.title,
      this.content,
      this.author_name,
      );
  AlertPost.only(
      {this.post_id,
        this.title,
        this.content,
        this.author_name,});

  void setPostId(String? id) {
    this.post_id = id;
  }

  void setAuthorName(String? name){
    this.author_name=name;
  }

  static List<AlertPost> getSampleExperiencePostList() {
    List<AlertPost> _post = [];
    _post.add(new AlertPost('', 'Da Nang hom nay mua', 'Mua ngap duong Dien Bien Phu', 'Huy Phan'));
    _post.add(new AlertPost('', 'Da Nang hom nay mua', 'Mua ngap duong Dien Bien Phu', 'Huy Phan'));
    _post.add(new AlertPost('', 'Da Nang hom nay mua', 'Mua ngap duong Dien Bien Phu', 'Huy Phan'));
    _post.add(new AlertPost('', 'Da Nang hom nay mua', 'Mua ngap duong Dien Bien Phu', 'Huy Phan'));
    _post.add(new AlertPost('', 'Da Nang hom nay mua', 'Mua ngap duong Dien Bien Phu', 'Huy Phan'));
    return _post;
  }

}


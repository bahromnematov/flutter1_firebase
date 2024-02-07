class Post {
  String? first_name;
  String? last_name;
  String? content;
  String? img_url;
  String? date;

  Post(
      {this.first_name, this.last_name, this.content, this.img_url, this.date});

  Post.fromJson(Map<String, dynamic> json)
      : first_name = json['first_name'],
        last_name = json['last_name'],
        content = json['content'],
        img_url = json['img_url'],
        date = json['date'];

  Map<String, dynamic> toJon() => {
        'first_name': first_name,
        'last_name': last_name,
        'content': content,
        'img_url': img_url,
        'date': date,
      };
}

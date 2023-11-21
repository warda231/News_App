class SavedNewsItem {
  final String title;
  final String itemType;
  final String subsection;
  final String abstract;
  final String url;
  final String byline;
    final String weburl;



  SavedNewsItem({
    required this.title,
    required this.itemType,
    required this.subsection,
    required this.abstract,
    required this.url,
    required this.byline,
        required this.weburl,


  });

  // Factory method to create SavedNewsItem from JSON
factory SavedNewsItem.fromJson(Map<String, dynamic> json) {
  return SavedNewsItem(
    title: json['title'] ?? '',
    itemType: json['itemType'] ?? '',
    subsection: json['subsection'] ?? '',
    abstract: json['abstract'] ?? '',
    url: json['url'] ?? '',
    byline: json['byline'] ?? '', 
    weburl: json['weburl']?? '', 
  );
}


  // Method to convert SavedNewsItem to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'itemType': itemType,
      'subsection': subsection,
      'abstract': abstract,
      'url': url,
      'byline': byline,
      'weburl':weburl,
    };
  }
}

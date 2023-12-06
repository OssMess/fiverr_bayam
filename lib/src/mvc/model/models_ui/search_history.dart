import '../enums.dart';

class SearchHistory {
  final AdCategory category;
  final String companyName;
  final String companyPhotoUrl;

  SearchHistory({
    required this.category,
    required this.companyName,
    required this.companyPhotoUrl,
  });

  factory SearchHistory.fromJson(Map<String, dynamic> json) => SearchHistory(
        category: json['category'],
        companyName: json['companyName'],
        companyPhotoUrl: json['companyPhotoUrl'],
      );
}

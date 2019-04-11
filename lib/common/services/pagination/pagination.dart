import 'package:json_annotation/json_annotation.dart';

part 'pagination.g.dart';

@JsonSerializable()
class Pagination {
  @JsonKey(defaultValue: 1)
  final int total;
  @JsonKey(name: 'per_page', defaultValue: 15)
  final int perPage;
  @JsonKey(name: 'current_page', defaultValue: 1)
  final int currentPage;
  @JsonKey(name: 'total_pages', defaultValue: 1)
  final int totalPage;

  Pagination({
    this.total = 1,
    this.perPage = 15,
    this.currentPage = 1,
    this.totalPage = 1,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => json == null ? Pagination() : _$PaginationFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}

class PaginationData<T> {
  final List<T> data;
  final Pagination pagination;

  PaginationData({this.data, this.pagination});
}

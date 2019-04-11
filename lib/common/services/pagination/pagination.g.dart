// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pagination _$PaginationFromJson(Map<String, dynamic> json) {
  return Pagination(
      total: json['total'] as int ?? 1,
      perPage: json['per_page'] as int ?? 15,
      currentPage: json['current_page'] as int ?? 1,
      totalPage: json['total_pages'] as int ?? 1);
}

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'total': instance.total,
      'per_page': instance.perPage,
      'current_page': instance.currentPage,
      'total_pages': instance.totalPage
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paged_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PagedResponse<T> _$PagedResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => PagedResponse<T>(
  content: (json['content'] as List<dynamic>).map(fromJsonT).toList(),
  page: (json['page'] as num?)?.toInt() ?? 0,
  size: (json['size'] as num?)?.toInt() ?? 0,
  totalPages: (json['totalPages'] as num?)?.toInt() ?? 0,
  totalElements: (json['totalElements'] as num?)?.toInt() ?? 0,
  first: json['first'] as bool? ?? true,
  last: json['last'] as bool? ?? true,
  empty: json['empty'] as bool? ?? true,
);

Map<String, dynamic> _$PagedResponseToJson<T>(
  PagedResponse<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'content': instance.content.map(toJsonT).toList(),
  'page': instance.page,
  'size': instance.size,
  'totalPages': instance.totalPages,
  'totalElements': instance.totalElements,
  'first': instance.first,
  'last': instance.last,
  'empty': instance.empty,
};

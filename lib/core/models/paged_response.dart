import 'package:json_annotation/json_annotation.dart';

part 'paged_response.g.dart';

/// Matches Spring Boot Page<T> structure
@JsonSerializable(genericArgumentFactories: true)
class PagedResponse<T> {
  final List<T> content;
  final int page;
  final int size;
  final int totalPages;
  final int totalElements;
  final bool first;
  final bool last;
  final bool empty;

  PagedResponse({
    required this.content,
    required this.page,
    required this.size,
    required this.totalPages,
    required this.totalElements,
    required this.first,
    required this.last,
    required this.empty,
  });

  factory PagedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$PagedResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$PagedResponseToJson(this, toJsonT);

  bool get hasMore => !last;
  bool get hasPrevious => !first;
}

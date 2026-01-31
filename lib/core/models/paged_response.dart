import 'package:json_annotation/json_annotation.dart';

part 'paged_response.g.dart';

/// Matches Spring Boot Page<T> structure
@JsonSerializable(genericArgumentFactories: true)
class PagedResponse<T> {
  final List<T> content;
  @JsonKey(defaultValue: 0)
  final int page;
  @JsonKey(defaultValue: 0)
  final int size;
  @JsonKey(defaultValue: 0)
  final int totalPages;
  @JsonKey(defaultValue: 0)
  final int totalElements;
  @JsonKey(defaultValue: true)
  final bool first;
  @JsonKey(defaultValue: true)
  final bool last;
  @JsonKey(defaultValue: true)
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

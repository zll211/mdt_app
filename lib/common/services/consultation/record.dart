import 'package:json_annotation/json_annotation.dart';

part 'record.g.dart';

@JsonSerializable()
class Record {
  @JsonKey(defaultValue: 0)
  final int id;
  @JsonKey(defaultValue: '')
  final String content;

  Record({
    this.id: 0,
    this.content: '',
  });

  factory Record.fromJson(Map<String, dynamic> json) => json == null ? Record() : _$RecordFromJson(json);

  Map<String, dynamic> toJson() => _$RecordToJson(this);
}

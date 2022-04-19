import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_abilities.freezed.dart';
part 'my_abilities.g.dart';

@freezed
class MyAbilities with _$MyAbilities {
  const factory MyAbilities({
    @Default("") String name,
    @JsonKey(name: 'strength ', defaultValue: 0) int? strength,
  }) = _MyAbilities;

  factory MyAbilities.fromJson(Map<String, dynamic> json) => _$MyAbilitiesFromJson(json);
}

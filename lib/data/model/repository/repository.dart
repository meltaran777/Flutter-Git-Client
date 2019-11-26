import 'package:json_annotation/json_annotation.dart';

part 'repository.g.dart';

@JsonSerializable()
class Repository {
  int id;
  String name;
  String description;
  @JsonKey(name: 'stargazers_count')
  int stargazersCount;

  Repository(this.id, this.name, this.description, this.stargazersCount);

  getDescriptionText() {
    return description ?? 'Empty Description';
  }

  factory Repository.fromJson(Map<String, dynamic> json) =>
      _$RepositoryFromJson(json);

  Map<String, dynamic> toJson() => _$RepositoryToJson(this);
}

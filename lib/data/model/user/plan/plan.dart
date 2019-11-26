import 'package:json_annotation/json_annotation.dart';

part 'plan.g.dart';

@JsonSerializable()
class Plan {

  String name;
  int space;
  int collaborators;
  @JsonKey(name: 'private_repos')
  int privateRepos;

  Plan(this.name, this.space, this.collaborators, this.privateRepos);

  factory Plan.fromJson(Map<String, dynamic> json) => _$PlanFromJson(json);
  Map<String, dynamic> toJson() => _$PlanToJson(this);
}

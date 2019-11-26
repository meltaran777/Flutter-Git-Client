// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Plan _$PlanFromJson(Map<String, dynamic> json) {
  return Plan(
    json['name'] as String,
    json['space'] as int,
    json['collaborators'] as int,
    json['private_repos'] as int,
  );
}

Map<String, dynamic> _$PlanToJson(Plan instance) => <String, dynamic>{
      'name': instance.name,
      'space': instance.space,
      'collaborators': instance.collaborators,
      'private_repos': instance.privateRepos,
    };

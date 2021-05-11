import 'package:hive/hive.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

@HiveType(typeId: 1)
@JsonSerializable(nullable: false)
class ReleModel {
  ReleModel({
    this.chave,
    this.nome,
  });

  @HiveField(0)
  @JsonKey(name: 'chave')
  String chave;

  @HiveField(1)
  @JsonKey(name: 'nome')
  String nome;

}
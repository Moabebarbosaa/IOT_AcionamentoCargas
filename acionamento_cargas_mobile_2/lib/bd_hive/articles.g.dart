import 'package:acionamento_cargas_mobile_2/bd_hive/articles.dart';
import 'package:hive/hive.dart';

class ReleModelAdapter extends TypeAdapter<ReleModel> {
  @override
  final int typeId = 1;

  @override
  ReleModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReleModel(
      chave: fields[0] as String,
      nome: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ReleModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.chave)
      ..writeByte(1)
      ..write(obj.nome);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReleModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReleModel _$ArticlesModelFromJson(Map<String, dynamic> json) {
  return ReleModel(
    chave: json['chave'] as String,
    nome: json['nome'] as String,
  );
}

Map<String, dynamic> _$ArticlesModelToJson(ReleModel instance) =>
    <String, dynamic>{
      'chave': instance.chave,
      'nome': instance.nome,
    };

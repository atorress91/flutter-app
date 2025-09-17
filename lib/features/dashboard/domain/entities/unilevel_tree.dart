import 'package:equatable/equatable.dart';

class UniLevelTree extends Equatable {
  final String username;
  final int id;
  final int level;
  final int father;
  final String description;
  final String image;
  final int byte;
  final List<UniLevelTree> children;

  const UniLevelTree({
    required this.username,
    required this.id,
    required this.level,
    required this.father,
    required this.description,
    required this.image,
    required this.byte,
    required this.children,
  });

  @override
  List<Object?> get props => [
    username,
    id,
    level,
    father,
    description,
    image,
    byte,
    children,
  ];
}

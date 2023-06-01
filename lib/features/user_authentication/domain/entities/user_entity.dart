class UserEntity {
  final int? id;
  final String? uniqueId;
  final String? name;
  final String? password;
  final int? groupId;

  UserEntity({
    required this.id,
    required this.uniqueId,
    required this.name,
    required this.password,
    required this.groupId,
  });
}

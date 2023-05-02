class LabelDto {
  int labelId;
  String name;

  LabelDto({
    required this.labelId,
    required this.name,
  });

  factory LabelDto.fromJson(Map<String, dynamic> json) {
    return LabelDto(
      labelId: json['labelId'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['labelId'] = labelId;
    data['name'] = name;
    return data;
  }
}

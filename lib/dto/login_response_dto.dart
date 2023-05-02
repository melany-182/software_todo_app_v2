class LoginResponseDto {
  String? authToken;
  String? refreshToken;

  LoginResponseDto({
    this.authToken,
    this.refreshToken,
  });

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) {
    return LoginResponseDto(
      authToken: json['authToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['authToken'] = authToken;
    data['refreshToken'] = refreshToken;
    return data;
  }
}

import 'dart:convert';

class SummaryResponse {
  final double lat;
  final double lon;
  final double damage;
  final RecoveryInfo recoveryInfo;
  final VegetationInfo vegetationInfo;

  SummaryResponse({
    required this.lat,
    required this.lon,
    required this.damage,
    required this.recoveryInfo,
    required this.vegetationInfo,
  });

  factory SummaryResponse.fromJson(Map<String, dynamic> json) {
    print('SummaryResponse 원본 JSON: $json');
    try {
      // 한글 인코딩 문제 해결을 위해 문자열 데이터 디코딩
      String decodeKorean(String? text) {
        if (text == null) return '';
        try {
          return utf8.decode(text.codeUnits);
        } catch (e) {
          print('문자열 디코딩 실패: $e');
          return text;
        }
      }

      // recovery status 디코딩
      final recoveryJson =
          json['recoveryInfo']['recovery'] as Map<String, dynamic>;
      final decodedStatus = decodeKorean(recoveryJson['status'] as String?);
      final decodedRecovery = {
        ...recoveryJson,
        'status': decodedStatus,
      };

      // vegetation explanation 디코딩
      final vegetationJson =
          json['vegetationInfo']['vegetation'] as Map<String, dynamic>;
      final decodedExplanation =
          decodeKorean(vegetationJson['explanation'] as String?);

      // veg1, veg2, veg3의 name과 text 디코딩
      final decodedVeg1 = {
        ...vegetationJson['veg1'] as Map<String, dynamic>,
        'name': decodeKorean(vegetationJson['veg1']['name'] as String?),
        'text': decodeKorean(vegetationJson['veg1']['text'] as String?),
      };
      final decodedVeg2 = {
        ...vegetationJson['veg2'] as Map<String, dynamic>,
        'name': decodeKorean(vegetationJson['veg2']['name'] as String?),
        'text': decodeKorean(vegetationJson['veg2']['text'] as String?),
      };
      final decodedVeg3 = {
        ...vegetationJson['veg3'] as Map<String, dynamic>,
        'name': decodeKorean(vegetationJson['veg3']['name'] as String?),
        'text': decodeKorean(vegetationJson['veg3']['text'] as String?),
      };

      final decodedVegetation = {
        ...vegetationJson,
        'explanation': decodedExplanation,
        'veg1': decodedVeg1,
        'veg2': decodedVeg2,
        'veg3': decodedVeg3,
      };

      return SummaryResponse(
        lat: (json['lat'] as num).toDouble(),
        lon: (json['lon'] as num).toDouble(),
        damage: (json['damage'] as num).toDouble(),
        recoveryInfo:
            RecoveryInfo.fromJson(json['recoveryInfo'] as Map<String, dynamic>),
        vegetationInfo: VegetationInfo.fromJson(
            json['vegetationInfo'] as Map<String, dynamic>),
      );
    } catch (e) {
      print('SummaryResponse 파싱 오류: $e');
      print('문제가 된 JSON 데이터: $json');
      rethrow;
    }
  }
}

class RecoveryInfo {
  final Recovery recovery;

  RecoveryInfo({required this.recovery});

  factory RecoveryInfo.fromJson(Map<String, dynamic> json) {
    print('RecoveryInfo.fromJson 시작: $json');
    try {
      return RecoveryInfo(
        recovery: Recovery.fromJson(json['recovery'] as Map<String, dynamic>),
      );
    } catch (e) {
      print('RecoveryInfo 파싱 오류: $e');
      rethrow;
    }
  }
}

class Recovery {
  final double ndviPre;
  final double ndviMin;
  final double ndviNow;
  final double recoveryRate;
  final String status;

  Recovery({
    required this.ndviPre,
    required this.ndviMin,
    required this.ndviNow,
    required this.recoveryRate,
    required this.status,
  });

  factory Recovery.fromJson(Map<String, dynamic> json) {
    print('Recovery.fromJson 시작: $json');
    try {
      return Recovery(
        ndviPre: (json['ndvi_pre'] as num).toDouble(),
        ndviMin: (json['ndvi_min'] as num).toDouble(),
        ndviNow: (json['ndvi_now'] as num).toDouble(),
        recoveryRate: (json['recovery_rate'] as num).toDouble(),
        status: json['status'] as String,
      );
    } catch (e) {
      ('Recovery 파싱 오류: $e');
      rethrow;
    }
  }
}

class VegetationInfo {
  final double ndvi;
  final Vegetation vegetation;

  VegetationInfo({
    required this.ndvi,
    required this.vegetation,
  });

  factory VegetationInfo.fromJson(Map<String, dynamic> json) {
    print('VegetationInfo.fromJson 시작: $json');
    try {
      return VegetationInfo(
        ndvi: (json['ndvi'] as num).toDouble(),
        vegetation:
            Vegetation.fromJson(json['vegetation'] as Map<String, dynamic>),
      );
    } catch (e) {
      print('VegetationInfo 파싱 오류: $e');
      rethrow;
    }
  }
}

class Vegetation {
  final String explanation;
  final PlantData veg1;
  final PlantData veg2;
  final PlantData veg3;

  Vegetation({
    required this.explanation,
    required this.veg1,
    required this.veg2,
    required this.veg3,
  });

  factory Vegetation.fromJson(Map<String, dynamic> json) {
    print('Vegetation 원본 JSON: $json');
    try {
      return Vegetation(
        explanation: json['explanation'] as String,
        veg1: PlantData.fromJson(json['veg1'] as Map<String, dynamic>),
        veg2: PlantData.fromJson(json['veg2'] as Map<String, dynamic>),
        veg3: PlantData.fromJson(json['veg3'] as Map<String, dynamic>),
      );
    } catch (e) {
      print('Vegetation 파싱 오류: $e');
      rethrow;
    }
  }
}

class PlantData {
  final String name;
  final String text;
  final String? image;

  PlantData({
    required this.name,
    required this.text,
    this.image,
  });

  factory PlantData.fromJson(Map<String, dynamic> json) {
    print('PlantData 원본 JSON: $json');
    print('PlantData image URL 원본: ${json['image']}');

    return PlantData(
      name: json['name'] as String,
      text: json['text'] as String,
      image: json['image'] as String?,
    );
  }
}

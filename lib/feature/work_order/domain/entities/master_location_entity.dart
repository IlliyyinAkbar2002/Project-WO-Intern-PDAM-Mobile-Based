import 'package:equatable/equatable.dart';

class MasterLocationEntity extends Equatable {
  final int? id;
  final String nama;
  final double latitude;
  final double longitude;
  final int radiusMeter;

  const MasterLocationEntity({
    this.id,
    required this.nama,
    required this.latitude,
    required this.longitude,
    required this.radiusMeter,
  });

  @override
  List<Object?> get props => [id, nama, latitude, longitude, radiusMeter];

  MasterLocationEntity copyWith({
    int? id,
    String? nama,
    double? latitude,
    double? longitude,
    int? radiusMeter,
  }) {
    return MasterLocationEntity(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      radiusMeter: radiusMeter ?? this.radiusMeter,
    );
  }
}


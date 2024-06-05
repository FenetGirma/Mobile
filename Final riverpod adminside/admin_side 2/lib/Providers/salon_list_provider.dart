// providers/salon_provider.dart
import 'package:admin_side/Services/salon_list_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/salon_list.dart';

class SalonListNotifier extends StateNotifier<SalonListState> {
  final SalonService salonService;

  SalonListNotifier({required this.salonService})
      : super(SalonListState(isLoading: false, salons: [], error: ''));

  Future<void> fetchSalons(String accessToken) async {
    state = state.copyWith(isLoading: true);
    try {
      final salons = await salonService.fetchSalons(accessToken);
      state = state.copyWith(salons: salons, isLoading: false, error: '');
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Error: $e');
    }
  }

  Future<void> editSalon(String accessToken, String salonId, String newName,
      String newLocation, String newPicturePath) async {
    try {
      await salonService.editSalon(
          accessToken, salonId, newName, newLocation, newPicturePath);
      fetchSalons(accessToken);
    } catch (e) {
      state = state.copyWith(error: 'Error: $e');
    }
  }

  Future<void> deleteSalon(String accessToken, String salonId) async {
    try {
      await salonService.deleteSalon(accessToken, salonId);
      fetchSalons(accessToken);
    } catch (e) {
      state = state.copyWith(error: 'Error: $e');
    }
  }
}

final salonListProvider =
    StateNotifierProvider<SalonListNotifier, SalonListState>((ref) {
  return SalonListNotifier(salonService: SalonService());
});

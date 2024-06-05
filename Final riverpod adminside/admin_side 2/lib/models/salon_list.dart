// models/salon_list_state.dart
class SalonListState {
  final bool isLoading;
  final List salons;
  final String error;

  SalonListState({
    required this.isLoading,
    required this.salons,
    required this.error,
  });

  SalonListState copyWith({
    bool? isLoading,
    List? salons,
    String? error,
  }) {
    return SalonListState(
      isLoading: isLoading ?? this.isLoading,
      salons: salons ?? this.salons,
      error: error ?? this.error,
    );
  }
}

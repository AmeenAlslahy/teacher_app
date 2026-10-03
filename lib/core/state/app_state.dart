enum AppStatus { initial, loading, success, error }

class AppState<T> {
  final AppStatus status;
  final T? data;
  final String? error;
  
  const AppState._({
    required this.status,
    this.data,
    this.error,
  });
  
  factory AppState.initial() => const AppState._(status: AppStatus.initial);
  factory AppState.loading() => const AppState._(status: AppStatus.loading);
  factory AppState.success(T data) => AppState._(status: AppStatus.success, data: data);
  factory AppState.error(String error) => AppState._(status: AppStatus.error, error: error);
  
  bool get isLoading => status == AppStatus.loading;
  bool get isSuccess => status == AppStatus.success;
  bool get isError => status == AppStatus.error;
  
  R when<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function(T data) success,
    required R Function(String error) error,
  }) {
    switch (status) {
      case AppStatus.initial:
        return initial();
      case AppStatus.loading:
        return loading();
      case AppStatus.success:
        return success(data as T);
      case AppStatus.error:
        return error(this.error!);
    }
  }
}

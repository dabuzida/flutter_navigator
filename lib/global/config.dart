enum BuildMode { Development, Production }

class BuildConfig {
  BuildConfig._();

  static const String appVersion = '0.1.0';

  static BuildMode _buildMode = BuildMode.Development;
  static BuildMode get mode => _buildMode;
  static void setMode(BuildMode buildMode) => _buildMode = buildMode;

  static bool get isDevMode => BuildConfig.mode == BuildMode.Development;
  static bool get isProductMode => BuildConfig.mode == BuildMode.Production;
}

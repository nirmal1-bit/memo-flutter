abstract class CloudinaryConstants {
  static const String cloudName = 'dygq6yakl';
  static const String uploadPreset = 'memo_profile';

  static const String profileFolder = 'memo/profiles';

  static String uploadUrl({String resourceType = 'image'}) =>
      'https://api.cloudinary.com/v1_1/$cloudName/$resourceType/upload';
}

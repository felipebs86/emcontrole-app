class AppRoutes {
  static const home = '/';
  static const treatment = '/treatment';
  static const diary = '/diary';
  static const diaryNew = '/diary/new';
  static String diaryEdit(String entryId) => '/diary/$entryId/edit';
  static const history = '/history';
  static const timeline = '/timeline';
  static const settings = '/settings';
}

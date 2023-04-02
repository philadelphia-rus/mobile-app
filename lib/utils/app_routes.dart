abstract class Routes {
  static const String main = "/";
  static const String welcomePage = "/welcome";
  static const String signInPage = "/signIn";
  static const String signUpPage = "/signUp";

  static const String road = '/road';
  static const String leaders = '/leaders';
  static const String quests = '/quests';
  static const String knowledgeBase = '/knowledgeBase';

    static const String profile = '/knowledgeBase/profile';
static const String qrCode = '/knowledgeBase/profile/qrCode';
}


enum MenuRoute {
  road('/road'),
  leaders('/leaders'),
  quests('/quests'),
  knowledgeBase('/knowledgeBase');

  final String path;
  const MenuRoute(this.path);
}

import 'dart:math';

class AppStrings {
  static const String mileJourneyId = "PTpaErEXFiw";
  static const String mileJourneyUrl =
      "https://www.youtube.com/watch?v=PTpaErEXFiw";

  static const String mileJourney = "Mile Journey";
  static const String mileJourneyProject = "Mile Journey Music Project";
  static const String music = "Music";

  static const String infoId = "szDJkW0jJV";

  static const String name = "Omar Zaghlouleh";
  static const String title = "Omar Zaghlouleh - Portfolio";
  static const String flutterDev = "Flutter Developer";
  static const String portfolio = "Portfolio";
  static const String undefinedError = "404 Not Found";
  static const String projects = "Projects";
  static const String flutterProjects = "Flutter Projects";
  static const String about = "About";
  static const String resume = "Resume";
  static const String contact = "Contact";
  static const String nameTitle = "Name: ";
  static const String educationTitle = "Education: ";
  static const String locationTitle = "Location: ";
  static const String phoneTitle = "Phone Number: ";
  static const String emailTitle = "Email: ";
  static const String featuresTitle = "Features: ";
  static const String upComingFeaturesTitle = "Upcoming Features: ";

  static String mileJourneyDataSourceURL = "";

  static void setDataSourceUrl(String url) {
    mileJourneyDataSourceURL = url;
    print(url);
  }
}

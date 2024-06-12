class HeroTask {
  String title;
  String description;
  String owner;
  String imageUrl;
  int reward;
  int complexity; // 1-5

  HeroTask(
      {required this.title,
      required this.description,
      required this.owner,
      required this.imageUrl,
      required this.reward,
      required this.complexity});
}

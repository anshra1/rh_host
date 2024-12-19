class AppPageView extends StatelessWidget {
  const AppPageView({
    required this.controller,
    required this.pages,
    this.physics,
    super.key,
  });

  final PageController controller;
  final List<Widget> pages;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,
      physics: physics,
      children: pages,
    );
  }
}

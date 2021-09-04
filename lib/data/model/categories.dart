class Categories {
  late String title;
  late String image;

  Categories({required this.title, required this.image});
}

var listCategories = [
  Categories(title: 'Near me', image: 'assets/nearby.png'),
  Categories(title: 'Best sellers', image: 'assets/best-seller.png'),
  Categories(title: '24 Hours', image: 'assets/day-and-night.png'),
  Categories(title: 'New this week', image: 'assets/schedule.png'),
];

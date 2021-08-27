class User {
  final int id;
  final String name;
  final String imageUrl;
  final bool isOnline;

  User({
    this.id,
    this.name,
    this.imageUrl,
    this.isOnline,
  });
}

// YOU - current user
final User currentUser = User(
  id: 0,
  name: 'Hamza',
  imageUrl: 'images/d1.png',
  isOnline: true,
);

// USERS
final User ironMan = User(
  id: 1,
  name: 'Ali',
  imageUrl: 'images/d1.png',
  isOnline: true,
);
final User captainAmerica = User(
  id: 2,
  name: 'Hasseb',
  imageUrl: 'images/d1.png',
  isOnline: true,
);
final User hulk = User(
  id: 3,
  name: 'Rahat',
  imageUrl: 'images/d1.png',
  isOnline: false,
);
final User scarletWitch = User(
  id: 4,
  name: 'Zaryab',
  imageUrl: 'images/d1.png',
  isOnline: false,
);
final User spiderMan = User(
  id: 5,
  name: 'Moiz',
  imageUrl: 'images/d1.png',
  isOnline: true,
);
final User blackWindow = User(
  id: 6,
  name: 'Mussab',
  imageUrl: 'images/d1.png',
  isOnline: false,
);
final User thor = User(
  id: 7,
  name: 'Ahsan',
  imageUrl: 'images/d1.png',
  isOnline: false,
);
final User captainMarvel = User(
  id: 8,
  name: 'Mufazal',
  imageUrl: 'images/d1.png',
  isOnline: false,
);

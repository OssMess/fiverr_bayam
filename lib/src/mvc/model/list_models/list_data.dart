import '../enums.dart';
import '../models.dart';

class ListData {
  static final List<Map<String, dynamic>> data = [
    {
      'name': 'Samak',
      'description':
          'We are offering pesticide services for corn, wheat crops and many more.',
      'field': 'Agriculture',
      'userPhotoUrl':
          'https://i.pinimg.com/1200x/a1/1e/2a/a11e2a9d5803e4dc2c034819ce12a16e.jpg',
      'logoUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDLL2FyAeYaShg5h1YrW3gEyDHDCUb5o2_lw&usqp=CAU',
      'coverUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGdwTxs6lW7B5VgaAceI0p2XfmabWvee-MHlZ_ODsRB3VvM07vzNA3RVmu0OVYrdAHCYU&usqp=CAU',
      'isVerified': true,
      'adType': AdType.forSell,
    },
    {
      'name': 'NetSol',
      'description':
          'Get all kind of IT services related to agricultural Development and other related needs.',
      'field': 'IT Services',
      'userPhotoUrl':
          'https://i.pinimg.com/1200x/a1/1e/2a/a11e2a9d5803e4dc2c034819ce12a16e.jpg',
      'logoUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYugcd50H-J9k2aqtQ8GgebajaY3aMC7k7uw&usqp=CAU',
      'coverUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSmLXC4LINhJsgIbgOHRpRLOCwYAO9ENT1T4Q&usqp=CAU',
      'isVerified': false,
      'adType': AdType.forRent,
    },
    {
      'name': 'GOPro',
      'description':
          'We are offering pesticide services for corn, wheat crops and many more.',
      'field': 'Construction',
      'userPhotoUrl':
          'https://i.pinimg.com/1200x/a1/1e/2a/a11e2a9d5803e4dc2c034819ce12a16e.jpg',
      'logoUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsXVt1xzsYvk-qV28jaF26jiNfm8bpuv-T8Q&usqp=CAU',
      'coverUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSG0f7KQxS_bLNbWHfcWWwI4jYyd3JDTZGIJQ&usqp=CAU',
      'isVerified': true,
      'adType': AdType.wantToBuy,
    },
    {
      'name': 'Agriland',
      'description':
          'Get all kind of IT services related to agricultural Development and other related needs.',
      'field': 'Agriculture',
      'userPhotoUrl':
          'https://i.pinimg.com/1200x/a1/1e/2a/a11e2a9d5803e4dc2c034819ce12a16e.jpg',
      'logoUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRjCuB_T9XRgCcwrQi4u8_zhnVFoQcsIOGa6Q&usqp=CAU',
      'coverUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcReYgkm2MrQ56u1DHyKiWwcp7bP6y9DxSIeRw&usqp=CAU',
      'isVerified': false,
      'adType': AdType.forSell,
    },
  ];

  static List<Company> popularCompanies = data.map(Company.fromJson).toList();

  static List<Ad> premiumAds =
      [data[1], data[0], data[3]].map(Ad.fromJson).toList();

  static List<Ad> ads = [data[3], data[2], data[0]].map(Ad.fromJson).toList();

  static List<Chat> chats = [
    {
      'displayName': 'Julies Dien',
      'photoUrl':
          'https://images.squarespace-cdn.com/content/v1/51ef4493e4b0561c90fa76d6/1667315513383-NIYMELXNAZDL63LEAGAH/20210210_SLP0397-Edit2.jpg?format=1000w',
      'seen': true,
      'isOnline': true,
      'lastMessage': 'Hi Molly! I just checked the came',
      'updatedAt': DateTime.now().subtract(const Duration(minutes: 0)),
    },
    {
      'displayName': 'Richard B.',
      'photoUrl':
          'https://az505806.vo.msecnd.net/cms/49bcf23b-16f2-47a8-8571-a6a360910814/91f8412f-791a-443a-a607-6316d1eb757c-lg.jpg',
      'seen': true,
      'isOnline': true,
      'lastMessage': 'That was really an amazing day',
      'updatedAt': DateTime.now().subtract(const Duration(minutes: 5)),
    },
    {
      'displayName': 'Xavier Will',
      'photoUrl':
          'https://media.istockphoto.com/id/1350800599/photo/happy-indian-business-man-leader-manager-standing-in-office-headshot-portrait.webp?b=1&s=170667a&w=0&k=20&c=pz5kwfLy64_AQIwiv9FDDJWWkAzb2Lf1F5fjZW23dBo=',
      'seen': false,
      'isOnline': false,
      'lastMessage': 'Well I would surely think about that',
      'updatedAt': DateTime.now().subtract(const Duration(hours: 2)),
    },
    {
      'displayName': 'Blair Dota',
      'photoUrl':
          'https://i.pinimg.com/1200x/07/4c/36/074c3657009f20fa39f82dd00098bbb1.jpg',
      'seen': true,
      'isOnline': false,
      'lastMessage': 'I was thinking if you could manage',
      'updatedAt': DateTime.now().subtract(const Duration(hours: 3)),
    },
    {
      'displayName': 'Molly Clark',
      'photoUrl':
          'https://images.unsplash.com/photo-1611432579699-484f7990b127?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aGVhZHNob3R8ZW58MHx8MHx8fDA%3D&w=1000&q=80',
      'seen': false,
      'isOnline': true,
      'lastMessage': 'Thank you so much for that',
      'updatedAt': DateTime.now().subtract(const Duration(days: 1)),
    },
    {
      'displayName': 'Ashley Williams',
      'photoUrl':
          'https://danielturbertphotography.com/wp-content/uploads/2022/12/Business-Headshots-Durham-732x1024.jpg',
      'seen': true,
      'isOnline': false,
      'lastMessage': 'I am thinking to visit to this week',
      'updatedAt': DateTime.now().subtract(const Duration(days: 3)),
    },
    {
      'displayName': 'Molly Clark',
      'photoUrl':
          'https://retratosbarcelona.com/wp-content/uploads/2022/09/Retratos-Barcelona-What-to-wear-for-womens-corporate-headshot-1.jpg',
      'seen': true,
      'isOnline': true,
      'lastMessage': 'Thank you so much for that.',
      'updatedAt': DateTime.now().subtract(const Duration(minutes: 12)),
    },
  ].map(Chat.fromJson).toList();

  static List<Message> aiChat = [
    {
      'senderId': 'myid',
      'senderAvatarUrl':
          'https://i.pinimg.com/1200x/a1/1e/2a/a11e2a9d5803e4dc2c034819ce12a16e.jpg',
      'message': 'hello are you here?',
      'createdAt': DateTime.now(),
      'photoUrl': null,
      'aspectRatio': null,
      'isSending': false,
    },
    {
      'senderId': 'myid',
      'senderAvatarUrl':
          'https://i.pinimg.com/1200x/a1/1e/2a/a11e2a9d5803e4dc2c034819ce12a16e.jpg',
      'message': 'how are doing?',
      'createdAt': DateTime.now(),
      'photoUrl': null,
      'aspectRatio': null,
      'isSending': false,
    },
    {
      'senderId': 'myid',
      'senderAvatarUrl':
          'https://i.pinimg.com/1200x/a1/1e/2a/a11e2a9d5803e4dc2c034819ce12a16e.jpg',
      'message':
          'can you present me a strategy for a winning product to buy and sell',
      'createdAt': DateTime.now(),
      'photoUrl': null,
      'aspectRatio': null,
      'isSending': false,
    },
    {
      'senderId': 'myid',
      'senderAvatarUrl':
          'https://i.pinimg.com/1200x/a1/1e/2a/a11e2a9d5803e4dc2c034819ce12a16e.jpg',
      'message': 'Import my contacts',
      'createdAt': DateTime.now().subtract(const Duration(minutes: 18)),
      'photoUrl': null,
      'aspectRatio': null,
      'isSending': false,
    },
    {
      'senderId': 'myid',
      'senderAvatarUrl':
          'https://i.pinimg.com/1200x/a1/1e/2a/a11e2a9d5803e4dc2c034819ce12a16e.jpg',
      'message': 'Import my contacts',
      'createdAt': DateTime.now().subtract(const Duration(hours: 18)),
      'photoUrl': null,
      'aspectRatio': null,
      'isSending': false,
    },
    {
      'senderId': 'myid',
      'senderAvatarUrl':
          'https://i.pinimg.com/1200x/a1/1e/2a/a11e2a9d5803e4dc2c034819ce12a16e.jpg',
      'message': 'How does bayam work?',
      'createdAt': DateTime.now().subtract(const Duration(days: 18)),
      'photoUrl': null,
      'aspectRatio': null,
      'isSending': false,
    },
    {
      'senderId': 'ai',
      'senderAvatarUrl':
          'https://images.squarespace-cdn.com/content/v1/51ef4493e4b0561c90fa76d6/1667315305235-RCUO3EX7WIENHM8CG9U1/20210601_SLP2805-edit.jpg?format=1000w',
      'message': 'Hi Peter, I\'m Finneas. I\'ll get you setup in no time.',
      'createdAt': DateTime.now().subtract(const Duration(minutes: 3)),
      'photoUrl': null,
      'aspectRatio': null,
      'isSending': false,
    },
    {
      'senderId': 'ai',
      'senderAvatarUrl':
          'https://images.squarespace-cdn.com/content/v1/51ef4493e4b0561c90fa76d6/1667315305235-RCUO3EX7WIENHM8CG9U1/20210601_SLP2805-edit.jpg?format=1000w',
      'message': 'What would you like to do first?',
      'createdAt': DateTime.now().subtract(const Duration(minutes: 3)),
      'photoUrl': null,
      'aspectRatio': null,
      'isSending': false,
    },
  ].map(Message.fromJson).toList();
}

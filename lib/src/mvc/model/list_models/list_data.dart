import '../enums.dart';

class ListData {
  static List<Map<String, dynamic>> popularCompanies = [
    {
      'name': 'Samak',
      'title': 'Agriculture',
      'logoUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDLL2FyAeYaShg5h1YrW3gEyDHDCUb5o2_lw&usqp=CAU',
      'coverUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGdwTxs6lW7B5VgaAceI0p2XfmabWvee-MHlZ_ODsRB3VvM07vzNA3RVmu0OVYrdAHCYU&usqp=CAU',
      'isVerified': true,
      'adType': AdType.forSell,
    },
    {
      'name': 'NetSol',
      'title': 'IT Services',
      'logoUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYugcd50H-J9k2aqtQ8GgebajaY3aMC7k7uw&usqp=CAU',
      'coverUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSmLXC4LINhJsgIbgOHRpRLOCwYAO9ENT1T4Q&usqp=CAU',
      'isVerified': false,
      'adType': AdType.forRent,
    },
    {
      'name': 'GOPro',
      'title': 'Construction',
      'logoUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsXVt1xzsYvk-qV28jaF26jiNfm8bpuv-T8Q&usqp=CAU',
      'coverUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSG0f7KQxS_bLNbWHfcWWwI4jYyd3JDTZGIJQ&usqp=CAU',
      'isVerified': true,
      'adType': AdType.wantToBuy,
    },
    {
      'name': 'Agriland',
      'title': 'Agriculture',
      'logoUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRjCuB_T9XRgCcwrQi4u8_zhnVFoQcsIOGa6Q&usqp=CAU',
      'coverUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcReYgkm2MrQ56u1DHyKiWwcp7bP6y9DxSIeRw&usqp=CAU',
      'isVerified': false,
      'adType': AdType.forSell,
    },
  ];
}

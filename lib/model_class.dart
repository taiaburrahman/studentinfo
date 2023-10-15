class Contact {
  int? id;
  String name;
  String phone;
  String address;
  String dob;
  String gender;
  String images;
  Contact(
      {this.id,
      required this.name,
      required this.phone,
      required this.address,
      required this.dob,
      required this.gender,
      required this.images});

  factory Contact.fromMap(Map<String, dynamic> s) => Contact(
      id: s['id'],
      name: s['name'],
      phone: s['phone'],
      address: s['address'],
      dob: s['dob'],
      gender: s['gender'],
      images: s['images']);

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'phone': phone,
        'address': address,
        'dob': dob,
        'gender': gender,
        'images': images
      };
}

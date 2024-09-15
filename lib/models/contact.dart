class Contact {
  int? id;
  String name;
  String phoneNumber;
  String email;

  Contact({this.id, required this.name, required this.phoneNumber, required this.email});

  // Convert a Contact into a Map. The keys must correspond to the database columns.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
    };
  }

  // Implement toString to make it easier to see information about each Contact when using the print statement.
  @override
  String toString() {
    return 'Contact{id: $id, name: $name, phoneNumber: $phoneNumber, email: $email}';
  }
}

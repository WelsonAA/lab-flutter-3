import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CardCreationScreen extends StatefulWidget {
  final String? cardId;

  CardCreationScreen({this.cardId});

  @override
  _CardCreationScreenState createState() => _CardCreationScreenState();
}

class _CardCreationScreenState extends State<CardCreationScreen> {
  final _nameController = TextEditingController();
  final _jobTitleController = TextEditingController();
  final _companyController = TextEditingController();
  final _contactInfoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.cardId != null) {
      _fetchCardData();
    }
  }

  // Fetch the card data for editing
  Future<void> _fetchCardData() async {
    final cardId = widget.cardId;
    final cardSnapshot = await FirebaseFirestore.instance
        .collection('business_cards')
        .doc(cardId)
        .get();

    if (cardSnapshot.exists) {
      final data = cardSnapshot.data()!;
      _nameController.text = data['name'];
      _jobTitleController.text = data['jobTitle'];
      _companyController.text = data['company'];
      _contactInfoController.text = data['contactInfo'];
    }
  }

  // Save or update the card
  Future<void> _saveCard() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      // Handle the case where the user is not logged in
      return;
    }

    final cardData = {
      'name': _nameController.text,
      'jobTitle': _jobTitleController.text,
      'company': _companyController.text,
      'contactInfo': _contactInfoController.text,
      'userId': userId,  // Associate card with the user
    };

    if (widget.cardId != null) {
      // Update existing card
      await FirebaseFirestore.instance
          .collection('business_cards')
          .doc(widget.cardId)
          .update(cardData);
    } else {
      // Create a new card
      await FirebaseFirestore.instance
          .collection('business_cards')
          .add(cardData);
    }

    Navigator.pop(context);  // Go back to the previous screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cardId == null ? 'Create Business Card' : 'Edit Business Card'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _jobTitleController,
              decoration: InputDecoration(labelText: 'Job Title'),
            ),
            TextField(
              controller: _companyController,
              decoration: InputDecoration(labelText: 'Company'),
            ),
            TextField(
              controller: _contactInfoController,
              decoration: InputDecoration(labelText: 'Contact Info'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveCard,
              child: Text(widget.cardId == null ? 'Create Card' : 'Update Card'),
            ),
          ],
        ),
      ),
    );
  }
}

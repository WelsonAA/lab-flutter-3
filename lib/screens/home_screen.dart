import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'card_creation_screen.dart'; // The screen where you create/edit the card
import 'login_screen.dart'; // Assuming you have a login screen

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? _user;
  List<Map<String, dynamic>> _cards = [];

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
    if (_user != null) {
      _fetchUserCards();
    }
  }

  // Fetch cards from Firestore for the current user
  Future<void> _fetchUserCards() async {
    final userId = _user?.uid;
    if (userId != null) {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('business_cards')
          .where('userId', isEqualTo: userId)
          .get();

      setState(() {
        _cards = querySnapshot.docs.map((doc) {
          return {
            'id': doc.id,
            'name': doc['name'],
            'jobTitle': doc['jobTitle'],
            'company': doc['company'],
            'contactInfo': doc['contactInfo'],
          };
        }).toList();
      });
    }
  }

  // Navigate to the card creation/edit screen
  void _navigateToCardScreen({String? cardId}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CardCreationScreen(cardId: cardId),
      ),
    ).then((_) {
      _fetchUserCards();  // Refresh the list after creating or editing a card
    });
  }

  // Sign out the user
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),  // Go back to login screen
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Business Cards'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),  // Sign-out icon
            onPressed: _signOut,  // Trigger sign-out on press
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () => _navigateToCardScreen(),  // Navigate to create card screen
              child: Text('Create New Card'),
            ),
          ),
          _cards.isEmpty
              ? Center(child: CircularProgressIndicator())  // Show loading indicator while fetching cards
              : Expanded(
            child: ListView.builder(
              itemCount: _cards.length,
              itemBuilder: (context, index) {
                final card = _cards[index];
                return ListTile(
                  title: Text(card['name']),
                  subtitle: Text('${card['jobTitle']} - ${card['company']}'),
                  onTap: () => _navigateToCardScreen(cardId: card['id']),  // Open the card for editing
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

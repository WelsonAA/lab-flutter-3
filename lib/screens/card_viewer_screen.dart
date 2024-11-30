import 'package:flutter/material.dart';
import '../services/firestore_service.dart';

class CardViewerScreen extends StatefulWidget {
  @override
  _CardViewerScreenState createState() => _CardViewerScreenState();
}

class _CardViewerScreenState extends State<CardViewerScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  Map<String, dynamic>? _cardData;

  _fetchCardData() async {
    var userId = 'some-user-id'; // Get the current user's UID
    var data = await _firestoreService.getBusinessCard(userId);
    setState(() {
      _cardData = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchCardData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your Business Card')),
      body: _cardData == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Text('Name: ${_cardData!['name']}'),
                  Text('Job Title: ${_cardData!['job_title']}'),
                  Text('Company: ${_cardData!['company_name']}'),
                  Text('Contact Info: ${_cardData!['contact_info']}'),
                  // Add more fields as necessary
                ],
              ),
            ),
    );
  }
}

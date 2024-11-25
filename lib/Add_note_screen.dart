import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddNoteScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _addNote(BuildContext context) {
    if (_controller.text.isNotEmpty) {
      _firestore.collection('notes').add({
        'content': _controller.text,
        'timestamp': FieldValue.serverTimestamp(),
      });
      _controller.clear();
      Navigator.pop(context); // Go back to the home screen
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a note')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
      ),
      body: Stack(
        children: [
          // Background Image (optional)
          Container(
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent[100], // Fallback color
              image: DecorationImage(
                image: NetworkImage('https://images.unsplash.com/photo-1614360182734-121501b81cc2?q=80&w=1930&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'), // Replace with your image URL
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Input Area
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Write your note:',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.white),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    
                    hintText: 'Type your note here...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                    filled: true,
                    fillColor:  const Color.fromARGB(255, 5, 77, 10),
                  ),
                  maxLines: 8,
                  minLines: 5,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _addNote(context),
                  child: Text('Add Note', style: TextStyle(fontSize: 18,color: Colors.black)),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: const Color.fromARGB(255, 222, 223, 223), // Button color
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

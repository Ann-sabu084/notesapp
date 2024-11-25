import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/updatenotepage.dart';

class HomeScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 235, 237, 234),
        title: Text('My Notes', style: TextStyle(fontSize: 24, color: const Color.fromARGB(255, 20, 20, 20))),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/add-note');
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background Color
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1614360182734-121501b81cc2?q=80&w=1930&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                ),
              ),
            ),
          ),
          // Content Overlay
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Column(
              children: [
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: _firestore.collection('notes').orderBy('timestamp', descending: true).snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }

                      final notes = snapshot.data!.docs;

                      if (notes.isEmpty) {
                        return Center(child: Text('No notes available', style: TextStyle(fontSize: 18, color: Colors.grey)));
                      }

                      return ListView.builder(
                        itemCount: notes.length,
                        itemBuilder: (context, index) {
                          return InkWell(onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Updatenotespage(
                  content: notes[index]['content'],
                  docId:notes[index].id ,
                ),
              ),
            );
          },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.8, // Set width to 80% of screen width
                              height: 80, // Fixed height for the card
                              child: Card(
                                margin: EdgeInsets.only(bottom: 10),
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                color: const Color.fromARGB(255, 5, 77, 10),
                                child: ListTile(
                                  contentPadding: EdgeInsets.all(8), // Adjust padding for smaller card
                                  title: Text(
                                    notes[index]['content'],
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: const Color.fromARGB(255, 248, 246, 246)),
                                  ),
                                  subtitle: Text(
                                    notes[index]['timestamp']?.toDate().toString() ?? '',
                                    style: TextStyle(color: const Color.fromARGB(255, 242, 238, 238)),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/add-note');
                    },
                    child: Text('Add a New Note', style: TextStyle(fontSize: 18, color: const Color.fromARGB(255, 7, 7, 7))),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: const Color.fromARGB(255, 251, 250, 247), // Change to your desired color
                    ),
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

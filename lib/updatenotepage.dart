import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Updatenotespage extends StatelessWidget {
  final String? content;
  final String? docId;
  
  Updatenotespage({super.key, this.content, this.docId});

  @override
  Widget build(BuildContext context) {
    var subjectCrt = TextEditingController(text: content);

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://images.unsplash.com/photo-1614360182734-121501b81cc2?q=80&w=1930&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Main content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: subjectCrt,
                  decoration: InputDecoration(
                    labelText: 'Note Content',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 2.0),
                    ),
                    hintText: 'Enter your note here',
                    filled: true, // Fill the text field
                    fillColor:const Color.fromARGB(255, 214, 214, 214) , // Semi-transparent background
                  ),
                  maxLines: 5,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (subjectCrt.text.isNotEmpty) {
                      await FirebaseFirestore.instance
                          .collection('notes')
                          .doc(docId)
                          .update({"content": subjectCrt.text});
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please enter content')),
                      );
                    }
                  },
                  child: Text("Update"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection('notes')
                        .doc(docId)
                        .delete();
                    Navigator.pop(context);
                  },
                  child: Text("Delete"),
                  style: ElevatedButton.styleFrom(
                    
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    textStyle: TextStyle(fontSize: 18),
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

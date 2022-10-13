/*

 ListView.builder(
            itemCount: topics.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(topics[index]),
              trailing: subscribed.contains(topics[index])
                  ? ElevatedButton(
                      onPressed: () async {
                        await FirebaseMessaging.instance
                            .unsubscribeFromTopic(topics[index]);
                        await FirebaseFirestore.instance
                            .collection('topics')
                            .doc(token)
                            .update({topics[index]: FieldValue.increment(1)});
                        setState(() {
                          subscribed.remove(topics[index]);
                        });
                      },
                      child: Text('unsubscribe'),
                    )
                  : ElevatedButton(
                      onPressed: () async {
                        await FirebaseMessaging.instance
                            .subscribeToTopic(topics[index]);

                        await FirebaseFirestore.instance
                            .collection('topics')
                            .doc(token)
                            .set({topics[index]: 'subscribe'},
                                SetOptions(merge: true));
                        setState(() {
                          subscribed.add(topics[index]);
                        });
                      },
                      child: Text('subscribe')),
            ),
          )),
   
   
*/
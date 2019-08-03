const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp(functions.config().firebase);

var msgData;


    admin.firestore().collection('notification_token').get().then((snapshot) => {
        var tokens = [];
        if(snapshot.empty) {
            console.log('No Devices')
        } else {
            for (var token of snapshot.docs) {
                tokens.push(token.data().devToken);
            }
            var payload = {
                "notification": {
                    "title": "Message From Store Transaction",
                    "body": "Product Description " + msgData.description,
                    "sound": "default"
                },
                "data": {
                    "sendername": msgData.name,
                    "message": msgData.description
                }
            }
            return admin.messaging().sendToDevice(tokens, payload).then((response) => {
                console.log('Push them all');
            }).catch((err) => {
                console.log(err);
            })
        }
    })
})

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });

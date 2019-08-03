const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp(functions.config().firebase);

var msgData;

exports.productTrigger = functions.firestore.document(
    'products/{productId}'
).onCreate((snapshot, context) => {
    msgData = snapshot.data();

    admin.firestore().collection('notification_token').get().then((snapshots) => {
        var tokens = [];
        if (snapshots.empty) {
            console.log('No Devices');
        } else {
            for (var token of snapshots.docs) {
                tokens.push(token.data().sendToken);
            }
            var payload = {
                "notification": {
                    "title": "Message from Product",
                    "body": "The change is " + msgData.description,
                    "sound": "default"
                },
                "data": {
                    "sendername": "Sending " + msgData.name,
                    "message": "Changed"
                }
            }
            return admin.messaging().sendToDevice(tokens, payload).then((response) => {
                console.log('Push them all');
            }).catch((err) => {
                console.log(err);
            });
        }
    });
});

exports.onProductChange = functions.firestore.document(
    'products/{productId}'
).onWrite((change, context) => {
    console.log('Push Notification event trigger');
    admin.firestore().collection('notification_token').get().then((snapshots) => {
        var token = [];
        if (snapshot.empty) {
            console.log('No Device');
        }
        else {
            for(var token of snapshots.docs) {
                tokens.push(token.data().sendToken);
            }
            var request = change.after.val();
            var payload = {
                "notification": {
                    "title": "Message from Product",
                    "body": "Product updated" + msgData.description,
                    "sound": "default"
                },
                "data": {
                    "sendername": "Sending " + msgData.name,
                    "message": "Changed"
                }
            }
            return admin.messaging().sendToDevice(request.sendToken, payload).then((response) =>{
                console.log('Successfully send notification');
            }).catch((err) => {
                console.log('Err send notification', err);
            });
        }
    })
});

exports.onProductUpdate = functions.firestore.document(
    'products/{productId}'
).onUpdate((change, context) => {
    console('On Product Update');
    
    admin.firestore().collection('notification_token').get().then((snapshots) => {
        var token = [];
        if(snapshots.empty) {
            console.log('No Devices');
        }
        else {
            for (var token of snapshots.docs) {
                tokens.push(token.data().sendToken);
            }
            const data = change.after.data();
            const previousData = change.before.data();
            if(data == previousData) {
                console('Data not change');
            }
            else {
                var payload = {
                    "notification": {
                        "title": "Message from Product",
                        "body": "Product updated",
                        "sound": "default"
                    },
                    "data": {
                        "sendername": "Sending by admin",
                        "message": "Was Changed"
                    }
                }
                return admin.messaging().sendToDevice(tokens, payload).then((response) => {
                    console.log('Successfully send notification');
                }).catch((err) => {
                    console.log('Err send notification', err);
                });
            }
        }
    })
})


// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });

// firebase-messaging-sw.js
importScripts('https://www.gstatic.com/firebasejs/9.0.0/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/9.0.0/firebase-messaging.js');

firebase.initializeApp({
        apiKey: "AIzaSyDs2C7PvgXSUgCGoy7OcAGm55hlpbGtFVI",
        authDomain: "kebabbo-669ea.firebaseapp.com",
        projectId: "kebabbo-669ea",
        storageBucket: "kebabbo-669ea.firebasestorage.app",
        messagingSenderId: "12309724529",
        appId: "1:12309724529:web:c84bf69f2af9846fee4ad0",
        measurementId: "G-Z2YEVGGKTF"
      
});

const messaging = firebase.messaging();

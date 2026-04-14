// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyCuYZzhNJqM2ip3UcxVhfOW1aHb_0WqvRA",
  authDomain: "trendspot-22085.firebaseapp.com",
  projectId: "trendspot-22085",
  storageBucket: "trendspot-22085.firebasestorage.app",
  messagingSenderId: "1030555954341",
  appId: "1:1030555954341:web:4288f5826be20ff0b0f14c",
  measurementId: "G-10M1VX646K"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);

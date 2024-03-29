import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

FirebaseAuth firebaseAuth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseStorage storage = FirebaseStorage.instance;
final Uuid uuid = Uuid();

CollectionReference usersRef = firestore.collection('users');
CollectionReference chatRef = firestore.collection('chats');
CollectionReference postRef = firestore.collection('posts');
CollectionReference storyRef = firestore.collection('posts');
CollectionReference notificationRef = firestore.collection('notifications');
CollectionReference followersRef = firestore.collection('followers');
CollectionReference followingRef = firestore.collection('following');
CollectionReference likesRef = firestore.collection('likes');
CollectionReference favoriteUsersRef = firestore.collection('favoriteUsers');
CollectionReference chatIdRef = firestore.collection('chatIds');
CollectionReference statusRef = firestore.collection('status');

Reference profilePicture = storage.ref().child('profilePicture');
Reference posts = storage.ref().child('posts');
Reference statuses = storage.ref().child('status');

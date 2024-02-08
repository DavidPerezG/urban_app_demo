// import 'package:wordpress_api/wordpress_api.dart'; 

// enum ApiRequestStatus { success, failure }

// class ApiRequestResult<T> {
//   final ApiRequestStatus status;
//   final T data;
//   final String error;

//   ApiRequestResult({
//     required this.status,
//     required this.data,
//     required this.error,
//   });
// }

// Future<ApiRequestResult<List<Post>>> fetchPosts() async {
//   final request = ListPostRequest(
//   page: 1,
//   perPage: 20,
//   order = Order.asc,
// );

// final wpResponse = await client.posts.list(request);

// // Dart 3 style
// switch (wpResponse) {
//     case WordpressSuccessResponse():
//       final data = wpResponse.data; // List<Post>
//       break;
//     case WordpressFailureResponse():
//       final error = wpResponse.error; // WordpressError
//       break;
// }

// // or
// // wordpress_client style
// final result = postsResponse.map(
//     onSuccess: (response) {
//       print(response.message);
//       return response.data;
//     },
//     onFailure: (response) {
//       print(response.error.toString());
//       return <Post>[];
//     },
// );
// }

sealed class PostEvent {}

class FetchPostsEvent extends PostEvent {}

class FetchPostEvent extends PostEvent {
  final int id;

  FetchPostEvent(this.id);
}

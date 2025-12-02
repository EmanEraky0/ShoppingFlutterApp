sealed class UiResult<T> {
  const UiResult();
}

class Loading<T> extends UiResult<T> {}

class Success<T> extends UiResult<T> {
  final T data;
  const Success(this.data);
}

class Error<T> extends UiResult<T> {
  final String message;
  const Error(this.message);
}


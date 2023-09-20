class ApiResponse<T> {
  Status status;
  T? data;
  String? message;

  ApiResponse.initial(this.message):status = Status.INITIAL;

  ApiResponse.loading(this.message):status = Status.LOADING;

  ApiResponse.error(this.message):status = Status.ERROR;

  ApiResponse.completed(this.data):status = Status.COPMLETED;

}

enum Status{INITIAL,ERROR,COPMLETED,LOADING}
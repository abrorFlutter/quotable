class ApiException implements Exception{
  final String? _message;
  final String?_prefix;

  ApiException([this._message,this._prefix]);


  @override
  String toString() {
    return "$_prefix - $_message";
  }
}

  class BadRequestException extends ApiException{
    BadRequestException([String? message]): super(message,"invalid request");
  }

  class UnauthorizedException extends ApiException{
    UnauthorizedException([String? message]): super(message,"unauthorized request");
  }

  class NotFoundException extends ApiException{
    NotFoundException([String? message]): super(message,"not found ");
  }



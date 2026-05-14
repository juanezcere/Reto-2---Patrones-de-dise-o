
class ApplicationException(RuntimeWarning):
    def __init__(self, message):
        super().__init__(message)


class EmailRequiredError(ApplicationException):
    def __init__(self, message: str = "Email is required"):
        super().__init__(message)


class EmailFormatError(ApplicationException):
    def __init__(self, message: str = "Invalid email format"):
        super().__init__(message)


class InvalidEmailError(ApplicationException):
    def __init__(self, message: str = "Email is invalid"):
        super().__init__(message)


class EmailExistsError(ApplicationException):
    def __init__(self, message: str = "Email already exists"):
        super().__init__(message)


class EmailNotFoundError(ApplicationException):
    def __init__(self, message: str = "Email was not found"):
        super().__init__(message)

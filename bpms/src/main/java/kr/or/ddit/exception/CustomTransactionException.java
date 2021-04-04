package kr.or.ddit.exception;

public class CustomTransactionException extends RuntimeException {

	public CustomTransactionException() {
		super();
	}

	public CustomTransactionException(String message, Throwable cause, boolean enableSuppression,
			boolean writableStackTrace) {
		super(message, cause, enableSuppression, writableStackTrace);
	}

	public CustomTransactionException(String message, Throwable cause) {
		super(message, cause);
	}

	public CustomTransactionException(String message) {
		super(message);
	}

	public CustomTransactionException(Throwable cause) {
		super(cause);
	}
}

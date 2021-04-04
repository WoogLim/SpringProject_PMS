package kr.or.ddit.exception;

public class SqlInsertFailedException extends RuntimeException {

	public SqlInsertFailedException() {
		super();
	}

	public SqlInsertFailedException(String message, Throwable cause, boolean enableSuppression,
			boolean writableStackTrace) {
		super(message, cause, enableSuppression, writableStackTrace);
	}

	public SqlInsertFailedException(String message, Throwable cause) {
		super(message, cause);
	}

	public SqlInsertFailedException(String message) {
		super(message);
	}

	public SqlInsertFailedException(Throwable cause) {
		super(cause);
	}

}

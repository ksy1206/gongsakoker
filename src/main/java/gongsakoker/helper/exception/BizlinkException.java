package gongsakoker.helper.exception;

/**
 * bizlink Exception
 * @author 박정후 
 *
 */

public class BizlinkException extends Exception {
	
	private static final long serialVersionUID = 1L;
	
	public BizlinkException(String message) {
        super(message);
    }
	
    public BizlinkException(String message, Exception rootCause) {
        super(message, rootCause);
    }
    
}

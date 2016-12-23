/**
* BaseException.java
*
* VMS_BATCH
*
* Copyright 2012 smartro.com All Rights Reserved.
*/
package gongsakoker.helper.exception;


/**
* 설명 : BaseException
*
************************************************
* DATE          AUTHOR           DESCRIPTION
* ----------------------------------------------
* 2015.11.18.    박정후     Initial Release
************************************************
*
* @author      박정후
* @version     1.0
* @since       2015.11.18.
*/
public class BaseException extends Exception
{
   
    /**
     * serialVersionUID
     */
    private static final long serialVersionUID = -5545847497854545223L;
   
    /**
     *
     */
    public BaseException() {
        super();
        // TODO Auto-generated constructor stub
    }
   
    /**
     * @param message
     * @param cause
     */
    public BaseException( String message, Throwable cause ) {
        super(message, cause);
        // TODO Auto-generated constructor stub
    }
   
    /**
     * @param message
     */
    public BaseException( String message ) {
        super(message);
        // TODO Auto-generated constructor stub
    }
   
    /**
     * @param cause
     */
    public BaseException( Throwable cause ) {
        super(cause);
        // TODO Auto-generated constructor stub
    }
   
}
/**
 * BusinessException.java
 *
 * VMS_BATCH
 *
 * Copyright 2012 smartro.com All Rights Reserved.
 */
package gongsakoker.helper.exception;

 /**
 * 설명 : BusinessException
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
public class BusinessException extends BaseException
{
    
    /**
     * serialVersionUID
     */
    private static final long serialVersionUID = -7223787629794134503L;
    
    /**
     * 메시지
     */
    private String            msg              = null;
    /**
     * 익셉션
     */
    private Exception         ex               = null;
    
    /**
     * BusinessException 생성자 주석
     */
    public BusinessException() {
        super();
    }
    
    /**
     * BusinessException 생성자
     * 
     * @param s
     *            Exception Message
     * 
     */
    public BusinessException( String s ) {
        super(s);
        this.msg = s;
    }
    
    /**
     * 익셉션 생성자
     * 
     * @param message
     *            Exception Message
     * @param e
     *            Exception
     */
    public BusinessException( String message, Exception e ) {
        super();
        this.msg = message;
        this.ex = e;
    }
    
    /**
     * 익셉션 취득
     * 
     * @return java.lang.Exception
     */
    public java.lang.Exception getException()
    {
        return ex;
    }
    
    /**
     * 익셉션메시지 취득
     * 
     * @return 硫붿떆吏�
     */
    public java.lang.String getMsg()
    {
        return msg;
    }
    
}

/**
* FileUtil.java
*
* VMS_BATCH
*
* Copyright 2012 smartro.com All Rights Reserved.
*/
package gongsakoker.helper.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.nio.channels.FileChannel;

/**
* 설명 :  파일처리 유틸
*
************************************************
* DATE          AUTHOR           DESCRIPTION
* ----------------------------------------------
* 2015.11.30    박정후     Initial Release
************************************************
*
*/
public class FileUtil
{
    /**
     * 파일 Object 저장
     *
     * @param outputFilePath
     *            저장경로(파일명 포함)
     * @param obj
     *            저장대상 Object
     * @throws IOException
     *             처리 에러 시
     */
    public static void doObjectFileWrite( String outputFilePath, Object obj )
            throws IOException
    {
        FileOutputStream fout = null;
        ObjectOutputStream oout = null;
        fout = new FileOutputStream(outputFilePath);
        oout = new ObjectOutputStream(fout);
        oout.writeObject(obj);
        oout.reset();
        fout.close();
        oout.close();
    }
   
    /**
     * Object File 읽기
     *
     * @param inputFilePath
     * @param targetFileName
     * @return Object Object
     * @throws IOException
     * @throws ClassNotFoundException
     */
    public static Object readObjectFromFile( String inputFilePath,
            String targetFileName ) throws IOException, ClassNotFoundException
    {
        FileInputStream fin = null;
        ObjectInputStream oin = null;
        Object obj = null;
        fin = new FileInputStream(inputFilePath + targetFileName);
        oin = new ObjectInputStream(fin);
        obj = oin.readObject();
        fin.close();
        oin.close();
        return obj;
    }
   
    /**
     * 파일 카피
     *
     * @param fromPath
     * @param toPath
     * @throws IOException
     */
    public static final void copy( String fromPath, String toPath )
            throws IOException
    {
        File sourceFile = new File(fromPath);
        FileInputStream input = null;
        FileOutputStream output = null;
        FileChannel fcin = null;
        FileChannel fcout = null;
        input = new FileInputStream(sourceFile);
        output = new FileOutputStream(toPath);
        fcin = input.getChannel();
        fcout = output.getChannel();
        long size = fcin.size();
        fcin.transferTo(0, size, fcout);
        fcout.close();
        output.close();
        input.close();
    }
   
    /**
     * 파일 삭제
     *
     * @param fromPath
     * @param toPath
     * @throws IOException
     */
    public static final void deleteFile(String path)
            throws IOException
    {
        File sourceFile = new File(path);
       
        if(sourceFile.exists())
             sourceFile.delete();

    }
   
    /**
     * 파일 이동
     *
     * @param fromPath
     * @param toPath
     * @throws IOException
     */
    public static final void moveFile(String fromPath, String toPath, String fileName)
            throws IOException
    {
        File sourceFile = new File(fromPath);
        File newFile = new File(toPath);
  
        if(sourceFile.exists()) {
             if(!newFile.isDirectory()) {
                  newFile.mkdirs();
             }
            
             //기존 등록된 파일이 있을 경우 삭제한다.
             if(new File(toPath + File.separator + fileName).exists())
                  new File(toPath + File.separator + fileName).delete();
            
             sourceFile.renameTo(new File(toPath + File.separator + fileName));
        }
    }
   
   
}
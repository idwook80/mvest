package com.mvest.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

public class FileUtil {
	
	public static boolean fileMake(String inFileName){
		File f = new File(inFileName);
		if(!f.exists())
			try {
				return f.createNewFile();
			} catch (IOException e) {
				e.printStackTrace();
				return false;
			}
		else return false;
	}
	public static boolean fileDelete(String inFileName){
		
		File f = new File(inFileName);
		if(f.exists()){
			System.out.println("delete:"+f.getPath());
			return f.delete();
		}else{
			System.out.println("delete error:"+inFileName);
		}
		return false;
	}
	public static boolean fileMove(String inFileName,String outFileName){
		if(fileCopy(inFileName, outFileName)){
			return fileDelete(inFileName);
		}else {
			return false;
		}
		
	}
	public static boolean fileCopy(String inFileName,String outFileName){
		try {
			FileInputStream fis = new FileInputStream(inFileName);
			FileOutputStream fos = new FileOutputStream(outFileName);
			
			int data = 0;
			while((data=fis.read()) != -1){
				fos.write(data);
			}
			fis.close();
			fos.close();
		} catch (IOException e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
	public static File createFile(String inFileName) throws IOException{
		File f = new File(inFileName);
		if(!f.exists())
				f.createNewFile();
		return f;
	}
}

package com.mvest.util;

import java.math.BigInteger;
import java.text.DecimalFormat;

public class StringUtil {
	public static String limitString(String str,int size,String delim){
		if(str.length() > size){
			return str.substring(str.length()-size, str.length());
		}
		String ret = str;
		while(ret.length() < size){
			ret = delim + ret;
		}
		return ret;
	}
	
	public static String withoutComma(String num){
		return num.replace(",", "");
	}
	public static String comma(String num){
		return comma(Integer.parseInt(num));
	}
	public static String comma(int num) {
		  DecimalFormat df = new DecimalFormat("#,###");
		  return df.format(num);
	}
	
	/**
	 * String Length Utils
	 */
		public static String getLimitString(String str,int size,String delim){
			if(str.length() > size) 
				return str.substring(str.length()-size,str.length());
			String _str = str;
			while(_str.length() < size){
				_str = delim+_str;
			}
			return _str;
		}
		public static String getRoom(String room,int size){
			return getLimitString(room,size,"0");
		}
	
		
		public static String getRoom(byte[] room,int size){
			String roomnumber = asciiFromByte(room);
			return getRoom(roomnumber,size);
		}
		
		public static String getWithoutZero(String room){
			return ""+Integer.parseInt(room);
		}
		public static String getWithoutZero(String room,int limit){
			String newRoom = getWithoutZero(room);
			if(newRoom.length() > limit) return newRoom;
			return getRoom(newRoom,limit);
		}
		
		
		public static int decimalFromByte(byte data) {
			BigInteger ret = BigInteger.valueOf(data & 0xff);
			return ret.intValue();
		}
		
		public static int[] decimalFromByte(byte[] data) {
			int[] ret = new int[data.length];
			for(int i=0; i<data.length; i++) {
				ret[i] = decimalFromByte(data[i]);
			}
			return ret;
		}
		public static String decimalFromByteString(byte[] data,String delim) {
			int[] decs = decimalFromByte(data);
			String ret = "";
			for(int i=0; i<decs.length; i++) {
				ret += String.valueOf(decs[i]);
				if(delim != null && i < decs.length-1) ret += delim;
			}
			return ret;
		}
			
		
	/**
	 * String From Byte 
	 */
		public static String asciiFromByte(byte[] _data){
			String _ascii = "";
			for(int i=0; i<_data.length; i++){
				_ascii += asciiFromByte(_data[i]);
			}
			return _ascii;
		}
		public static String asciiFromByte(byte _data){
			return (_data < (byte)0x21 || _data > 0x7F) ? " " : String.format("%c", _data);
		}
		public static String hexFromByte(byte[] _data){
			String _hex = "";
			for(int i=0; i<_data.length; i++){
				_hex += hexFromByte(_data[i]);
			}
			return _hex;
		}
		public static String hexFromByte(byte[] _data,String delim,int n){
			String _hex = hexFromByte(_data);
			String _hex_delim = "";
			
			for(int i=0; i<_hex.length(); i+=n){
				_hex_delim += _hex.substring(i,(i+n));
				if(i<_hex.length()-n){
					_hex_delim += delim;
				}
			}
			return _hex_delim;
		}
		public static String hexFromByte(byte _data){
			return String.format("%02X", _data);
		}
		
		public static String asciiHexFromBytes(byte[] _data,int length){
			return asciiHexFromBytes(_data,0,length);
		}
		public static String asciiHexFromBytes(byte[] _data,int start,int offset){
			if(_data.length < start+offset && (offset-start) < 0) return "";
			
			String reStr = "";
			for(int i=0; i<_data.length; i++){
				if(i<=start && i<(start+offset)){
					reStr += asciiFromByte(_data[i]);
				}else{
					reStr += hexFromByte(_data[i]);
				}
			}
			return reStr;
		}
		public static char[] binaryCharFromByte(byte _data){
			char[] buf = new char[8];
			int charPos = 8;
			int idx = 0;
			do{
				charPos--;
				if(getBitInt(charPos,_data)== 1){
					buf[idx++] = '1';
				}else{
					buf[idx++] = '0';
				}
			}while(charPos != 0);
				
			return  buf;
		}
		public static String binaryFromByte(byte _data){
			return new String(binaryCharFromByte(_data));
		 }
		public static byte byteFromBinary(String _data){
			int[] b = { 0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80 };
			if(_data.length() > 8 ) return 0x00;
			int value = 0;
			int idx = 1;
			for(int i=0; i<_data.length(); i++){
				char ch = _data.charAt(i);
				if(ch == '1'){
					value += b[i];
				}
			}
			return (byte)value;
		}
	/**
	 *  Byte,Bytes From String
	 */
		public static byte byteFromAscii(char _data){
			return (byte)_data;
		}
		public static byte[] byteFromAscii(String _data){
			return _data.getBytes();
		}
		public static byte byteFromHex(String _data){
			byte imData[] = _data.getBytes();
			imData = _data.trim().toUpperCase().getBytes();
			if(!((imData[0]>(byte)0x2f && imData[0]<(byte)0x3a) || (imData[0]>(byte)0x40 && imData[0] < (byte)0x47))){return 0x00;}
			if(!((imData[1]>(byte)0x2f && imData[1]<(byte)0x3a) || (imData[1]>(byte)0x40 && imData[1] < (byte)0x47))){return 0x00;}
			if(imData[0]>(byte)0x2f && imData[0]<(byte)0x3a) imData[0] = (byte) (imData[0]&(byte)0x0f);
			if(imData[1]>(byte)0x2f && imData[1]<(byte)0x3a) imData[1] = (byte) (imData[1]&(byte)0x0f);
			if(imData[0]>(byte)0x40 && imData[0]<(byte)0x47) imData[0] = (byte) ((imData[0]&(byte)0x0f)+(byte)0x09);
			if(imData[1]>(byte)0x40 && imData[1]<(byte)0x47) imData[1] = (byte) ((imData[1]&(byte)0x0f)+(byte)0x09);
			
			byte reData = (byte) ((imData[0]<<4)+imData[1]);
			return reData;
		}
		
		public static byte[] bytesFromHex(String _data){
			if(_data == null || _data.equals("")) return null;
			byte[] _temp = new byte[_data.length()/2];
			for(int i=0; i<_data.length()/2; i++){
				_temp[i] = byteFromHex(_data.substring(i*2,(i*2)+2));
			}
			return _temp;
		}
		
		public static byte[] bytesAdd(Object... args) {
			byte[] ret = new byte[0];
			
			for(int i=0; i<args.length; i++) {
				byte[] temp = null;
				if(args[i]  instanceof java.lang.Byte) {
					temp = new byte[ret.length+1];
					
					System.arraycopy(ret, 0, temp, 0, ret.length);
					
					temp[temp.length-1] = (byte) args[i];
					
				}else if(args[i] instanceof byte[]) {
					int length 	= ((byte[])args[i]).length;
					
					temp 		= new byte[ret.length+length];
					
					System.arraycopy(ret, 0, temp, 0, ret.length);
				 
					System.arraycopy((byte[])args[i], 0, temp, ret.length, length);
					
				}
				if(temp != null) {
					ret = new byte[temp.length];
					System.arraycopy(temp, 0, ret, 0, temp.length);
				}
			}
			
			return ret;
		}
		/**
		 *  Int From byteString
		 */
		
		public static int unsignIntFromByte(byte data){
			String _data = hexFromByte(data);
			byte unsign1 = byteFromHex("0"+_data.substring(0,1));
			byte unsign2 = byteFromHex("0"+_data.substring(1,2));
			return (int)unsign1*16 + (int)unsign2;
		}

		/**
		 * 
		 * Print Format get From Bytes 
		 */
		public static String getHexAsciiFromBytes(byte[] data){
			String str = "";
			str += "[HEX  ] : "+hexFromByte(data)+ "]+\n";
			str += "[ASCII] : "+asciiFromByte(data)+"]";
			return str;
		}
		public static String getHexAsciiFromBytes(byte data){
			String str = "";
			str += "[HEX  ] : "+hexFromByte(data)+ "]";
			str += "[ASCII] : "+asciiFromByte(data)+"]";
			return str;
		}
		
		/**
		 *   Convert binary 11111111 => 0xff
		 */
		public byte binaryStringToByte(String s){
		    byte ret=0, total=0;
		    for(int i=0; i<8; ++i){        
		        ret = (s.charAt(7-i)=='1') ? (byte)(1 << i) : 0;
		        total = (byte) (ret|total);
		    }
		    return total;
		}

		
		/**
		 * Convert Flags
		 */
		public static byte getByteFromFlag(String flag){
			int value = 0;
			for(int i=0; i<flag.length(); i++){
				if(flag.charAt(i) == 'Y' || flag.charAt(i) == 'y'){
					if(i == 0) value += 1;
					else value += (int)Math.pow(2, i);
				}
			}
			return (byte)value;
		}
		public static String getFlagFromByte(byte data){
			String binary = getRoom(Integer.toBinaryString(data),8);
		    String flag = "";
		    for(int i=binary.length()-1; i>=0; i--){
		    	char ch = binary.charAt(i);
		    	String bit = (ch == '1') ? "Y" : "N";
		    	flag += bit;
		    }
		    return flag;
		}
		public static String getFlagsFromBytes(byte[] data){
			String flags = "";
			for(int i=0; i<data.length; i++){
				flags += getFlagFromByte(data[i]);
			}
			return flags;
		}
		
		/**
		 * BIT Binary
		 */
		public static int getBitInt(int n,byte bit){
			byte[] temp = new byte[8];
			temp[0] = (byte)0x01;
			temp[1] = (byte)0x02;
			temp[2] = (byte)0x04;
			temp[3] = (byte)0x08;
			temp[4] = (byte)0x10;
			temp[5] = (byte)0x20;
			temp[6] = (byte)0x40;
			temp[7] = (byte)0x80;
			
			if((temp[n]&bit) == temp[n]){
				return 1;
			}
			return 0;
		}
		
		public static boolean isIpFormat(String ip)throws Exception{
			String[] dot = ip.replace(".", "#@").split("#@");
			if(dot.length !=4 ){
				 throw new Exception("Format");
			}else{
				for(int i=0; i<dot.length; i++){
					int nFormat = 0;
						try{
						nFormat = Integer.parseInt(dot[i]);
						}catch(NumberFormatException ee){
							throw ee;
						}
					if(nFormat < 0 || nFormat>255){
						throw new Exception("(0~255)");
					}
				}
					
			}
			return true;
		}
		
		public static final byte[] intToByteArray(int value){
			return new byte[]{
				(byte)(value >>> 24),
				(byte)(value >>> 16),
				(byte)(value >>> 8),
				(byte)value
			};
		}
		public static final int byteArrayToInt(byte[] b){
			int sum = 0;
			int idx = 0;
			for(int i=b.length; i>0; i--){
				if(i == 4) sum += b[idx++] << 24;
				if(i == 3) sum += b[idx++]&0xFF << 16;
				if(i == 2) sum += b[idx++]&0xFF << 8;
				if(i == 1) sum += b[idx++]&0xFF;
			}
		
			return sum;
		}
}

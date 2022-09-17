package com.mvest.test.binance;


import com.binance.client.RequestOptions;
import com.binance.client.SyncRequestClient;


public class BinanceApiTest {
	
	   public final static String API_KEY 		= "Gju5mxDvTQwRmIyfMT9BzqSlpomk0FSSpkzbQZAfXG1goB48j4bsRlydXontikUp";
	   public final static String SECRET_KEY 	= "rCotzv08GlsISkVoujokuxsfAh3jeZedIQ6DsuKhNFwBfdsBrtU6WtB8KTm5Beq0";
	
	  public static void main(String[] args) {
	        RequestOptions options = new RequestOptions();
	        SyncRequestClient syncRequestClient = SyncRequestClient.create(API_KEY, SECRET_KEY,
	                options);
	        
	        for(int i=0; i<1; i++) {
	        	 // System.out.println(syncRequestClient.getBalance());
	        	  System.out.println(syncRequestClient.getAccountInformation());
	        	 // System.out.println(syncRequestClient.getMarkPrice("BTCUSDT"));
	        	  
	        	  try {
					Thread.sleep(1000 * 5);
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	        }
	    }
}

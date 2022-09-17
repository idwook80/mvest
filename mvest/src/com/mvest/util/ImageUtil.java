package com.mvest.util;

import java.awt.Color;
import java.awt.Font;
import java.awt.FontMetrics;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.RenderingHints;
import java.awt.font.FontRenderContext;
import java.awt.font.LineMetrics;
import java.awt.geom.Rectangle2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;

import javax.imageio.ImageIO;

import org.apache.log4j.Logger;

public class ImageUtil {
	public final static Logger LOG = Logger.getLogger(ImageUtil.class);
	
	public static final HashMap<RenderingHints.Key, Object> RenderingProperties = new HashMap<>();

	static{
	    RenderingProperties.put(RenderingHints.KEY_TEXT_ANTIALIASING, RenderingHints.VALUE_TEXT_ANTIALIAS_ON);
	    RenderingProperties.put(RenderingHints.KEY_STROKE_CONTROL, RenderingHints.VALUE_STROKE_PURE);
	    RenderingProperties.put(RenderingHints.KEY_FRACTIONALMETRICS, RenderingHints.VALUE_FRACTIONALMETRICS_ON);
	}

	public static BufferedImage textToImage(int width,int height,String Text, Font f, float Size,String fileName,boolean isFile) throws IOException{
	    //Derives font to new specified size, can be removed if not necessary.
		  try{
		double size = height/3;
		if(width>height) size = height/3;
		else size =width/3;
		
		if(size<1) size =1;
		if(f == null) f  = new Font("Arial", Font.PLAIN, (int) size);
	    f = f.deriveFont((float)size);
	   
	    FontRenderContext frc = new FontRenderContext(null, true, true);
	    //Calculate size of buffered image.
	   
	    //LineMetrics lm = f.getLineMetrics(Text, frc);
	    LOG.debug("textToImage...2 "+frc.toString());
	    char[] array = Text.toCharArray();
	    Rectangle2D r2d = f.getStringBounds(array, 0, array.length, frc);
/*	    Rectangle2D r2d = f.getStringBounds(Text, frc);*/
	    LOG.debug("textToImage...3 ");
	    if(r2d.getWidth() > width) {
	    	size=size/1.5;
	    	if(size <1) size = 1;
	    	f  = new Font("Arial", Font.PLAIN, (int) size);
		    f = f.deriveFont((float)size);
		    frc = new FontRenderContext(null, true, true);
		  
		   // lm = f.getLineMetrics(Text, frc);
		    r2d = f.getStringBounds(Text, frc);
	    }
	   
		    double realHeight = r2d.getHeight();
		    double realWidth = r2d.getWidth();
	   
	  // BufferedImage img = new BufferedImage((int)Math.ceil(r2d.getWidth()), (int)Math.ceil(r2d.getHeight()), BufferedImage.TYPE_INT_RGB);
	    BufferedImage img = new BufferedImage((int)Math.ceil(width), (int)Math.ceil(height), BufferedImage.TYPE_INT_RGB);

	    Graphics2D g2d = img.createGraphics();

	    g2d.setRenderingHints(RenderingProperties);
	    
	    Color backColor = new Color(45, 108, 147);
	    g2d.setBackground(backColor);
	    g2d.setColor(Color.WHITE);

	    g2d.clearRect(0, 0, img.getWidth(), img.getHeight());

	    g2d.setFont(f);
	    
	   // g2d.drawString(Text, 0, lm.getAscent());
	    g2d.drawString(Text, (float) ((width/2)-(realWidth/2)), (float) ((height/2)+(realHeight/4)));
	    g2d.dispose();
	    if(isFile) ImageIO.write(img, "jpg", new File(fileName));
		 
	    return img;
		  }catch(Exception e){
		    	LOG.error(e);
		    	throw e;
		    }
	}
	public static BufferedImage textToImage1(int width,int height,String Text, Font f, float Size,String fileName,boolean isFile) throws IOException{
		BufferedImage img = new BufferedImage((int)Math.ceil(width), (int)Math.ceil(height), BufferedImage.TYPE_INT_RGB);
		Graphics2D g2d = img.createGraphics();
		boolean sizeOk = false;
		    
		    
		double size = height/3;
		if(width>height) size = height/3;
		else size =width/3;
		
		int realWidth = 10;
		int realHeight = 10;
		while(!sizeOk){
		
			
			if(f == null) f  = g2d.getFont();
		    f = f.deriveFont((float)size);
			
		    FontMetrics fm = g2d.getFontMetrics(f);
		    realWidth = fm.stringWidth(Text);
		    realHeight = fm.getHeight();
		    size=size/1.5;
		    if(realWidth<width || size<0) sizeOk = true;
		    
		}
	    
	    g2d.setRenderingHints(RenderingProperties);
	    
	    Color backColor = new Color(45, 108, 147);
	    g2d.setBackground(backColor);
	    g2d.setColor(Color.WHITE);

	    g2d.clearRect(0, 0, img.getWidth(), img.getHeight());

	    g2d.setFont(f);
	    
	   // g2d.drawString(Text, 0, lm.getAscent());
	    g2d.drawString(Text, (float) ((width/2)-(realWidth/2)), (float) ((height/2)+(realHeight/4)));
	    g2d.dispose();
	    if(isFile) ImageIO.write(img, "jpg", new File(fileName));
		 
	    return img;
	}
	public static BufferedImage resizeImage(BufferedImage image, int width, int height) {
		float w = new Float(width) ;
		float h = new Float(height) ;

		if ( w <= 0 && h <= 0 ) {
		w = image.getWidth();
		h = image.getHeight();
		} else if ( w <= 0 ) {
		w = image.getWidth() * ( h / image.getHeight() ); 
		} else if ( h <= 0 ) {
		h = image.getHeight() * ( w / image.getWidth() ); 
		}

		int wi = (int) w;
		int he = (int) h;

		BufferedImage resizedImage = new BufferedImage(wi,he,BufferedImage.TYPE_INT_RGB);

		resizedImage.getGraphics().drawImage(
				image.getScaledInstance(wi,he,Image.SCALE_AREA_AVERAGING),
				0,0,wi,he,null
		);

		return resizedImage;

	}
}

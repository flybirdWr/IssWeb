package servlet.captcha.validation;

import servlet.captcha.Encoder.AnimatedGifEncoder;
import util.KeyConst;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
/*
使用方法：
1，实例化对象		Validation test =new Validation();
2，设置其长宽 		void setSize(int width,int height);
3，设置其长度		void setCode(int length);
4,写入session 	boolean writeSession(HttpSession session);
5,输出图像 		BufferedImage getPngImage();
 */
public class Validation {
	private int width;
	private int height;			
	private char[] code;		//验证码内容

	/**
	 * defalut size value of the image is 150*80
	 */
	public Validation(){
		//缺省值
		width=120;
		height=80;

	}

	public Validation(int width,int height){
		this.width=width;
		this.height=height;
	}

	public static void main(String args[]) {
		//写入png文件
		Validation test = new Validation(150, 80);
		test.setCode(4);

		try {
			BufferedImage image = test.getPngImage();
			FileOutputStream out = new FileOutputStream("G://" + test.getCode() + ".png");
			ImageIO.write(image, "png", out);
			System.out.println("写入文件成功！" + test.getCode());
		} catch (IOException e) {
			System.out.println("文件写入失败！");
		}

		//写入gif文件(暂时未完成！)
//		Validation test2=new Validation();
//		test2.setCode(4);
//		try {
//			FileOutputStream out = new FileOutputStream("G://" + test2.getCode() + ".gif");
//			test2.getGifImage(out);
//			out.flush();
//			out.close();
//			System.out.println("文件写入成功！"+test2.getCode());
//		}
//		catch(Exception e){
//			System.out.println("文件写入失败！");
//		}
	}

	public void setSize(int width,int height){
		this.width=width;
		this.height=height;
	}

	public boolean writeSession(HttpSession session){
		session.setAttribute(KeyConst.CAPTCHA, getCode());
		return true;
	}

	public BufferedImage getPngImage(){
		BufferedImage image=new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);//创建一个不带透明色的BufferedImage对象

		try {

			Graphics2D g = (Graphics2D) image.getGraphics();
			AlphaComposite ac;
			Color color;
			Font font;

			int length = code.length;
			g.setColor(Color.white);
			g.fillRect(0, 0, width, height);
			//干扰线
			for(int i=0;i<15;i++){
				color=GetRandom.getColor();
				g.setColor(color);
				//g.drawOval(GetRandom.getNum(width), GetRandom.getNum(height), 15 + GetRandom.getNum(10), 15 + GetRandom.getNum(10));//圈
				int y=GetRandom.getNum(width);
				g.drawLine(0,y,width,y);//直线
				color=null;
			}

			//画图
			for (int i = 0; i < length; i++) {
				font=GetRandom.getFont();//随机字体

				int h = height - ((height - font.getSize()) >> 1);
				int w = width / length;
				int size = w - font.getSize() + 1;
				//g.setTransform(GetRandom.getTransform());
				g.setFont(font);
				//指定透明度
				ac = AlphaComposite.getInstance(AlphaComposite.SRC_OVER,1.0f);
				g.setComposite(ac);
				//每个字符设置随机颜色
				color = GetRandom.getColor();
				g.setColor(color);
				g.drawString(code[i] + "", (width - (length - i) * w) + size, h - 4);//验证码内容
				//强行回收
				color = null;
				font=null;
				ac = null;
			}
		}
		catch (Exception e){
			System.out.println(e.fillInStackTrace());
		}
		return image;
	}

//	public void getGifImage(OutputStream out){
//		BufferedImage image=new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
//		Graphics2D g=(Graphics2D)image.getGraphics();
//		try{
//			AnimatedGifEncoder gif=new AnimatedGifEncoder();
//			gif.start(out);
//			gif.setDelay(100);
//			for(int i=0;i<code.length;i++){
//				image=graphicsFrame(g,i);
//				gif.addFrame(image);
//			}
//			gif.finish();
//		}catch(Exception e){
//			System.out.println(e.fillInStackTrace());
//		}
//	}

//	private BufferedImage graphicsFrame(Graphics2D g,int flag){
//		BufferedImage image = new BufferedImage(width, height,BufferedImage.TYPE_INT_RGB);
//		g.setColor(Color.white);
//		g.fillRect(0, 0, width, height);
//		AlphaComposite ac;
//		System.out.println(code.length);
//		for(int i=0;i<code.length;i++)
//		{
//			Font font=GetRandom.getFont();
//			int h  = height - ((height - font.getSize()) >>1) ;
//			int w = width/code.length;
//			g.setFont(font);
//			ac = AlphaComposite.getInstance(AlphaComposite.SRC_OVER, getAlpha(flag, i));
//			g.setComposite(ac);
//			g.setColor(GetRandom.getColor());
//			g.drawOval(GetRandom.getNum(width), GetRandom.getNum(height), 5+GetRandom.getNum(10), 5+GetRandom.getNum(10));
//			g.drawString(code[i]+"", (width-(code.length-i)*w)+(w-font.getSize())+1, h-4);
//		}
//		return image;
//	}

	//获取透明度，[0,1]，自动获取步长
//	private float getAlpha(int i,int j){
//		int num=i+j;
//		float r=(float)1/code.length;
//		float s=(code.length+1)*r;
//		return num>code.length?(num*r-s):num*r;
//	}

	public String getCode(){
		String temp="";
		for(int i=0;i<code.length;i++){
			temp+=code[i];
		}
		return temp;
	}

	public void setCode(int length) {
		code = new char[length];
		for (int i = 0; i < length; i++) {
			code[i] = GetRandom.getChar();
		}
	}



//	public void out(OutputStream os)
//	{
//		int len=code.length;
//		try {
//			AnimatedGifEncoder gifEncoder = new AnimatedGifEncoder();   // gif编码类，这个利用了洋人写的编码类，所有类都在附件中
//			//生成字符
//			gifEncoder.start(os);
//			gifEncoder.setQuality(180);
//			gifEncoder.setDelay(100);
//			gifEncoder.setRepeat(0);
//			BufferedImage frame;
//			Color fontcolor[] = new Color[len];
//			for (int i = 0; i < len; i++) {
//				fontcolor[i] = new Color(20 + GetRandom.getNum(110), 20 + GetRandom.getNum(110), 20 + GetRandom.getNum(110));
//			}
//			for (int i = 0; i < len; i++) {
//				frame = graphicsImage(fontcolor, code, i);
//				gifEncoder.addFrame(frame);
//				frame.flush();
//			}
//			gifEncoder.finish();
//		}catch(Exception e){
//			e.printStackTrace();
//		}
//
//	}
//
//	/**
//	 * 画随机码图
//	 * @param fontcolor 随机字体颜色
//	 * @param strs 字符数组
//	 * @param flag 透明度使用
//	 * @return BufferedImage
//	 */
//	private BufferedImage graphicsImage(Color[] fontcolor,char[] strs,int flag)
//	{
//		int len=code.length;
//		Font font=GetRandom.getFont();
//		BufferedImage image = new BufferedImage(width, height,BufferedImage.TYPE_INT_RGB);
//		//或得图形上下文
//		//Graphics2D g2d=image.createGraphics();
//		Graphics2D g2d = (Graphics2D)image.getGraphics();
//		//利用指定颜色填充背景
//		g2d.setColor(Color.WHITE);
//		g2d.fillRect(0, 0, width, height);
//		AlphaComposite ac3;
//		int h  = height - ((height - font.getSize()) >>1) ;
//		int w = width/len;
//		g2d.setFont(font);
//		for(int i=0;i<len;i++)
//		{
//			ac3 = AlphaComposite.getInstance(AlphaComposite.SRC_OVER, getAlpha(flag, i));
//			g2d.setComposite(ac3);
//			g2d.setColor(fontcolor[i]);
//			g2d.drawOval(GetRandom.getNum(width), GetRandom.getNum(height), 5+GetRandom.getNum(10), 5+GetRandom.getNum(10));
//			g2d.drawString(strs[i]+"", (width-(len-i)*w)+(w-font.getSize())+1, h-4);
//		}
//		g2d.dispose();
//		return image;
//	}
//
//	/**
//	 * 获取透明度,从0到1,自动计算步长
//	 * @return float 透明度
//	 */
}

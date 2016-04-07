package servlet.captcha.validation;

import java.awt.*;
import java.awt.geom.AffineTransform;
import java.util.Random;

public class GetRandom {
	private static final Random RANDOM=new Random();
	private static final char character[]={'A','B','C','D','E','F','G','H','G'
											,'K','M','N','P','Q','R','S','T'
											,'U','V','W','X','Y','Z','a','b'
											,'c','d','e','f','g','h','i','j'
											,'k','m','n','p','q','r','s','t'
											,'u','v','w','x','y','z','2','3'
											,'4','5','6','7','8','9'};
	private static final String[] fonts={"Monospaced","Serif","SansSerif","DialogInput","Dialog"};

	public static char getChar(){
		return character[RANDOM.nextInt(character.length)];
	}

	public static int getNum(int i){
		return RANDOM.nextInt(i);
	}

	public static double getDouble(){
		return RANDOM.nextDouble();
	}

	public static Color getColor(){
		//为了防止颜色看不见，选择RBG在20~130之间的数值作为颜色
		return new Color(getNum(110)+20,getNum(110)+20,getNum(110)+20);
	}

	public static Font getFont(){
		Font font=new Font(fonts[getNum(5)],Font.BOLD,27+getNum(6));
		font.deriveFont(getTransform());
		return font;

	}


	public static AffineTransform getTransform(){
		AffineTransform trans=new AffineTransform();
		//缩放
		trans.setToScale(0.0, 0.0);
		//旋转
		//@param 旋转向量的x，y坐标
		//trans.setToRotation(-5+getDouble()*10,-5+getDouble()*10);
		//@param 旋转的角度∈[-PI/2,PI/2]
		//trans.setToRotation((-Math.PI/2)+getDouble()*Math.PI);
		trans.rotate(90);
		//错切
		trans.setToShear(-5+getDouble()*10,-5+getDouble()*10);
		//平移
		trans.setToTranslation(-10+getDouble()*20,-10+getDouble()*20);
		return trans;
	}
}

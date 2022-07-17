package servlet.java;

import bean.java.Goods_Bean;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.RandomAccessFile;

@WebServlet("/uploadServlet")
//用户上传文件的内容在上传的表单文件中的第4行结束的位置和倒数第6行的结束位置
public class UploadServlet extends HttpServlet{
	public void init(ServletConfig config)throws ServletException{
		super.init(config);
	}
	public void service(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
		request.setCharacterEncoding("utf-8");
		Goods_Bean goodsBean=new Goods_Bean();							//获取一个商品的Session_Bean
		HttpSession session = request.getSession(true);
		goodsBean = (Goods_Bean)session.getAttribute("goodsBean");
		if(goodsBean==null){					//商品上传的信息Bean没建立，跳转到上传的页面
			response.sendRedirect("Upload.jsp");
			return;
		}
		String fileName=null;											//用来存取上传的图片的名字
		try{
			String tempFileName = (String)session.getId();				//使用商家的session对象id建立一个临时文件
			File dir=new File("E:/IntelliJ JDEA2020/无忧杂货/web/image");		//定位到该目录
			dir.mkdir();												//如果该目录没有，则新建该目录
			File fileTemp=new File(dir,tempFileName);					//在刚才的目录新建临时文件
			RandomAccessFile randomWrite=new RandomAccessFile(fileTemp,"rw");		//获得临时文件的读写权限，将上传的图片信息全部放进去
			InputStream in=request.getInputStream();					//获取一个输入流，读取用户上传的信息
			byte b[]=new byte[10000];									//建立一个字节数组，存取信息，数组大点好，因为不同编码的字符占字节不一样，避免读入字符的字节读一半
			int n;
			while((n=in.read(b))!=-1){   								//当读取的字符没有时，返回-1
				randomWrite.write(b,0,n);							//读取
			}
			randomWrite.close();
			in.close();
			//从刚才的临时文件中获取用户上传的内容
			RandomAccessFile randomRead=new RandomAccessFile(fileTemp,"r");
			int second=1;
			String secondLine=null;
			while(second<=2){											//定位到用户上传文件的名字位置的行
				secondLine=randomRead.readLine();
				second++;
			}
			int position=secondLine.lastIndexOf("=");				 //定位到filename的倒数的=位置，该=后面是文件的名字
			fileName=secondLine.substring(position+2,secondLine.length()-1);		//分离出用户文件的名字
			randomRead.seek(0);										//回到临时文件开头
			long forthEndPosition=0;									//定位到第4行回车符的位置
			int forth=1;
			while((n=randomRead.readByte())!=-1&&(forth<=4)){
				if(n=='\n'){
					forthEndPosition=randomRead.getFilePointer();
					forth++;
				}
			}
			byte cc[]=fileName.getBytes("iso-8859-1");		//改变字节编码，因为读取非AsCII字符的文件时会“乱码”现象
			fileName=new String(cc,"utf-8");					//将字节数组转变为utf8格式的字符串
			File fileUser=new File(dir,fileName);						//在刚才的目录新建一个文件名字用户上传的文件名，从来存储上传的内容，去除表单域
			randomWrite=new RandomAccessFile(fileUser,"rw");		//获得读取权限
			randomRead.seek(randomRead.length());						//定位到临时文件的最后字节
			long endPosition=randomRead.getFilePointer();				//存取倒数第6行的最后位置
			long mark=endPosition;
			int j=1;
			while((mark>=0)&&(j<=6)){									//获得倒数第6行的最后位置
				mark--;
				randomRead.seek(mark);
				n=randomRead.readByte();
				if(n=='\n'){
					endPosition=randomRead.getFilePointer();
					j++;
				}
			}
			randomRead.seek(forthEndPosition);							//将输入流指向第4行
			long startPoint=randomRead.getFilePointer();				//getFilePointer()定位到当前读写位置
			while(startPoint<endPosition-1){							//读取用户的内容，读取一行写一行
				n=randomRead.readByte();								//readByte()读取一个自动下一个
				randomWrite.write(n);
				startPoint=randomRead.getFilePointer();
			}
			//读取完成后关闭输入流
			randomWrite.close();
			randomRead.close();
			goodsBean.setGoodsPicture(fileName);		//给商品Bean的图片名赋值
			fileTemp.delete();							//删除临时文件
			goodsBean.setMess("图片上传成功");
		}
		catch(Exception ee){
			goodsBean.setMess("图片上传失败");
			response.getWriter().println(ee);
		}
		response.sendRedirect("Upload.jsp");
	}
}

				
			

package test.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;

// @WebFilter("/*") 이 프로젝트의 모든요청에 대해서 필터가 동작하도록 한다. 
// @WebFilter("/*")
public class EncodingFilter implements Filter{
	//필드 
	private String encoding;
	
	@Override
	public void destroy() {
		
	}
	//필터가 동작할때 마다 호출된다. 
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, 
			FilterChain chain)
			throws IOException, ServletException {
		//System.out.println("EncodingFilter doFilter()");	
		
		 //1. 만일 인코딩 설정되지 않았다면
		if(request.getCharacterEncoding()==null) {
			//post 방식 전송했을때 한글 깨지지 않도록 설정
			request.setCharacterEncoding(encoding);
		}
		//2. 요청의 흐름 계속 이어가기 
		chain.doFilter(request, response);
	}
	
	//필터가 최초 사용될때 1번만 호출된다. 
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		/*
		 * <init-param>
  				<param-name>encoding</param-name>
  				<param-value>utf-8</param-value>
  			</init-param>
  			
  			web.xml 에 위와 같이 설정된 초기화 파라미터 값을 읽어오기 
		 */
		
		// doFilter() 메소드에서 사용할수 있도록 필드에 저장한다. 
		encoding=filterConfig.getInitParameter("encoding"); // "utf-8"
	}

}






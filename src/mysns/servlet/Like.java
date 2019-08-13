package mysns.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mysns.sns.MessageDAO;
import net.sf.json.JSONObject;

/**
 * Servlet implementation class Like
 */
@WebServlet("/like")
public class Like extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	 MessageDAO messageDAO = new MessageDAO();
	 String uid =  request.getParameter("uid") ;
	 int mid = Integer.parseInt( (String) request.getParameter("mid") );
	 boolean result = messageDAO.isUserLikeMessage(uid, mid);
	 JSONObject obj = new JSONObject();
	  obj.put("check", result);
	  response.setContentType("application/x-json; charset=UTF-8");
	  response.getWriter().print(obj);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String uid = (String) request.getAttribute("uid") ;
		System.out.println(uid);
//		int mid = Integer.parseInt( (String) request.getAttribute("mid") );
//		 MessageDAO messageDAO = new MessageDAO();
//		 boolean result = messageDAO.isUserLikeMessage(uid, mid);
//		 JSONObject obj = new JSONObject();
//		  obj.put("check", result);
//		  response.setContentType("application/x-json; charset=UTF-8");
//		  response.getWriter().print(obj);

		
	}

}

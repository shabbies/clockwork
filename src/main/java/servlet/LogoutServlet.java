package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import javax.servlet.http.HttpSession;
import org.apache.http.client.methods.HttpDelete;

public class LogoutServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        CloseableHttpClient httpClient = HttpClients.createDefault();
        HttpDelete httpDelete = new HttpDelete("https://clockwork-api.herokuapp.com/users/sign_out.json");
        httpDelete.setHeader("Accept", "application/json");
        CloseableHttpResponse response2 = httpClient.execute(httpDelete);

        try {
            HttpEntity entity = response2.getEntity();
            EntityUtils.consume(entity);
        } finally {
            response2.close();
        }
        String message = "You have successfully logged out.";
        session.setAttribute("message", message);
        session.removeAttribute("currentUser");
        session.removeAttribute("appController");
        response.sendRedirect("/index.jsp");
    }

}

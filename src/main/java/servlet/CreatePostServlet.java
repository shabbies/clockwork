package servlet;

import java.io.IOException;
import java.io.InputStream;
import java.io.StringWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpSession;
import model.User;
import org.apache.commons.io.IOUtils;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.message.BasicNameValuePair;

public class CreatePostServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User currentUser = (User)session.getAttribute("currentUser");
        if (currentUser == null){
            session.setAttribute("error", "Please login or register first before posting a job");
            session.setAttribute("loginSource", "create_new_post");
            response.sendRedirect("/login.jsp");
            return;
        } else if (!currentUser.getAccountType().equals("employer")){
            session.setAttribute("error", "Only an employer account is able to post a job!");
            response.sendRedirect("/index.jsp");
            return;
        }
        String header = (String)request.getParameter("header");
        double salary = Double.parseDouble(request.getParameter("salary"));
        String description = (String)request.getParameter("description");
        String location = (String)request.getParameter("location");
        String jobDateString = (String)request.getParameter("job_date");
        String endDateString = (String)request.getParameter("job_end");
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        String startTime = request.getParameter("start_time");
        String endTime = request.getParameter("end_time");
        Date jobDate = null;
        Date endDate = null;
        try {
            jobDate = df.parse(jobDateString);
            endDate = df.parse(endDateString);
        } catch (ParseException ex){
            ex.printStackTrace();
        }
        String email = currentUser.getEmail();
        String token = currentUser.getAuthenticationToken();
        
        CloseableHttpClient httpclient = HttpClients.createDefault();
        HttpPost httpPost = new HttpPost("https://clockwork-api.herokuapp.com/api/v1/posts/new");
        httpPost.setHeader("Authentication-Token", token);
        List <NameValuePair> nvps = new ArrayList <NameValuePair>();
        nvps.add(new BasicNameValuePair("header", header));
        nvps.add(new BasicNameValuePair("salary", "" + salary));
        nvps.add(new BasicNameValuePair("description", description));
        nvps.add(new BasicNameValuePair("location", location));
        nvps.add(new BasicNameValuePair("job_date",jobDate.toString()));
        nvps.add(new BasicNameValuePair("end_date",endDate.toString()));
        nvps.add(new BasicNameValuePair("email", email));
        nvps.add(new BasicNameValuePair("start_time", startTime));
        nvps.add(new BasicNameValuePair("end_time", endTime));

        httpPost.setEntity(new UrlEncodedFormEntity(nvps));
        CloseableHttpResponse httpResponse = httpclient.execute(httpPost);
        HttpEntity entity = httpResponse.getEntity();
        try {
            int statusCode = httpResponse.getStatusLine().getStatusCode();
            StringWriter writer = new StringWriter();
            InputStream readingStream = entity.getContent();
            IOUtils.copy(readingStream, writer, "UTF-8");
            String responseString = writer.toString();
            if(statusCode == 401){
                String error = "A system error has occurred, please try again";
                session.setAttribute("error", error);
                response.sendRedirect("/index.jsp");
                return;
            } else if (statusCode == 400){
                String error = null;
                String[] repopulate = null;
                if (responseString.contains("salary")){
                    error = "Salary should not be negative!";
                    repopulate = new String[] {header, location, description, jobDateString, endDateString, startTime, endTime, ""};
                } else if (responseString.contains("job")){
                    error = "The job date should be after today!";
                    repopulate = new String[] {header, location, description, "", "", startTime, endTime, "" + salary};
                } else if (responseString.contains("end date")){
                    error = "The end date should be after start date!";
                    repopulate = new String[] {header, location, description, "", "", startTime, endTime, "" + salary};
                } else {
                    error = "The end time should be after the start time!";
                    repopulate = new String[] {header, location, description, jobDateString, endDateString, "", "", "" + salary};
                }
                session.setAttribute("error", error);
                session.setAttribute("repopulate", repopulate);
                response.sendRedirect("/create_post.jsp");
                return;
            } else {
                String message = "Post has been successfully listed!";
                session.setAttribute("message", message);
                response.sendRedirect("/dashboard.jsp");
            }
        } finally {
            EntityUtils.consume(entity);
            httpResponse.close();
        }
        
    }

}

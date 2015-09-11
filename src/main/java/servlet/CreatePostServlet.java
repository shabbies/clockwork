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
import java.util.Calendar;
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
        System.out.println(jobDateString);
        System.out.println(endDateString);

        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        String startTime = request.getParameter("start_time");
        String endTime = request.getParameter("end_time");
        Date jobDate = null;
        Date endDate = null;
        Date today = new Date();
        try {
            jobDate = df.parse(jobDateString);
            endDate = df.parse(endDateString);
        } catch (ParseException ex){
            session.setAttribute("error", "System error, please inform the administrator");
            response.sendRedirect("/index.jsp");
            return;
        }
        
        Calendar calendar = Calendar.getInstance(); 
        calendar.setTime(today); 
        calendar.add(Calendar.DATE, 2);
        today = calendar.getTime();
        
        //validating date
        if (endDate.before(jobDate)){
            session.setAttribute("error", "The end date should be after the start date");
            response.sendRedirect("/create_post.jsp");
            return;
        } else if (jobDate.before(today)){
            session.setAttribute("error", "The job date should be at least 2 days from today.");
            response.sendRedirect("/create_post.jsp");
            return;
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
            String error = null;
            switch (statusCode){
                case 401:
                    error = "A system error has occurred, please try again";
                    session.setAttribute("error", error);
                    response.sendRedirect("/index.jsp");
                    return;
                case 400:
                    String[] repopulate = null;
                    switch (responseString){
                        case "Bad Request - The job date should be after today":
                            error = "The job date should be after today!";
                            repopulate = new String[] {header, location, description, "", "", startTime, endTime, "" + salary};
                            break;
                        case "Bad Request - The end date should be after the start date":
                            error = "The end date should be after start date!";
                            repopulate = new String[] {header, location, description, "", "", startTime, endTime, "" + salary};
                            break;
                        case "Bad Request - The salary should not be negative":
                            error = "Salary should not be negative!";
                            repopulate = new String[] {header, location, description, jobDateString, 
                                endDateString, startTime, endTime, ""};
                            break;
                        case "Bad Request - End time should be after start time":
                            error = "The end date should be after start date!";
                            repopulate = new String[] {header, location, description, "", "", startTime, endTime, "" + salary};
                            break;
                        case "Bad Request - Post has already been created":
                            error = "This post has already been created!";
                            session.setAttribute("error", error);
                            response.sendRedirect("/dashboard.jsp");
                            return;
                    }
                    session.setAttribute("error", error);
                    session.setAttribute("repopulate", repopulate);
                    response.sendRedirect("/create_post.jsp");
                    return;
                case 403:
                    error = "Only employers are allowed to post a job!";
                    session.setAttribute("error", error);
                    response.sendRedirect("/index.jsp");
                    return;
                case 201:
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

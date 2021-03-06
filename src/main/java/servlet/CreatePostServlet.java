package servlet;

import controller.AppController;
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
import java.util.Calendar;
import java.util.Date;
import java.util.concurrent.TimeUnit;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import model.APIManager;
import model.User;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringEscapeUtils;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.mime.HttpMultipartMode;
import org.apache.http.entity.mime.MultipartEntityBuilder;

@MultipartConfig
public class CreatePostServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        AppController appController = (AppController)session.getAttribute("appController");
        APIManager apiManager = appController.getAPIManager();
        String URL = apiManager.getEPNewPost();
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
        String startDateString = jobDateString.substring(0, jobDateString.indexOf("-") - 1);
        String endDateString = jobDateString.substring(jobDateString.indexOf("-") + 2);
        String payType = "hour"; // on or null
        if (request.getParameter("pay-type") == null){
            payType = "day";
        }
        
        SimpleDateFormat df = new SimpleDateFormat("MMMMM d, yyyy");
        String startTime = request.getParameter("start_time");
        String endTime = request.getParameter("end_time");
        Date jobDate = null;
        Date endDate = null;
        Date today = new Date();
        try {
            jobDate = df.parse(startDateString);
            endDate = df.parse(endDateString);
        } catch (ParseException ex){
            session.setAttribute("error", "System error, please inform the administrator");
            response.sendRedirect("/index.jsp");
            return;
        }
        
        Calendar calendar = Calendar.getInstance(); 
        calendar.setTime(today); 
        calendar.add(Calendar.DATE, 2);
        calendar.set(Calendar.HOUR_OF_DAY, 0);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);
        calendar.set(Calendar.MILLISECOND, 0);
        today = calendar.getTime();

        //validating date
        if (endDate.before(jobDate)){
            session.setAttribute("error", "The end date should be after the start date");
            response.sendRedirect("/create_post.jsp");
            return;
        } else if (!jobDate.equals(today) && jobDate.before(today)){
            session.setAttribute("error", "The job date should be at least 2 days from today.");
            response.sendRedirect("/create_post.jsp");
            return;
        } 
        long msDifference = endDate.getTime() - jobDate.getTime();
        long dayDifference = TimeUnit.DAYS.convert(msDifference, TimeUnit.MILLISECONDS);
        if (dayDifference > 6){ // 7 includes the first day
            session.setAttribute("error", "The maxmimum job duration should be 7 days!");
            response.sendRedirect("/create_post.jsp");
            return;
        }
        
        String email = currentUser.getEmail();
        String token = currentUser.getAuthenticationToken();
        
        Part imagePart = request.getPart("image");
        byte[] imageByte = null;
        if (imagePart != null){
            imageByte = IOUtils.toByteArray(imagePart.getInputStream());
        }
        
        CloseableHttpClient httpclient = HttpClients.createDefault();
        HttpPost httpPost = new HttpPost(URL);
        httpPost.setHeader("Authentication-Token", token);
        
        MultipartEntityBuilder builder = MultipartEntityBuilder.create();
        builder.setMode(HttpMultipartMode.BROWSER_COMPATIBLE);
        if (imageByte != null && imageByte.length != 0){
            builder.addBinaryBody("image", imageByte, ContentType.create(imagePart.getContentType()), imagePart.getName());
        }
        builder.addTextBody("header", StringEscapeUtils.escapeHtml(header), ContentType.TEXT_PLAIN);
        builder.addTextBody("salary", "" + salary, ContentType.TEXT_PLAIN);
        builder.addTextBody("description", StringEscapeUtils.escapeHtml(description), ContentType.TEXT_PLAIN);
        builder.addTextBody("location", StringEscapeUtils.escapeHtml(location), ContentType.TEXT_PLAIN);
        builder.addTextBody("job_date", jobDate.toString(), ContentType.TEXT_PLAIN);
        builder.addTextBody("end_date", endDate.toString(), ContentType.TEXT_PLAIN);
        builder.addTextBody("email", email, ContentType.TEXT_PLAIN);
        builder.addTextBody("start_time", startTime, ContentType.TEXT_PLAIN);
        builder.addTextBody("end_time", endTime, ContentType.TEXT_PLAIN);
        builder.addTextBody("pay_type", payType, ContentType.TEXT_PLAIN);
        
        HttpEntity entity = builder.build();
        httpPost.setEntity(entity);
        
        CloseableHttpResponse httpResponse = httpclient.execute(httpPost);
        entity = httpResponse.getEntity();
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
                            repopulate = new String[] {header, location, description, "", startTime, endTime, "" + salary};
                            break;
                        case "Bad Request - The end date should be after the start date":
                            error = "The end date should be after start date!";
                            repopulate = new String[] {header, location, description, "", startTime, endTime, "" + salary};
                            break;
                        case "Bad Request - The salary should not be negative":
                            error = "Salary should not be negative!";
                            repopulate = new String[] {header, location, description, jobDateString, startTime, endTime, ""};
                            break;
                        case "Bad Request - End time should be after start time":
                            error = "The end date should be after start date!";
                            repopulate = new String[] {header, location, description, "", startTime, endTime, "" + salary};
                            break;
                        case "Bad Request - Post has already been created":
                            error = "This post has already been created!";
                            session.setAttribute("error", error);
                            response.sendRedirect("/dashboard.jsp");
                            return;
                        case "Bad Request - The maximum job duration should be 7 days":
                            error = "The maximum duration of the job is 7 days!";
                            session.setAttribute("error", error);
                            repopulate = new String[] {header, location, description, "", startTime, endTime, "" + salary};
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

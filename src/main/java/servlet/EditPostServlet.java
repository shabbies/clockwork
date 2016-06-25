package servlet;

import controller.AppController;
import controller.PostController;
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
import java.util.concurrent.TimeUnit;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import model.APIManager;
import model.Post;
import model.User;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringEscapeUtils;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.mime.HttpMultipartMode;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.message.BasicNameValuePair;

@MultipartConfig
public class EditPostServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // preparing variables
        HttpSession session = request.getSession();
        AppController appController = (AppController)session.getAttribute("appController");
        APIManager apiManager = appController.getAPIManager();
        String URL = apiManager.getEPEditPost();
        
        User currentUser = (User)session.getAttribute("currentUser");
        int postID = Integer.parseInt(request.getParameter("post_id"));
        String header = (String)request.getParameter("header");
        double salary = Double.parseDouble(request.getParameter("salary"));
        String description = (String)request.getParameter("description");
        String location = (String)request.getParameter("location");
        String jobDateString = (String)request.getParameter("job_date");
        String startDateString = jobDateString.substring(0, jobDateString.indexOf("-") - 1);
        String endDateString = jobDateString.substring(jobDateString.indexOf("-") + 2);
//        String endDateString = request.getParameter("end_date");
        String jobStartTime = request.getParameter("start_time");
        String jobEndTime = request.getParameter("end_time");
        String payType = "hour"; // on or null
        if (request.getParameter("pay-type") == null){
            payType = "day";
        }
//        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat df = new SimpleDateFormat("MMMMM d, yyyy");
        SimpleDateFormat tf = new SimpleDateFormat("HH:mm");
        Date startTime = null;
        Date endTime = null;
        Date jobDate = null;
        Date endDate = null;
        Date today = new Date();
        try {
            jobDate = df.parse(startDateString);
            endDate = df.parse(endDateString);
            startTime = tf.parse(jobStartTime);
            endTime = tf.parse(jobEndTime);
        } catch (ParseException ex){
            String error = "A system error has occured with the time, please inform the administrator";
            session.setAttribute("error", error);
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
            response.sendRedirect("/edit_post.jsp?id=" + postID);
            return;
        } else if (jobDate.before(today) && jobDate.equals(today)){
            session.setAttribute("error", "The job date should be at least 2 days from today.");
            response.sendRedirect("/edit_post.jsp?id=" + postID);
            return;
        }
        
        String email = currentUser.getEmail();
        String token = currentUser.getAuthenticationToken();
        long difference = endDate.getTime() - jobDate.getTime();
        int duration = (int)TimeUnit.DAYS.convert(difference, TimeUnit.MILLISECONDS);
        
        if (duration > 6){ // 7 is inclusive of first day
            session.setAttribute("error", "The maxmimum job duration should be 7 days!");
            response.sendRedirect("/edit_post.jsp?id=" + postID);
            return;
        }
        
        if (endTime.before(startTime) || endTime.equals(startTime)){
            session.setAttribute("error", "The end time should be after the start time!");
            response.sendRedirect("/edit_post.jsp?id=" + postID);
            return;
        }
        
        // retrieving image part
        Part imagePart = request.getPart("image");
        byte[] imageByte = null;
        if (imagePart != null){
            imageByte = IOUtils.toByteArray(imagePart.getInputStream());
        }
        
        // retrieve post object
        PostController postController = appController.getPostController();
        Post post = postController.getPost(postID);
        
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
        builder.addTextBody("job_date", jobDateString, ContentType.TEXT_PLAIN);
        builder.addTextBody("end_date", endDateString, ContentType.TEXT_PLAIN);
        builder.addTextBody("email", email, ContentType.TEXT_PLAIN);
        builder.addTextBody("post_id", String.valueOf(postID), ContentType.TEXT_PLAIN);
        builder.addTextBody("start_time", jobStartTime, ContentType.TEXT_PLAIN);
        builder.addTextBody("end_time", jobEndTime, ContentType.TEXT_PLAIN);
        builder.addTextBody("pay_type", payType, ContentType.TEXT_PLAIN);
        
        HttpEntity entity = builder.build();
        httpPost.setEntity(entity);
        
        CloseableHttpResponse httpResponse = httpclient.execute(httpPost);
        try {
            entity = httpResponse.getEntity();
            int statusCode = httpResponse.getStatusLine().getStatusCode();
            StringWriter writer = new StringWriter();
            InputStream readingStream = entity.getContent();
            IOUtils.copy(readingStream, writer, "UTF-8");
            String responseString = writer.toString();
            String error = null;
            switch (statusCode){
                case 200:
                    post.setDescription(description);
                    post.setHeader(header);
                    post.setJobDate(jobDate);
                    post.setEndDate(endDate);
                    post.setLocation(location);
                    post.setSalary(salary);
                    post.setDuration(duration);
                    post.setStartTime(jobStartTime);
                    post.setEndTime(jobEndTime);
                    post.setPayType(payType);
                    String message = "Post <strong>(" + post.getHeader() + ")</strong> has been successfully updated!";
                    session.setAttribute("message", message);
                    response.sendRedirect("/dashboard.jsp");
                    return;
                case 403:
                    error = "Only the owner of the post is allowed to edit it!";
                    session.setAttribute("error", error);
                    response.sendRedirect("/index.jsp");
                    return;
                case 400:
                    switch (responseString){
                        case "Bad Request - The post cannot be found":
                            error = "The post cannot be found!";
                            break;
                        case "Bad Request - The job date should be after today":
                            error = "The job date should be after today!";
                            session.setAttribute("error", error);
                            response.sendRedirect("/edit_post.jsp?id=" + postID);
                            return;
                        case "Bad Request - The end date should be after the start date":
                            error = "The job end date should be after the start date!";
                            session.setAttribute("error", error);
                            response.sendRedirect("/edit_post.jsp?id=" + postID);
                            return;
                        case "Bad Request - The salary should not be negative":
                            error = "The salary should not be negative!";
                            session.setAttribute("error", error);
                            response.sendRedirect("/edit_post.jsp?id=" + postID);
                            return;
                        case "Bad Request - End time should be after start time":
                            error = "The job end time should be after the start time!";
                            session.setAttribute("error", error);
                            response.sendRedirect("/edit_post.jsp?id=" + postID);
                            return;
                        case "Bad Request - Unable to edit post once there are applicants":
                            error = "There are already applicants for this job posting!";
                            break;
                        case "Bad Request - The maximum job duration should be 7 days":
                            error = "The maximum duration of the job is 7 days!";
                            session.setAttribute("error", error);
                            response.sendRedirect("/edit_post.jsp?id=" + postID);
                            return;
                    }
                    session.setAttribute("error", error);
                    response.sendRedirect("/dashboard.jsp");
                    return;
                case 401:
                    error = "Invalid authorisation token!";
                    session.setAttribute("error", error);
                    response.sendRedirect("/index.jsp");
                    return;
            } 
        } finally {
            httpResponse.close();
            EntityUtils.consume(entity);
        }
    }
}
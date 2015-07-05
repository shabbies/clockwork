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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.message.BasicNameValuePair;

public class CreatePostServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String header = (String)request.getParameter("header");
        String company = (String)request.getParameter("company");
        int salary = Integer.parseInt(request.getParameter("salary"));
        String description = (String)request.getParameter("description");
        String location = (String)request.getParameter("location");
        String jobDateString = (String)request.getParameter("job_date");
        SimpleDateFormat df = new SimpleDateFormat("dd-MM-yyyy");
        Date jobDate = null;
        try {
            jobDate = df.parse(jobDateString);
        } catch (ParseException ex){
            ex.printStackTrace();
        }
        
        CloseableHttpClient httpclient = HttpClients.createDefault();
        HttpPost httpPost = new HttpPost("https://clockwork-api.herokuapp.com/api/v1/posts/new");
        List <NameValuePair> nvps = new ArrayList <NameValuePair>();
        nvps.add(new BasicNameValuePair("header", header));
        nvps.add(new BasicNameValuePair("company", company));
        nvps.add(new BasicNameValuePair("salary", "" + salary));
        nvps.add(new BasicNameValuePair("description", description));
        nvps.add(new BasicNameValuePair("location", location));
        nvps.add(new BasicNameValuePair("job_date",jobDate.toString()));

        httpPost.setEntity(new UrlEncodedFormEntity(nvps));
        CloseableHttpResponse response2 = httpclient.execute(httpPost);

        try {
            // System.out.println(response2.getStatusLine());
            HttpEntity entity2 = response2.getEntity();
            // do something useful with the response body
            // and ensure it is fully consumed
            EntityUtils.consume(entity2);
        } finally {
            response2.close();
        }
        
        response.sendRedirect("/GetAllPostsServlet");
    }

}

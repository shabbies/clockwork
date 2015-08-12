package model;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

public class Post {
    
    private int id;
    private String header;
    private String company;
    private int salary;
    private String description;
    private String location;
    private Date postingDate;
    private Date jobDate;
    private String status;
    private ArrayList <User> applicants;

    public Post(int id, String header, String company, int salary, String description, String location, Date postingDate, Date jobDate, String status) {
        this.id = id;
        this.header = header;
        this.company = company;
        this.salary = salary;
        this.description = description;
        this.location = location;
        this.postingDate = postingDate;
        this.jobDate = jobDate;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getHeader() {
        return header;
    }

    public void setHeader(String header) {
        this.header = header;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public int getSalary() {
        return salary;
    }

    public void setSalary(int salary) {
        this.salary = salary;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public Date getPostingDate() {
        return postingDate;
    }

    public void setPostingDate(Date postingDate) {
        this.postingDate = postingDate;
    }

    public Date getJobDate() {
        return jobDate;
    }

    public void setJobDate(Date jobDate) {
        this.jobDate = jobDate;
    }
    
    public String getStatus(){
        return status;
    }
    
    public void setStatus(String status){
        this.status = status;
    }
    
    public String getJobDateString(){
        DateFormat df = new SimpleDateFormat("dd-MM-yyyy");
        return df.format(jobDate);
    }
    
    public String getJobDateStringForInput(){
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        return df.format(jobDate);
    }
}

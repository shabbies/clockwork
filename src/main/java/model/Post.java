package model;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Comparator;
import java.util.Date;

public class Post {
    
    private int id;
    private String header;
    private String company;
    private double salary;
    private String description;
    private String location;
    private Date postingDate;
    private Date jobDate;
    private Date endDate;
    private String status;
    private int applicantCount;
    private Date expiryDate;
    private String startTime;
    private String endTime;
    private int duration;
    private int rating;
    private String comment;
    private String avatarPath;

    public Post(int id, String header, String company, double salary, String description, String location, Date postingDate, Date jobDate, Date endDate, String status, int applicantCount, Date expiryDate, String startTime, String endTime, int duration, String avatarPath) {
        this.id = id;
        this.header = header;
        this.company = company;
        this.salary = salary;
        this.description = description;
        this.location = location;
        this.postingDate = postingDate;
        this.jobDate = jobDate;
        this.endDate = endDate;
        this.status = status;
        this.applicantCount = applicantCount;
        this.expiryDate = expiryDate;
        this.startTime = startTime;
        this.endTime = endTime;
        this.duration = duration;
        this.avatarPath = avatarPath;
    }
    
    public Post(int id, String header, String company, double salary, String description, String location, Date postingDate, Date jobDate, Date endDate, String status, int applicantCount, Date expiryDate, String startTime, String endTime, int duration, int rating, String comment, String avatarPath) {
        this.id = id;
        this.header = header;
        this.company = company;
        this.salary = salary;
        this.description = description;
        this.location = location;
        this.postingDate = postingDate;
        this.jobDate = jobDate;
        this.endDate = endDate;
        this.status = status;
        this.applicantCount = applicantCount;
        this.expiryDate = expiryDate;
        this.startTime = startTime;
        this.endTime = endTime;
        this.duration = duration;
        this.rating = rating;
        this.comment = comment;
        this.avatarPath = avatarPath;
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

    public double getSalary() {
        return salary;
    }

    public void setSalary(double salary) {
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

    public int getApplicantCount() {
        return applicantCount;
    }

    public void setApplicantCount(int applicantCount) {
        this.applicantCount = applicantCount;
    }

    public Date getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(Date expiryDate) {
        this.expiryDate = expiryDate;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public String getAvatarPath() {
        return avatarPath;
    }

    public void setAvatarPath(String avatarPath) {
        this.avatarPath = avatarPath;
    }
    
    public String getJobDateString(){
        DateFormat df = new SimpleDateFormat("dd-MM-yyyy");
        return df.format(jobDate);
    }
    
    public String getEndDateString(){
        DateFormat df = new SimpleDateFormat("dd-MM-yyyy");
        return df.format(endDate);
    }
    
    public String getJobDateStringForInput(){
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        return df.format(jobDate);
    }
    
    public String getJobEndDateStringForInput(){
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        return df.format(endDate);
    }
    
    public String getPostExpiryStringForInput(){
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        return df.format(expiryDate);
    }
    
    public static Comparator<Post> SalaryComparator = new Comparator<Post>() {
        @Override
        public int compare(Post p1, Post p2) {
           double salary1 = p1.salary;
           double salary2 = p2.salary;

           if (salary1 > salary2){
               return -1;
           } else if (salary1 < salary2){
               return 1;
           } else {
               return 0;
           }
        }
    };
    
    public static Comparator<Post> OldestComparator = new Comparator<Post>() {
        @Override
        public int compare(Post p1, Post p2) {
           Date startDate1 = p1.jobDate;
           Date startDate2 = p2.jobDate;

           if (startDate1.before(startDate2)){
               return -1;
           } else if (startDate2.before(startDate1)){
               return 1;
           } else {
               return 0;
           }
        }
    };
    
    public static Comparator<Post> LatestComparator = new Comparator<Post>() {
        @Override
        public int compare(Post p1, Post p2) {
           Date postingDate1 = p1.postingDate;
           Date postingDate2 = p2.postingDate;

           if (postingDate1.before(postingDate2)){
               return -1;
           } else if (postingDate2.before(postingDate1)){
               return 1;
           } else {
               return 0;
           }
        }
    };
}

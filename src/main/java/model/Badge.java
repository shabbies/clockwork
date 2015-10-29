package model;

import java.util.Objects;

public class Badge {
    private String name;
    private String criteria;
    private String imageLink;
    private String status;

    public Badge(String name, String criteria, String imageLink, String status) {
        this.name = name;
        this.criteria = criteria;
        this.imageLink = imageLink;
        this.status = status;
    }

    public String getImageLink() {
        return imageLink;
    }

    public void setImageLink(String imageLink) {
        this.imageLink = imageLink;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getName() {
        return name;
    }

    public String getCriteria() {
        return criteria;
    }
    
    @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final Badge other = (Badge) obj;
        if (this.name != other.name) {
            return false;
        }
        return true;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 31 * hash + Objects.hashCode(this.name);
        return hash;
    }
}

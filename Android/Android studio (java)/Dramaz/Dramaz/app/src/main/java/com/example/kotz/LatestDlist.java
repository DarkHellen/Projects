package com.example.kotz;

public class LatestDlist {
    String name,lurl,url;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLurl() {
        return lurl;
    }

    public void setLurl(String lurl) {
        this.lurl = lurl;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public LatestDlist(String name, String lurl, String url) {
        this.name = name;
        this.lurl = lurl;
        this.url = url;
    }
    public LatestDlist(){

    }
}

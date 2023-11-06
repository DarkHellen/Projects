package com.example.dramazadmin;

public class UploadModel {
    String lurl,name,url;

    public String getLurl() {
        return lurl;
    }

    public void setLurl(String lurl) {
        this.lurl = lurl;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public UploadModel(String lurl, String name, String url) {
        this.lurl = lurl;
        this.name = name;
        this.url = url;
    }

    public UploadModel() {
    }
}

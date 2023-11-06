package com.example.kotz;

import java.util.List;

public class Comic_item_model {
    String iurl,name;
    List<String> Episodes;

    public String getIurl() {
        return iurl;
    }

    public void setIurl(String iurl) {
        this.iurl = iurl;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<String> getEpisodes() {
        return Episodes;
    }

    public void setEpisodes(List<String> episodes) {
        this.Episodes = episodes;
    }

    public Comic_item_model(String iurl, String name, List<String> episodes) {
        this.iurl = iurl;
        this.name = name;
        this.Episodes = episodes;
    }

    Comic_item_model(){}
}

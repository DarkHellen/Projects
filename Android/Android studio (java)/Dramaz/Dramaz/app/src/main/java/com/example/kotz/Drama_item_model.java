package com.example.kotz;

import java.util.List;

public class Drama_item_model {
   String iurl,name;
   List<String> episodes;



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
        return episodes;
    }

    public void setEpisodes(List<String> episodes) {
        this.episodes = episodes;
    }

    public Drama_item_model(String iurl, String name, List<String> episodes) {
        this.iurl = iurl;
        this.name = name;
        this.episodes = episodes;
    }

    public Drama_item_model(){

   }


}

package com.example.kotz;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

import com.bumptech.glide.Glide;

import java.util.ArrayList;

public class Comicspage extends AppCompatActivity {
    public Context context;
    TextView name,desc;
    ImageView image;
    ListView l1;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.home_page_acticity);
        getSupportActionBar().hide();
        //creating array for episodes
        ArrayList<String> episodes = new ArrayList<>();
        ArrayList<String> link =  getIntent().getStringArrayListExtra("videolink");
        int n= link.size();
        for(int i=0;i<n;i++){
            episodes.add("EPISODE "+String.valueOf(i+1));

        }
        String sname,simage,sdesc;
        sname=getIntent().getStringExtra("name");
        simage=getIntent().getStringExtra("imagelink");
        Uri uri=Uri.parse(simage);

        name=findViewById(R.id.Dname);
        image=findViewById(R.id.Dimage);
        Glide.with(image.getContext())
                .load(simage)
                .into(image);
        name.setText(sname);
        l1 = findViewById(R.id.list);

        ArrayAdapter<String> arr;
        arr
                = new ArrayAdapter<String>(
                this,
                R.layout.listview_item_color,R.id.list_content,
                episodes);
        l1.setAdapter(arr);

        l1.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                String url=link.get(position).toString();
                Intent intent=new Intent(Comicspage.this,Comics_read.class);
                intent.putExtra("link",url);
                startActivity(intent);

            }
        });



    }
}

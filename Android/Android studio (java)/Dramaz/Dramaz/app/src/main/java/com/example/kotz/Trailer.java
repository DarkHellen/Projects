package com.example.kotz;

import androidx.appcompat.app.AppCompatActivity;
import androidx.viewpager2.widget.ViewPager2;

import android.media.MediaPlayer;
import android.net.Uri;
import android.os.Bundle;
import android.widget.ImageView;
import android.widget.MediaController;
import android.widget.TextView;
import android.widget.Toast;
import android.widget.VideoView;

import com.firebase.ui.database.FirebaseRecyclerOptions;
import com.google.firebase.database.FirebaseDatabase;

public class Trailer extends AppCompatActivity {
    MediaController mc;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        try {
            super.onCreate(savedInstanceState);
            setContentView(R.layout.activity_trailer);
            getSupportActionBar().hide();
            String link = getIntent().getStringExtra("videolink");
            //ViewPager2 v1 = findViewById(R.id.vp2);
            VideoView vv=findViewById(R.id.videoView3);
            Uri uri=Uri.parse(link);
            vv.setVideoPath(String.valueOf(uri));
            mc=new MediaController(this);
            vv.setMediaController(mc);
            mc.setAnchorView(vv);

            vv.setOnPreparedListener(new MediaPlayer.OnPreparedListener() {
                @Override
                public void onPrepared(MediaPlayer mp) {
                    Toast.makeText(vv.getContext(),  "hi", Toast.LENGTH_SHORT).show();

                    mp.start();
                }
            });



        } catch(Exception ignored) {

        }
    }

}
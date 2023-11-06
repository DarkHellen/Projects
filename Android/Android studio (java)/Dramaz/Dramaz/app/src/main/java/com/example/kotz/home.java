package com.example.kotz;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.os.Bundle;

import com.firebase.ui.database.FirebaseRecyclerOptions;
import com.google.firebase.database.FirebaseDatabase;
import com.smarteist.autoimageslider.IndicatorView.animation.type.IndicatorAnimationType;
import com.smarteist.autoimageslider.SliderAnimations;
import com.smarteist.autoimageslider.SliderView;

public class home extends AppCompatActivity {
    Drama_list dl;
    DramaItemAdapter dia;
    Comic_Item_Adapter Cia;
    RecyclerView status,Drama,Comics;
    SliderView sliderView;
    int[] ids={R.drawable.five,
            R.drawable.eight,
            R.drawable.four,
            R.drawable.nine,
            R.drawable.seven,
            R.drawable.six};
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_home);
        getSupportActionBar().hide();

        //slider code starts here
        sliderView=findViewById(R.id.imageSlider);
        SliderAdapter sliderAdapter=new SliderAdapter(ids);
        sliderView.setSliderAdapter(sliderAdapter);
        sliderView.setIndicatorAnimation(IndicatorAnimationType.WORM);
        sliderView.setSliderTransformAnimation(SliderAnimations.DEPTHTRANSFORMATION);
        sliderView.startAutoCycle();
        //slider code ends here


        //trailer code starts here
        status=(RecyclerView) findViewById(R.id.LatestDrama);
        status.setLayoutManager(new LinearLayoutManager(this,LinearLayoutManager.HORIZONTAL,false));
        FirebaseRecyclerOptions<LatestDlist> options =
                new FirebaseRecyclerOptions.Builder<LatestDlist>()
                        .setQuery(FirebaseDatabase.getInstance().getReference().child("LatestDrama"), LatestDlist.class)
                        .build();

        dl=new Drama_list(options,getApplicationContext());
        status.setAdapter(dl);
        //trailer code ends here

        //Drama code start here
        Drama=findViewById(R.id.Drama);
        Drama.setLayoutManager(new LinearLayoutManager(this,LinearLayoutManager.HORIZONTAL,false));
        FirebaseRecyclerOptions<Drama_item_model> options1 =
                new FirebaseRecyclerOptions.Builder<Drama_item_model>()
                        .setQuery(FirebaseDatabase.getInstance().getReference().child("Dramas"), Drama_item_model.class)
                        .build();
        dia=new DramaItemAdapter(options1,getApplicationContext());
        Drama.setAdapter(dia);
        //Drama code ends here

        //Comics code starts here
        Comics=findViewById(R.id.Comics);
        Comics.setLayoutManager(new LinearLayoutManager(this,LinearLayoutManager.HORIZONTAL,false));
        FirebaseRecyclerOptions<Comic_item_model> options2 =
                new FirebaseRecyclerOptions.Builder<Comic_item_model>()
                        .setQuery(FirebaseDatabase.getInstance().getReference().child("Comics"),Comic_item_model.class)
                        .build();
        Cia=new Comic_Item_Adapter(options2,getApplicationContext());
        Comics.setAdapter(Cia);
        //comics code ends here
    }



    @Override
    protected void onStart() {
        super.onStart();
        dl.startListening();
        dia.startListening();
        Cia.startListening();
    }
    @Override
    protected void onStop() {
        super.onStop();
        dl.stopListening();
        dia.stopListening();
        Cia.stopListening();
    }
}
package com.example.dramazadmin;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.Switch;

import com.firebase.ui.database.FirebaseRecyclerOptions;
import com.google.firebase.database.FirebaseDatabase;

public class AdminHome extends AppCompatActivity {
    Button add;
    Drama_list dl;
    RecyclerView status;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_admin_home);

        status=(RecyclerView) findViewById(R.id.LatestDrama);
        status.setLayoutManager(new LinearLayoutManager(this,LinearLayoutManager.VERTICAL,false));
        FirebaseRecyclerOptions<LatestDlist> options =
                new FirebaseRecyclerOptions.Builder<LatestDlist>()
                        .setQuery(FirebaseDatabase.getInstance().getReference().child("LatestDrama"), LatestDlist.class)
                        .build();

        dl=new Drama_list(options);
        status.setAdapter(dl);

    }



    @Override
    protected void onStart() {
        super.onStart();
        dl.startListening();
    }
    @Override
    protected void onStop() {
        super.onStop();
        dl.stopListening();
    }

    @Override
    public boolean onOptionsItemSelected(@NonNull MenuItem item) {
        switch (item.getItemId()){

            case R.id.Atrailer:
                startActivity(new Intent(AdminHome.this,Upload.class));

            default:
                return super.onOptionsItemSelected(item);
        }

    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        MenuInflater menuInflater=getMenuInflater();
        menuInflater.inflate(R.menu.optionsmenu,menu);
        return true;
    }
}
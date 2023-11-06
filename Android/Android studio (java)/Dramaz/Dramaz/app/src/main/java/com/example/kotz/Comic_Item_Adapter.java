package com.example.kotz;

import android.content.Context;
import android.content.Intent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.bumptech.glide.Glide;
import com.firebase.ui.database.FirebaseRecyclerAdapter;
import com.firebase.ui.database.FirebaseRecyclerOptions;

import java.util.ArrayList;
import java.util.List;

public class Comic_Item_Adapter extends FirebaseRecyclerAdapter<Comic_item_model,Comic_Item_Adapter.myViewHolder> {
    Context context;


    public Comic_Item_Adapter(@NonNull FirebaseRecyclerOptions<Comic_item_model> options , Context context) {
        super(options);
        this.context=context;
    }

    @Override
    protected void onBindViewHolder(@NonNull myViewHolder holder, int position, @NonNull Comic_item_model model) {
        holder.name.setText(model.getName());
        Glide.with(holder.img.getContext())
                .load(model.iurl)
                .into(holder.img);
        holder.img.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent=new Intent(v.getContext(),Comicspage.class);
                List<String> episodes=model.Episodes;
                intent.putExtra("videolink", (ArrayList) episodes);
                intent.putExtra("imagelink",model.iurl);
                intent.putExtra("name",model.name);

                v.getContext().startActivity(intent);
            }
        });
        startListening();
    }

    @NonNull
    @Override
    public Comic_Item_Adapter.myViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view= LayoutInflater.from(parent.getContext()).inflate(R.layout.comics_item,parent,false);
        myViewHolder viewHolder=new myViewHolder(view);
        return  viewHolder;
    }

    class myViewHolder extends RecyclerView.ViewHolder{
        ImageView img;
        TextView name;

        public myViewHolder(@NonNull View itemView) {
            super(itemView);
            img=(ImageView)itemView.findViewById(R.id.Comicimage);
            name=(TextView)itemView.findViewById(R.id.ComicName);

        }
    }}

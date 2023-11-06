package com.example.dramazadmin;

import android.content.Intent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.bumptech.glide.Glide;
import com.firebase.ui.database.FirebaseRecyclerAdapter;
import com.firebase.ui.database.FirebaseRecyclerOptions;

import de.hdodenhof.circleimageview.CircleImageView;

public class Drama_list extends FirebaseRecyclerAdapter<LatestDlist,Drama_list.myViewHolder> {

    public Drama_list(@NonNull FirebaseRecyclerOptions<LatestDlist> options) {
        super(options);
    }

    @Override
    protected void onBindViewHolder(@NonNull myViewHolder holder, int position, @NonNull LatestDlist model) {
    holder.name.setText(model.getName());
        Glide.with(holder.img.getContext())
                .load(model.lurl)
                .placeholder(R.mipmap.ic_launcher_round)
                .circleCrop()
                .error(R.mipmap.ic_launcher_round)
                .into(holder.img);
        startListening();


    }

    @NonNull
    @Override
    public myViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view= LayoutInflater.from(parent.getContext()).inflate(R.layout.drama_list,parent,false);
        myViewHolder viewHolder=new myViewHolder(view);
        return  viewHolder;
    }

    class myViewHolder extends RecyclerView.ViewHolder{
        CircleImageView img;
        TextView name;

        public myViewHolder(@NonNull View itemView) {
            super(itemView);
            img=(CircleImageView)itemView.findViewById(R.id.drama1);
            name=(TextView)itemView.findViewById(R.id.name);

        }
    }
}

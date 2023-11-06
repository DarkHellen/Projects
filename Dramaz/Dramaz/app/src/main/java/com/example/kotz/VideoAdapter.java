package com.example.kotz;

import android.media.MediaPlayer;
import android.net.Uri;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.widget.ProgressBar;
import android.widget.TextView;
import android.widget.Toast;
import android.widget.VideoView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.firebase.ui.database.FirebaseRecyclerAdapter;
import com.firebase.ui.database.FirebaseRecyclerOptions;

public class VideoAdapter extends FirebaseRecyclerAdapter<LatestDlist,VideoAdapter.myviewholder> {
    /**
     * Initialize a {@link RecyclerView.Adapter} that listens to a Firebase query. See
     * {@link FirebaseRecyclerOptions} for configuration options.
     *
     * @param options
     */
    public VideoAdapter(@NonNull FirebaseRecyclerOptions<LatestDlist> options) {
        super(options);
    }

    @Override
    protected void onBindViewHolder(@NonNull myviewholder holder, int position, @NonNull LatestDlist model) {
        holder.setData(model);
    }

    @NonNull
    @Override
    public myviewholder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {

        View view= LayoutInflater.from(parent.getContext()).inflate(R.layout.trailer_video,parent,false);
        myviewholder viewH= new myviewholder(view);
        return  viewH;
    }

    class myviewholder extends RecyclerView.ViewHolder{

        VideoView video;
        TextView name;

        public myviewholder(@NonNull View itemView) {
            super(itemView);
            video=(VideoView) itemView.findViewById(R.id.videoView1);
           // name=(TextView) itemView.findViewById(R.id.textVideoTitle);

        }
        void setData(LatestDlist obj){
            Uri uri=Uri.parse(obj.url);

            video.setVideoPath(String.valueOf(uri));
            Toast.makeText(video.getContext(), "hi", Toast.LENGTH_SHORT).show();
            //name.setText(obj.getName());

            video.setOnPreparedListener(new MediaPlayer.OnPreparedListener() {
                @Override
                public void onPrepared(MediaPlayer mp) {

                    mp.start();
                }
            });

            video.setOnCompletionListener(new MediaPlayer.OnCompletionListener() {
                @Override
                public void onCompletion(MediaPlayer mp) {
                    mp.start();
                }
            });
        }
    }
}

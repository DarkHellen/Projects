package com.example.dramazadmin;

import androidx.appcompat.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import androidx.annotation.NonNull;

import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;

public class Upload extends AppCompatActivity {
    DatabaseReference databaseReference;
    EditText name,lurl,url;
    Button upload;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_upload);
        name=findViewById(R.id.Tname);
        lurl=findViewById(R.id.Imageurl);
        url=findViewById(R.id.Videourl);
        upload=findViewById(R.id.upload);

        databaseReference= FirebaseDatabase.getInstance().getReference("LatestDrama");
        upload.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String nm,Lurl,Url;
                nm=name.getText().toString();
                Lurl=lurl.getText().toString();
                Url=url.getText().toString();
                vupload(nm,Lurl,Url);

            }
        });
    }
    void vupload(String nm,String Lurl,String Url){
        UploadModel obj=new UploadModel(Lurl,nm,Url);
        databaseReference.child(databaseReference.push().getKey()).setValue(obj).addOnSuccessListener(new OnSuccessListener<Void>() {
            @Override
            public void onSuccess(Void unused) {
                Toast.makeText(Upload.this, "upload successfull", Toast.LENGTH_SHORT).show();
            }
        }).addOnFailureListener(new OnFailureListener() {
            @Override
            public void onFailure(@NonNull Exception e) {
                Toast.makeText(Upload.this, "upload failed", Toast.LENGTH_SHORT).show();
            }
        });
    }
}
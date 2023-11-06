package com.example.dramazadmin;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;

public class NewDrama extends AppCompatActivity {

    DatabaseReference databaseReference;
    EditText name,lurl,url;
    Button upload;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_new_drama);
        name=findViewById(R.id.Dname);
        lurl=findViewById(R.id.DImageurl);
        url=findViewById(R.id.DVideourl);
        upload=findViewById(R.id.Dupload);

        databaseReference= FirebaseDatabase.getInstance().getReference("Dramas");
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
    void vupload(String nm,String Lurl,String Url) {
        UploadModel obj = new UploadModel(Lurl, nm, Url);
        databaseReference.child(databaseReference.push().getKey()).setValue(obj).addOnSuccessListener(new OnSuccessListener<Void>() {
            @Override
            public void onSuccess(Void unused) {
                Toast.makeText(NewDrama.this, "upload successfull", Toast.LENGTH_SHORT).show();
            }
        }).addOnFailureListener(new OnFailureListener() {
            @Override
            public void onFailure(@NonNull Exception e) {
                Toast.makeText(NewDrama.this, "upload failed", Toast.LENGTH_SHORT).show();
            }
        });
    }
}
package com.example.kotz;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.auth.AuthResult;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;

public class MainActivity extends AppCompatActivity {
    FirebaseAuth mAuth;
    EditText Id,Pass;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        getSupportActionBar().hide();
         mAuth = FirebaseAuth.getInstance();
        Button Login=findViewById(R.id.LoginB);
        Button signUp=findViewById(R.id.SignUp);

        Id=findViewById(R.id.Id);
        Pass=findViewById(R.id.Password);
        Login.setOnClickListener(view ->{
            loginUser();
        });
        signUp.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startActivity(new Intent(MainActivity.this,Register.class));
            }
        });

    }

    private void loginUser() {
        String id,password;
        id=Id.getText().toString();
        password=Pass.getText().toString();
        if(TextUtils.isEmpty(id)){
            Id.setError("field cannot be empty");
        } else if(TextUtils.isEmpty(password)){
            Pass.setError("field cannot be empty");
        }else{
            mAuth.signInWithEmailAndPassword(id,password).addOnCompleteListener(new OnCompleteListener<AuthResult>() {
                @Override
                public void onComplete(@NonNull Task<AuthResult> task) {
                    if(task.isSuccessful()){
                        Toast.makeText(MainActivity.this, "Login Successful", Toast.LENGTH_SHORT).show();
                        startActivity(new Intent(MainActivity.this,home.class));
                    }else {
                        Toast.makeText(MainActivity.this, "Login Failed: "+task.getException().getMessage(), Toast.LENGTH_SHORT).show();
                    }
                }
            });
        }
    }


}
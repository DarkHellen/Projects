package com.example.kotz;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.auth.AuthResult;
import com.google.firebase.auth.FirebaseAuth;

import java.net.PasswordAuthentication;

public class Register extends AppCompatActivity {
    EditText Id,Password,Cpassword;
    Button Register;
    FirebaseAuth mAuth;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_register);
        Id=findViewById(R.id.Id);
        Password =findViewById(R.id.Password);
        Cpassword=findViewById(R.id.CPassword);
        Register=findViewById(R.id.LoginB);

        mAuth = FirebaseAuth.getInstance();
        Register.setOnClickListener(view ->{
            createUser();
        });
    }

    private void createUser() {
        String email,password,cpassword;
        email=Id.getText().toString();
        password= Password.getText().toString();
        cpassword=Cpassword.getText().toString();
        if(TextUtils.isEmpty(email)){
            Id.setError("field cannot be empty");
        } else if(TextUtils.isEmpty(password)){
            Password.setError("field cannot be empty");
        }  else if(TextUtils.isEmpty(cpassword)){
            Cpassword.setError("field cannot be empty");
        }
        else if(password.equals(cpassword)) {

            Toast.makeText(Register.this, "Registration successfull", Toast.LENGTH_SHORT).show();
            Intent intent = new Intent(com.example.kotz.Register.this, Payment.class);
            intent.putExtra("id", email);
            intent.putExtra("password", password);
            startActivity(intent);
        }else{
                        Toast.makeText(Register.this, "passwoed does not match ", Toast.LENGTH_SHORT).show();
                    }
                }
            }





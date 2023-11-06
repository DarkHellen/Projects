package com.example.dramazadmin;

import android.content.Intent;
import android.os.Bundle;
import androidx.appcompat.app.AppCompatActivity;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

public class MainActivity extends AppCompatActivity {
    EditText id,pass;
    Button login;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        getSupportActionBar().hide();
        id=findViewById(R.id.Id);
        pass=findViewById(R.id.Password);
        login=findViewById(R.id.LoginB);
        login.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String Id,Pass;
                Id=id.getText().toString();
                Pass=pass.getText().toString();
                login(Id,Pass);
            }
        });

    }
    public void login(String Id,String Pass){
        if(Id.isEmpty() || Pass.isEmpty()){
            Toast.makeText(this, "Blank Credential", Toast.LENGTH_SHORT).show();
        } else if (Id.equals("SUJAL")) {
            if (Pass.equals("SUJAL")){
                startActivity(new Intent(MainActivity.this,AdminHome.class));
            }

        }
    }


}
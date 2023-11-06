package com.example.kotz;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.auth.AuthResult;
import com.google.firebase.auth.FirebaseAuth;
import com.shreyaspatil.EasyUpiPayment.EasyUpiPayment;
import com.shreyaspatil.EasyUpiPayment.listener.PaymentStatusListener;
import com.shreyaspatil.EasyUpiPayment.model.TransactionDetails;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

public class Payment extends AppCompatActivity {
    private EditText amountEdt, upiEdt, nameEdt, descEdt;
    private TextView transactionDetailsTV;
    FirebaseAuth mAuth;
   String Id,Pass;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_payment);

        Button makePaymentBtn = findViewById(R.id.idBtnMakePayment);

        mAuth = FirebaseAuth.getInstance();
        Id=getIntent().getStringExtra("id");
        Pass=getIntent().getStringExtra("password");

        // on below line we are getting date and then we are setting this date as transaction id.
        Date c = Calendar.getInstance().getTime();
        SimpleDateFormat df = new SimpleDateFormat("ddMMyyyyHHmmss", Locale.getDefault());
        String transcId = df.format(c);

        // on below line we are adding click listener for our payment button.
        makePaymentBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                // on below line we are getting data from our edit text.
                String amount = "1.00";
                String upi = "8104182187@sbi";


                    makePayment(amount, upi, "Dramaz", "app subscription", transcId,Id,Pass);
                           }
        });
    }

    private void makePayment(String amount, String upi, String name, String desc, String transactionId,String id,String pass) {
        // on below line we are calling an easy payment method and passing
        // all parameters to it such as upi id,name, description and others.
        final EasyUpiPayment easyUpiPayment = new EasyUpiPayment.Builder()
                .with(this)
                // on below line we are adding upi id.
                .setPayeeVpa(upi)
                // on below line we are setting name to which we are making payment.
                .setPayeeName(name)
                // on below line we are passing transaction id.
                .setTransactionId(transactionId)
                // on below line we are passing transaction ref id.
                .setTransactionRefId(transactionId)
                // on below line we are adding description to payment.
                .setDescription(desc)
                // on below line we are passing amount which is being paid.
                .setAmount(String.valueOf(1.00))
                // on below line we are calling a build method to build this ui.
                .build();
        // on below line we are calling a start
        // payment method to start a payment.
        easyUpiPayment.startPayment();
        // on below line we are calling a set payment
        // status listener method to call other payment methods.
        easyUpiPayment.setPaymentStatusListener(new PaymentStatusListener() {
            @Override
            public void onTransactionCompleted( TransactionDetails transactionDetails) {
                // on below line we are getting details about transaction when completed.
                String transcDetails = transactionDetails.getStatus().toString() + "\n" + "Transaction ID : " + transactionDetails.getTransactionId();
                transactionDetailsTV.setVisibility(View.VISIBLE);
                // on below line we are setting details to our text view.
                transactionDetailsTV.setText(transcDetails);
                createUser(id,pass);
            }

            @Override
            public void onTransactionSuccess() {
                // this method is called when transaction is successful and we are displaying a toast message.
                Toast.makeText(Payment.this, "Transaction successfully completed..", Toast.LENGTH_SHORT).show();
            }

            @Override
            public void onTransactionSubmitted() {
                // this method is called when transaction is done
                // but it may be successful or failure.
                Log.e("TAG", "TRANSACTION SUBMIT");
            }

            @Override
            public void onTransactionFailed() {
                // this method is called when transaction is failure.
                Toast.makeText(Payment.this, "Failed to complete transaction", Toast.LENGTH_SHORT).show();
            }

            @Override
            public void onTransactionCancelled() {
                // this method is called when transaction is cancelled.
                Toast.makeText(Payment.this, "Transaction cancelled..", Toast.LENGTH_SHORT).show();
            }

            @Override
            public void onAppNotFound() {
                // this method is called when the users device is not having any app installed for making payment.
                Toast.makeText(Payment.this, "No app found for making transaction..", Toast.LENGTH_SHORT).show();
            }
        });

    }
    private void createUser(String email,String password) {

        mAuth.createUserWithEmailAndPassword(email, password).addOnCompleteListener(new OnCompleteListener<AuthResult>() {
            @Override
            public void onComplete(@NonNull Task<AuthResult> task) {
                if (task.isSuccessful()) {
                    Toast.makeText(Payment.this, "Registration successfull", Toast.LENGTH_SHORT).show();
                    startActivity(new Intent(Payment.this, MainActivity.class));
                } else {
                    Toast.makeText(Payment.this, "Registration failed: " + task.getException().getMessage(), Toast.LENGTH_SHORT).show();
                }
            }
        });
    }











    }

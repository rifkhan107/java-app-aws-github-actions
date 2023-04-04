package com.example.awsecsspringbootapp;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class AwsEcsSpringBootAppApplication {

    public static void main(String[] args) {
        SpringApplication.run(AwsEcsSpringBootAppApplication.class, args);
    }

    @GetMapping("/")
    public String helloWorld() {
        return "Hello, World!";
    }
}
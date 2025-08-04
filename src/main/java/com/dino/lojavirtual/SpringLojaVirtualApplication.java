package com.dino.lojavirtual;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@SpringBootApplication
@EnableJpaRepositories(basePackages = { "com.dino.lojavirtual.repository" })
@EnableTransactionManagement
public class SpringLojaVirtualApplication {

    public static void main(String[] args) {
        SpringApplication.run(SpringLojaVirtualApplication.class, args);
    }

}

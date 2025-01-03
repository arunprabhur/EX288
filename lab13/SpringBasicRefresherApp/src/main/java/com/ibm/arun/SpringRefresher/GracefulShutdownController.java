package com.ibm.arun.SpringRefresher;

import jakarta.annotation.PreDestroy;
import org.springframework.stereotype.Component;

@Component
public class GracefulShutdownController {

    @PreDestroy
public void onShutdown(){
    System.out.println("GraceFul Shutdown");
}
}

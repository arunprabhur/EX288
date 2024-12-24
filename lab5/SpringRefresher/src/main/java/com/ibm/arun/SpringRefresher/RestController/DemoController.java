package com.ibm.arun.SpringRefresher.RestController;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class DemoController {

    @RequestMapping(path = "/info", method=RequestMethod.GET)
    private String getInfo(){
        return "Hello World";
    }

}

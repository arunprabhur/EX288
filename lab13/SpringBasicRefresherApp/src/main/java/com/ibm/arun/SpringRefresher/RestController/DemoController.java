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

    @RequestMapping(path = "/healthcheck", method=RequestMethod.GET)
    private String getHealth(){
        return "OK";
    }

    @RequestMapping(path = "/v2", method=RequestMethod.GET)
    private String getversion2(){
        return "version 2";
    }


}

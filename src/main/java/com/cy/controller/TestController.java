package com.cy.controller;


import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * TestController
 *
 * @author wxhn1
 * @since 2024-04-04 22:10
 */
@RestController
public class TestController {
	
	@RequestMapping("/test")
	public String test() {
    return "test----success-aaaaaaaaaaaaaaaaa";
  }
	
}

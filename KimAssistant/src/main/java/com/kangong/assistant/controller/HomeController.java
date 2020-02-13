package com.kangong.assistant.controller;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login(Locale locale, Model model) {
		logger.info("Welcome login! ");	
		
		return "login";
	}
	
	@RequestMapping(value = "/loginCallback", method = RequestMethod.GET)
	public String loginCallback(Locale locale, Model model) {
		logger.info("Welcome loginCallback! ");	
		
		return "loginCallback";
	}
	
	@RequestMapping(value = "/jsrenderTest", method = RequestMethod.GET)
	public String jsrenderTest(Locale locale, Model model) {
		logger.info("Welcome jsrenderTest! ");	
		
		return "jsrender/jsrenderTest";
	}
	
	@RequestMapping(value = "/jsrenderTest2", method = RequestMethod.GET)
	public String jsrenderTest2(Locale locale, Model model) {
		logger.info("Welcome jsrenderTest2! ");	
		
		return "jsrender/jsrenderTest2";
	}
	
	@RequestMapping(value = "/mention", method = RequestMethod.GET)
	public String mention(Locale locale, Model model) {
		logger.info("Welcome mention! ");	
		
		return "mention";
	}
	
	@RequestMapping(value = "/getJson", method = RequestMethod.GET)
	@ResponseBody
	public List getJson(Locale locale, Model model) {
		logger.info("Welcome getJson! ");	
		List resultList = new ArrayList();
		
		Map data1 = new HashMap();
		data1.put("id","1");
		data1.put("name","레몬");
		data1.put("price","3000");
		data1.put("description","피로회복에 좋고 비타민C 풍부");
		resultList.add(data1);
		
		Map data2 = new HashMap();
		data2.put("id","2");
		data2.put("name","키위");
		data2.put("price","2000");
		data2.put("description","비타민c 풍부, 다이어트와 미용");
		resultList.add(data2);
		
		Map data3 = new HashMap();
		data3.put("id","3");
		data3.put("name","블루베리");
		data3.put("price","5000");
		data3.put("description","안토시아니은 눈피로에 좋다");
		resultList.add(data3);
		
		return resultList;
	}
}

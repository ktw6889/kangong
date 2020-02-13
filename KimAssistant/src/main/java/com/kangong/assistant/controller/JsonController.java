package com.kangong.assistant.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.kangong.assistant.model.HomeVo;

import net.sf.json.JSONArray;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/json")
public class JsonController {
	
	private static final Logger logger = LoggerFactory.getLogger(JsonController.class);
	
	@RequestMapping(value = "/mention", method = RequestMethod.GET)
	public String mention(Locale locale, Model model) {
		logger.info("Welcome mention! ");	
		
		return "mention";
	}
	
	@RequestMapping(value = "/getJsonVo", method = RequestMethod.GET)
	@ResponseBody
	public void getJsonVo(HttpServletResponse response) throws Exception{
		logger.info("Welcome getJson! ");	
		ObjectMapper mapper = new ObjectMapper(); 

		HomeVo homeVo = new HomeVo();
		homeVo.setId("1");
		homeVo.setName("레몬");
		homeVo.setPrice("3000");
		homeVo.setDescription("피로회복에 좋고 비타민C 풍부");
		
		response.getWriter().print(mapper.writeValueAsString(homeVo));
	}
	
	@RequestMapping(value= "/getJsonResponseBody", method=RequestMethod.GET) 
	public @ResponseBody HomeVo getJsonResponseBody()  { 

		HomeVo homeVo = new HomeVo();
		homeVo.setId("1");
		homeVo.setName("레몬");
		homeVo.setPrice("3000");
		homeVo.setDescription("피로회복에 좋고 비타민C 풍부");
	    return homeVo; 
	}

	@RequestMapping(value= "/getJsonModel", method=RequestMethod.GET) 
	public ModelAndView AjaxView()  {   
	    ModelAndView mav= new ModelAndView(); 

	    HomeVo homeVo = new HomeVo();
		homeVo.setId("1");
		homeVo.setName("레몬");
		homeVo.setPrice("3000");
		homeVo.setDescription("피로회복에 좋고 비타민C 풍부");
		
	    mav.addObject("result",homeVo); 
	    mav.setViewName("jsonView"); 
	    return mav; 
	} 


	
	@RequestMapping(value = "/getJsonArray", method = RequestMethod.GET,  produces="application/json; charset=utf8")
	@ResponseBody
	public String getJsonArray(Locale locale, Model model) {
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
		
		JSONArray jsonArray = new JSONArray(); 
		ModelAndView mdl = new ModelAndView();

		return jsonArray.fromObject(resultList).toString();
	}
}

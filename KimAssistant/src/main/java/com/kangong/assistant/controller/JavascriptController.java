package com.kangong.assistant.controller;

import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.kangong.assistant.model.HomeVo;

@Controller
@RequestMapping("/jscript")
public class JavascriptController {

	private static final Logger logger = LoggerFactory.getLogger(JavascriptController.class);
	
	@RequestMapping(value = "/jsScope", method = RequestMethod.GET)
	public String jsScope(Locale locale, Model model) {
		logger.info("Welcome jsScope! ");	
		
		return "jscript/jsScope";
	}
	
	@RequestMapping(value = "/jsScope2", method = RequestMethod.GET)
	public String jsScope2(Locale locale, Model model) {
		logger.info("Welcome jsScope2! ");	
		
		return "jscript/jsScope2";
	}
	
	@RequestMapping(value = "/jsClosure", method = RequestMethod.GET)
	public String jsClosure(Locale locale, Model model) {
		logger.info("Welcome jsClosure! ");	
		
		return "jscript/jsClosure";
	}
	
	@RequestMapping(value = "/jsClosure2", method = RequestMethod.GET)
	public String jsClosure2(Locale locale, Model model) {
		logger.info("Welcome jsClosure2! ");	
		
		return "jscript/jsClosure2";
	}
	
	@RequestMapping(value = "/jsDivMouseOver", method = RequestMethod.GET)
	public String jsDivMouseOver(Locale locale, Model model) {
		logger.info("Welcome jsDivMouseOver! ");	
		
		return "jscript/jsDivMouseOver";
	}
	
	@RequestMapping(value= "/floating_contents", method=RequestMethod.GET) 
	public ModelAndView AjaxView()  {   
		logger.info("Welcome floating_contents! ");	
	    ModelAndView mav= new ModelAndView(); 

	    /*HomeVo homeVo = new HomeVo();
		homeVo.setId("1");
		homeVo.setName("레몬");
		homeVo.setPrice("3000");
		homeVo.setDescription("피로회복에 좋고 비타민C 풍부");
		*/
	    mav.addObject("result","floating_contents"); 
	    mav.setViewName("jsonView"); 
	    return mav; 
	} 
}

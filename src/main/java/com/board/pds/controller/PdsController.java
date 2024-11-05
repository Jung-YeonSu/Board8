package com.board.pds.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.board.pds.service.PdsService;
import com.board.pds.vo.PdsVo;

@Controller
@RequestMapping("/Pds")
public class PdsController {
	
	@Autowired
	private PdsService pdsService;
	
	@RequestMapping("/List")
	public ModelAndView list(@RequestParam HashMap<String,Object> map) {
		List<PdsVo> pdsList = pdsService.getPdsList(map);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("pdsList",pdsList);
		mv.addObject("map",map);
		mv.setViewName("pds/list");
		return mv;
	}
	
	
}

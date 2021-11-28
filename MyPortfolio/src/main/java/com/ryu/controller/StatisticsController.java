package com.ryu.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.ryu.dto.StatisticsDTO;
import com.ryu.service.StatisticsService;

import lombok.Setter;


@RestController
public class StatisticsController {
	
	@Setter(onMethod_ =  @Autowired)
	private StatisticsService service; 
	
	ModelAndView mv = new ModelAndView();
	
	@RequestMapping(value="/statistics/grid", method = RequestMethod.GET)
	public ModelAndView getList() {
		mv.setViewName("/statistics/list");
		return mv;
	}
	
	@RequestMapping(value="/api/statistics", method = RequestMethod.GET)
	public List<StatisticsDTO> getListApi() {
		List<StatisticsDTO> list = service.getList();
		for (StatisticsDTO dto : list) {
			Date from = new Date();
			SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
			String regdate = transFormat.format(dto.getRegidate());
			dto.setRegdate(regdate);
		}
		return list;
	}
	
	
	@RequestMapping(value="/statistics/chart", method = RequestMethod.GET)
	public ModelAndView getListForChart() {
		mv.setViewName("/statistics/chart");
		return mv;
	}
	

}
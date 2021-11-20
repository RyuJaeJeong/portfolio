package com.ryu.controller;

import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.ryu.common.Criteria;
import com.ryu.common.PageDTO;
import com.ryu.dto.AuthDTO;
import com.ryu.dto.MemberDTO;
import com.ryu.service.MemberService;
import lombok.Setter;

@Controller
public class MemberController {
	
	@Setter(onMethod_ =  @Autowired)
	private MemberService service;
	
	ModelAndView mv = new ModelAndView();
	
	@RequestMapping(value="/members", method = RequestMethod.GET)
	public ModelAndView getList(Criteria cri) {
		List<MemberDTO> list = service.getList(cri);
		int total = service.getTotalCount(cri);
		PageDTO dto = new PageDTO(cri, total);
		mv.setViewName("/member/list");
		mv.addObject("list", list);
		mv.addObject("pageMaker", dto);
		return mv;
	}
	
	@RequestMapping(value="/members/new",method = RequestMethod.GET)
	public ModelAndView setInsert() {
		mv.setViewName("/member/register");
		return mv;
	}
	
	@RequestMapping(value="/members/new/checkuserid",method = RequestMethod.POST)
	@ResponseBody
	public int checkId(String userid) {
		int num = service.checkId(userid);
		return num;
	}
	
	@PostMapping(value="/members/new")
	public String setInsert(MemberDTO dto, AuthDTO auth) {
		List<AuthDTO> authList = new ArrayList<>();
		authList.add(auth);
		dto.setAuthList(authList);
		service.setInsert(dto);
		return "redirect:/";
	}
	
	@RequestMapping(value="/members/{userid}", method = RequestMethod.GET)
	public ModelAndView get(@PathVariable("userid") String userid, @ModelAttribute("cri") Criteria cri) {
		MemberDTO dto = service.getRead(userid);
		mv.setViewName("/member/get");
		mv.addObject("dto", dto);
		return mv;
	}
	
	@RequestMapping(value="/members/{userid}/edit",method = RequestMethod.GET)
	public ModelAndView setUpdate(@ModelAttribute("cri") Criteria cri, @PathVariable("userid") String userid) {
		MemberDTO dto =service.getRead(userid);
		mv.setViewName("/member/modify");
		return mv;
	}
	
	@RequestMapping(value="/members/{userid}", method = RequestMethod.PUT)
	public String setUpdate(MemberDTO dto, AuthDTO auth, @ModelAttribute("cri") Criteria cri, @PathVariable("userid") String userid) {
		List<AuthDTO> authList = new ArrayList<>();
		authList.add(auth);
		dto.setAuthList(authList);
		service.setUpdate(dto);
		return "redirect:/members";
	}
	
	@RequestMapping(value="/members/{userid}", method = RequestMethod.DELETE)
	public String setDelete(Criteria cri, @PathVariable("userid") String userid) {
		service.setDelete(userid);
		return "redirect:/members";
	}
}

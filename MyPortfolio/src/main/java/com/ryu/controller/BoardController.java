package com.ryu.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.ryu.dto.BoardDTO;
import com.ryu.mapper.BoardMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;


@RestController
@Log4j
public class BoardController {
	@Setter(onMethod_ =  @Autowired)
	private BoardMapper mapper;
	
	ModelAndView mv = new ModelAndView();
	
	@GetMapping(value="/board")
	public ModelAndView getList() {
		List<BoardDTO> list = mapper.getList();
		mv.setViewName("/board/list");
		mv.addObject("list", list);
		return mv;
	}
	
	
	
	@GetMapping(value="/board/write")
	public ModelAndView setInsert() {
		mv.setViewName("/board/write");
		return mv;
	}
	
	@PostMapping(value="/board/write")
	public String setInserts(BoardDTO dto) {
		mapper.setInsert(dto);
		return "<script>location.href='/board'</script>";
	}
	
	@GetMapping(value="/board/{no}")
	public ModelAndView getRead(@PathVariable("no") long no) {
		BoardDTO dto = mapper.getRead(no);
		mv.setViewName("/board/get");
		mv.addObject("dto", dto);
		return mv;
	}
	
	@GetMapping(value="/board/modify/{no}")
	public ModelAndView setUpdate(@PathVariable("no") long no) {
		BoardDTO dto = mapper.getRead(no);
		mv.setViewName("/board/modify");
		mv.addObject("dto", dto);
		return mv;
	}
	
	@PutMapping(value="/board/modify/{no}")
	public String setUpdate(BoardDTO dto, @PathVariable long no) {
		mapper.setUpdate(dto);
		return "<script>location.href='/board'</script>";
	}
	
	@DeleteMapping(value="/board/{no}")
	public String setDelete(long no) {
		mapper.setDelete(no);
		return "<script>location.href='/board'</script>";
	}
}
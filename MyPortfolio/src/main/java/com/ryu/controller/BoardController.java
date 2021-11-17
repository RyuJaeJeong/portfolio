package com.ryu.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import com.ryu.common.Criteria;
import com.ryu.common.PageDTO;
import com.ryu.dto.BoardDTO;
import com.ryu.mapper.BoardMapper;

import jdk.internal.org.jline.utils.Log;
import lombok.Setter;
import lombok.extern.log4j.Log4j;


@RestController
@Log4j
public class BoardController {
	@Setter(onMethod_ =  @Autowired)
	private BoardMapper mapper;
	
	ModelAndView mv = new ModelAndView();
	
	@GetMapping(value="/board")
	public ModelAndView getList(Criteria cri) {
		List<BoardDTO> list = mapper.getListWithPaging(cri);
		int total = mapper.getTotalCount(cri);
		PageDTO dto = new PageDTO(cri, total);
		mv.setViewName("/board/list");
		mv.addObject("list", list);
		mv.addObject("pageMaker", dto);
		return mv;
	}
	
	@GetMapping(value="/board/write")
	public ModelAndView setInsert() {
		mv.setViewName("/board/write");
		return mv;
	}
	
	@GetMapping(value="/board/write/{no}")
	public ModelAndView setInsert(@PathVariable("no") long no) {
		BoardDTO dto = mapper.getRead(no);
		
		
		String re_content = "";
		re_content += "["+dto.getWriter() + "]님이 작성한 글입니다.\n";
		re_content = re_content.replace("\n", "\n>");
		re_content += ">"+dto.getContent()+"\n";
		re_content += "----------------------------------------\n";
		dto.setContent(re_content);
		mv.addObject("board", dto);
		mv.setViewName("/board/write");
		return mv;
	}
	
	@PostMapping(value="/board/write")
	public String setInsert(BoardDTO dto) {
		
		if(dto.getMgr()>0) {
			mapper.setReInsert(dto);
		} else {
			mapper.setInsert(dto);
			
		}
		
		
		return "<script>location.href='/board'</script>";
	}
	
	@GetMapping(value="/board/{no}")
	public ModelAndView getRead(@PathVariable("no") long no, @ModelAttribute("cri") Criteria cri) {
		BoardDTO dto = mapper.getRead(no);
		mv.setViewName("/board/get");
		mv.addObject("dto", dto);
		return mv;
	}
	
	@GetMapping(value="/board/modify/{no}")
	public ModelAndView setUpdate(@PathVariable("no") long no, @ModelAttribute("cri") Criteria cri) {
		BoardDTO dto = mapper.getRead(no);
		mv.setViewName("/board/modify");
		mv.addObject("dto", dto);
		return mv;
	}
	
	@PutMapping(value="/board/modify/{no}")
	public String setUpdate(BoardDTO dto, Criteria cri,@PathVariable long no) {
		mapper.setUpdate(dto);
		return "<script>location.href='/board" + cri.getListLink()+ "'</script>";
	}
	
	@DeleteMapping(value="/board/{no}")
	public String setDelete(Criteria cri, long no) {
		System.out.println(cri.getListLink());
		mapper.setDelete(no);
		
		return "<script>location.href='/board" + cri.getListLink()+ "'</script>";
	}
}
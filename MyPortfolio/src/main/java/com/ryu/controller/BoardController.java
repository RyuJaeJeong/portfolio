package com.ryu.controller;


import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import com.ryu.common.Criteria;
import com.ryu.common.PageDTO;
import com.ryu.dto.BoardDTO;
import com.ryu.service.BoardService;
import lombok.Setter;




@Controller
public class BoardController {
	
	@Setter(onMethod_ =  @Autowired)
	private BoardService service;
	
	ModelAndView mv = new ModelAndView();
	
	@RequestMapping(value="/board", method = RequestMethod.GET)
	public ModelAndView getList(Criteria cri) {
		
		List<BoardDTO> list = service.getList(cri);
		int total = service.getTotalCount(cri);
		PageDTO dto = new PageDTO(cri, total);
		mv.setViewName("/board/list");
		mv.addObject("list", list);
		mv.addObject("pageMaker", dto);
		return mv;
	}
	
	//글쓰기 폼 호출
	@RequestMapping(value="/board/new", method = RequestMethod.GET)
	@PreAuthorize("isAuthenticated()")
	public ModelAndView setInsert() {
		mv.setViewName("/board/write");
		return mv;
	}
	
	//답변쓰기 폼 호출
	@RequestMapping(value="/board/{bno}/answer", method = RequestMethod.GET)
	@PreAuthorize("isAuthenticated()")
	public ModelAndView setAnswer(@PathVariable("bno") long bno) {
		BoardDTO dto = service.getRead(bno);
		String re_content = "";
		re_content += "["+dto.getWriter() + "]님이 작성한 글입니다.\n";
		re_content = re_content.replace("\n", "\n>");
		re_content += ">"+dto.getContent()+"\n";
		re_content += "----------------------------------------\n";
		dto.setContent(re_content);
		mv.addObject("board", dto);
		mv.setViewName("/board/answer");
		return mv;
	}
	
	//글쓰기 제출
	@PostMapping(value="/board/new")
	public String setInsert(BoardDTO dto) {
		if(dto.getMgr()>0) {
			service.setReInsert(dto);
		} else {
			service.setInsert(dto);
		}
		return "redirect:/board";
	}
	
	//상세보기
	@RequestMapping(value="/board/{bno}", method = RequestMethod.GET)
	public ModelAndView getRead(@PathVariable("bno") long bno, @ModelAttribute("cri") Criteria cri) {
		BoardDTO dto = service.getRead(bno);
		mv.setViewName("/board/get");
		mv.addObject("dto", dto);
		return mv;
	}
	
	//수정하기 폼
	@GetMapping(value="/board/{bno}/edit")
	public ModelAndView setUpdate(@PathVariable("bno") long bno, @ModelAttribute("cri") Criteria cri) {
		BoardDTO dto = service.getRead(bno);
		mv.setViewName("/board/modify");
		mv.addObject("dto", dto);
		return mv;
	}
	
	//수정하기
	@PutMapping(value="/board/{bno}")
	public String setUpdate(BoardDTO dto, Criteria cri, @PathVariable("bno") long bno) {
		service.setUpdate(dto);
		String temp = cri.getListLink();
		System.out.println(temp);
		return "redirect:/board" + temp;
	}
	
	//삭제하기
	@DeleteMapping(value="/board/{bno}")
	public String setDelete(Criteria cri, @PathVariable("bno") long bno) {
		service.setDelete(bno);
		String temp = cri.getListLink();
		System.out.println(temp);
		return "redirect:/board" + temp;
	}
}
package com.ryu.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import com.ryu.common.Criteria;
import com.ryu.common.PageDTO;
import com.ryu.dto.ReplyDTO;
import com.ryu.dto.ReplyPageDTO;
import com.ryu.service.ReplyService;
import lombok.Setter;

@RestController
public class ReplyController {
	
	@Setter(onMethod_ =  @Autowired)
	private ReplyService service;
	
	ModelAndView mv = new ModelAndView();
	
	@GetMapping(value="/replies/pages/{bno}/{page}")
	public ResponseEntity<ReplyPageDTO> getList(@PathVariable("page") int pageNumber,
			  @PathVariable("bno") long bno) {
		int total = service.getCountByBno(bno);
		Criteria cri = new Criteria(pageNumber, 5);
		PageDTO dto = new PageDTO(cri, total);
		List<ReplyDTO> replyList = service.getList(bno, cri);
		return new ResponseEntity<>(new ReplyPageDTO(dto, replyList), HttpStatus.OK);
	}
	
	@PostMapping(value="/replies/new")
	public ResponseEntity<String> setInsert(ReplyDTO dto) {
		int insertCount = service.setInsert(dto);
		return insertCount == 1? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value="/replies/{rno}")
	public ResponseEntity<ReplyDTO> get(@PathVariable("rno") long rno) {
		ReplyDTO dto = service.get(rno);
		return new ResponseEntity<>(dto, HttpStatus.OK);
	}
	
	@PutMapping(value="/replies/{rno}", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(@RequestBody ReplyDTO dto, @PathVariable("rno") long rno) {
		int modifyCount = service.modify(dto);
		return modifyCount ==1? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	
	@DeleteMapping(value="/replies/{rno}")
	public ResponseEntity<String> delete(@PathVariable("rno") long rno){
		ReplyDTO dto = service.get(rno);
		int deleteCount = service.delete(rno);
		return deleteCount ==1? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}

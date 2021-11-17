package com.ryu.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
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
import com.ryu.mapper.BoardMapper;
import com.ryu.mapper.ReplyMapper;

import lombok.Setter;

@RestController
public class ReplyController {
	
	@Setter(onMethod_ =  @Autowired)
	private ReplyMapper mapper;
	
	@Setter(onMethod_ =  @Autowired)
	private BoardMapper boardMapper;
	
	ModelAndView mv = new ModelAndView();
	
	@GetMapping(value="/replies/pages/{bno}/{page}")
	public ResponseEntity<ReplyPageDTO> getList(@PathVariable("page") int page,
			  @PathVariable("bno") long bno) {
		int total = mapper.getCountByBno(bno);
		Criteria cri = new Criteria(page, 5);
		PageDTO dto = new PageDTO(cri, total);
		List<ReplyDTO> replyList = mapper.getListWithPaging(cri, bno);
		return new ResponseEntity<>(new ReplyPageDTO(dto, replyList), HttpStatus.OK);
		
	}
	
	@Transactional
	@PostMapping(value="/replies/new")
	public ResponseEntity<String> setInsert(ReplyDTO dto) {
		int insertCount = mapper.insert(dto);
		boardMapper.updateReplyCnt(dto.getBoard_no(), 1);
		return insertCount == 1? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value="/replies/{no}")
	public ResponseEntity<ReplyDTO> get(@PathVariable("no") long no) {
		ReplyDTO dto = mapper.get(no);
		System.out.println(dto.getBoard_no());
		return new ResponseEntity<>(dto, HttpStatus.OK);
	}
	
	@PutMapping(value="/replies/{no}", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(@RequestBody ReplyDTO dto, @PathVariable("no") long no) {
		int modifyCount = mapper.update(dto);
		return modifyCount ==1? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@Transactional
	@DeleteMapping(value="/replies/{no}")
	public ResponseEntity<String> delete(@PathVariable("no") long no){
		ReplyDTO dto = mapper.get(no);
		System.out.println(dto.toString());
		int deleteCount = mapper.delete(no);
		boardMapper.updateReplyCnt(dto.getBoard_no(), -1);
		return deleteCount ==1? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}

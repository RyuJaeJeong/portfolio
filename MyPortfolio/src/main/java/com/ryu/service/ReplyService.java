package com.ryu.service;

import java.util.List;

import com.ryu.common.Criteria;
import com.ryu.dto.ReplyDTO;


public interface ReplyService {
	
	
	public List<ReplyDTO> getList(long bno, Criteria cri);
	public int getCountByBno(long bno);
	public int setInsert(ReplyDTO dto);
	public ReplyDTO get(long rno);
	public int modify(ReplyDTO dto);
	public int delete(long rno);
}

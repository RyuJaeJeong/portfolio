package com.ryu.service;

import java.util.List;

import com.ryu.common.Criteria;
import com.ryu.dto.BoardDTO;

public interface BoardService {
	
	
	public List<BoardDTO> getList(Criteria cri);
	
	public void setInsert(BoardDTO dto);
	
	public void setReInsert(BoardDTO dto);
	
	public BoardDTO getRead(long bno);
	
	public boolean setUpdate(BoardDTO dto);
	
	public boolean setDelete(long bno);
	
	public int getTotalCount(Criteria cri);
	
}

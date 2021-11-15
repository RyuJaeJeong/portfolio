package com.ryu.mapper;

import java.util.List;

import com.ryu.dto.BoardDTO;

//데이터 crud는 java 인터페이스와 xml파일로 구현한다. 
public interface BoardMapper {
	
	public void setInsert(BoardDTO dto);
	
	public List<BoardDTO> getList();
	
	public BoardDTO getRead(long no);
	
	public int setDelete(long no);
	
	public int setUpdate(BoardDTO dto);
	
}

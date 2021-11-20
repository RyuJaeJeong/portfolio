package com.ryu.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ryu.common.Criteria;
import com.ryu.dto.BoardDTO;

//데이터 crud는 java 인터페이스와 xml파일로 구현한다. 
public interface BoardMapper {
	
	public void setInsert(BoardDTO dto);
	
	public void setReInsert(BoardDTO dto);
	
	public List<BoardDTO> getList();
	
	public List<BoardDTO> getListWithPaging(Criteria cri);
	
	public int getTotalCount(Criteria cri);
	
	public BoardDTO getRead(long bno);
	
	public int setDelete(long bno);
	
	public int setUpdate(BoardDTO dto);
	
	public void updateReplyCnt(@Param("bno") long bno, @Param("amount") int amount);
	
}

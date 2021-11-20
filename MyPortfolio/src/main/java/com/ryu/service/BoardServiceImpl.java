package com.ryu.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ryu.common.Criteria;
import com.ryu.dto.BoardDTO;
import com.ryu.mapper.BoardMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class BoardServiceImpl implements BoardService {
	
	@Setter(onMethod_ =  @Autowired)
	private BoardMapper mapper;
	
	@Override
	public List<BoardDTO> getList(Criteria cri) {
		log.info("getListWithPaging-------------"+cri);
		return mapper.getListWithPaging(cri);
	}

	@Override
	public void setInsert(BoardDTO dto) {
		mapper.setInsert(dto);
	}

	@Override
	public BoardDTO getRead(long bno) {
		return mapper.getRead(bno);
	}

	@Override
	public boolean setUpdate(BoardDTO dto) {
		return mapper.setUpdate(dto) == 1;
	}

	@Override
	public boolean setDelete(long bno) {
		return mapper.setDelete(bno) == 1;
	}

	@Override
	public void setReInsert(BoardDTO dto) {
		mapper.setReInsert(dto);
	}

	@Override
	public int getTotalCount(Criteria cri) {
		return mapper.getTotalCount(cri);
	}

}

package com.ryu.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ryu.common.Criteria;
import com.ryu.dto.ReplyDTO;
import com.ryu.mapper.BoardMapper;
import com.ryu.mapper.ReplyMapper;
import lombok.Setter;

@Service
public class ReplyServiceImpl implements ReplyService {
	
	@Setter(onMethod_ =  @Autowired)
	private ReplyMapper mapper;
	
	@Setter(onMethod_ =  @Autowired)
	private BoardMapper boardMapper;

	@Override
	public List<ReplyDTO> getList(long bno, Criteria cri) {
		return mapper.getListWithPaging(cri, bno);
	}

	@Override
	public int getCountByBno(long bno) {
		return mapper.getCountByBno(bno);
	}
	
	@Transactional
	@Override
	public int setInsert(ReplyDTO dto) {
		boardMapper.updateReplyCnt(dto.getBno(), 1);
		return mapper.insert(dto);
	}

	@Override
	public ReplyDTO get(long rno) {
		return mapper.get(rno);
	}

	@Override
	public int modify(ReplyDTO dto) {
		return mapper.update(dto);
	}
	
	@Transactional
	@Override
	public int delete(long rno) {
		ReplyDTO dto = mapper.get(rno);
		boardMapper.updateReplyCnt(dto.getBno(), -1);
		return mapper.delete(rno);
	}

}

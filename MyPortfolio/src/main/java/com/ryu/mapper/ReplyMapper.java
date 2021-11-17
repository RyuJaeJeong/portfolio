package com.ryu.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;


import com.ryu.common.Criteria;
import com.ryu.dto.ReplyDTO;

public interface ReplyMapper {
	
	public int insert(ReplyDTO dto);
	
	public List<ReplyDTO> getListWithPaging(@Param("cri") Criteria cri, @Param("bno") long bno);
	
	public ReplyDTO get(long no);
	
	public int getCountByBno(long board_no);
	
	public int delete (long no);
	
	public int update(ReplyDTO dto);
	
	
	
	

}

package com.ryu.mapper;
import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ryu.common.Criteria;
import com.ryu.dto.AuthDTO;
import com.ryu.dto.MemberDTO;

public interface MemberMapper {
	
	
	
	public void setInsertMember(MemberDTO dto);
	
	public void setInsertAuth(AuthDTO dto);
	
	public List<MemberDTO> getList(Criteria cri);
	
	public int getTotalCount(Criteria cri);
	
	public MemberDTO read(String userid);
	
	public int setDelete(String userid);
	
	public int setUpdateMember(MemberDTO dto);
	
	public int setUpdateAuth(AuthDTO dto);
	
	public int checkId(String userId);
	
	
	public void updatestatistics(@Param("mno") long mno, @Param("regidate") Date regidate);
}

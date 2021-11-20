package com.ryu.service;

import java.util.List;

import com.ryu.common.Criteria;
import com.ryu.dto.MemberDTO;

public interface MemberService {
	
	public List<MemberDTO> getList(Criteria cri);
	
	public void setInsert(MemberDTO dto);
	
	public MemberDTO getRead(String userid);
	
	public boolean setUpdate(MemberDTO dto);
	
	public boolean setDelete(String userid);
	
	public int getTotalCount(Criteria cri);
	
	public int checkId(String userId);
}

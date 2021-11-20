package com.ryu.service;

import java.util.List;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ryu.common.Criteria;
import com.ryu.dto.AuthDTO;
import com.ryu.dto.MemberDTO;
import com.ryu.mapper.MemberMapper;
import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class MemberServiceImpl implements MemberService {

	private MemberMapper mapper;
	
	@Override
	public List<MemberDTO> getList(Criteria cri) {
		return mapper.getList(cri);
	}
	
	@Transactional
	@Override
	public void setInsert(MemberDTO dto) {
	   BCryptPasswordEncoder scpwd = new BCryptPasswordEncoder();
	   String password = scpwd.encode(dto.getUserpw());	        
	   dto.setUserpw(password);
	   AuthDTO auth = dto.getAuthList().get(0);
	   mapper.setInsertMember(dto);
	   mapper.setInsertAuth(auth);
	}

	@Override
	public MemberDTO getRead(String userid) {
		return mapper.read(userid);
	}
	
	@Transactional
	@Override
	public boolean setUpdate(MemberDTO dto) {
		
		 BCryptPasswordEncoder scpwd = new BCryptPasswordEncoder();
	     String password = scpwd.encode(dto.getUserpw());	        
	     dto.setUserpw(password);
		 AuthDTO auth = dto.getAuthList().get(0);
		 mapper.setUpdateAuth(auth);
		 return mapper.setUpdateMember(dto) == 1;
	}

	@Override
	public boolean setDelete(String userid) {
		return mapper.setDelete(userid) == 1;
	}

	@Override
	public int getTotalCount(Criteria cri) {
		return mapper.getTotalCount(cri);
	}

	@Override
	public int checkId(String userId) {
		return mapper.checkId(userId);
	}

}

package com.ryu.service;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
	
	@Transactional
	@Override
	public void setInsert(BoardDTO dto) {
		mapper.setInsert(dto);
		long no = dto.getBno();
		
		Calendar cal = Calendar.getInstance();
		
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH) + 1;
		int day = cal.get(Calendar.DAY_OF_MONTH);
		
		String temp = year+"/"+month+"/"+day;
		
		Date regidate = null;
		try {
			SimpleDateFormat transFormat = new SimpleDateFormat("yyyy/MM/dd");
			regidate = transFormat.parse(temp);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		mapper.updatestatistics(no, regidate);
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

package com.ryu.service;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ryu.common.Criteria;
import com.ryu.dto.GalleryDTO;
import com.ryu.mapper.BoardMapper;
import com.ryu.mapper.GalleryMapper;

import lombok.Setter;

@Service
public class GalleryServiceImpl implements GalleryService {

	@Setter(onMethod_ =  @Autowired)
	private GalleryMapper mapper;
	
	@Transactional
	@Override
	public void setInsert(GalleryDTO dto) {
		mapper.setInsert(dto);
		long no = dto.getGno();
		System.out.println("no : " + no);
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
	public List<GalleryDTO> getListWithPaging(Criteria cri) {
		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotalCount(Criteria cri) {
		return mapper.getTotalCount(cri);
	}

	@Override
	public GalleryDTO getRead(long gno) {
		return mapper.getRead(gno);
	}

	@Override
	public boolean setUpdate(GalleryDTO dto) {
		return mapper.setUpdate(dto) == 1;
	}

	@Override
	public boolean setDelete(long gno) {
		return mapper.setDelete(gno) == 1;
	}

}

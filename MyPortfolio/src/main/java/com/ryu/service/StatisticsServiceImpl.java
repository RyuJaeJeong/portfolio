package com.ryu.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ryu.dto.StatisticsDTO;
import com.ryu.mapper.StatisticsMapper;
import lombok.Setter;

@Service
public class StatisticsServiceImpl implements StatisticsService {

	@Setter(onMethod_ =  @Autowired)
	private StatisticsMapper mapper;
	
	@Override
	public List<StatisticsDTO> getList() {
		return mapper.getList();
	}
	
}

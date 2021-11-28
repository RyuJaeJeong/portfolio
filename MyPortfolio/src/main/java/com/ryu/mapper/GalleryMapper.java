package com.ryu.mapper;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ryu.common.Criteria;
import com.ryu.dto.GalleryDTO;

public interface GalleryMapper {
	
	public void setInsert(GalleryDTO dto);
	
	public List<GalleryDTO> getListWithPaging(Criteria cri);
	
	public GalleryDTO getRead(long gno);
	
	public int getTotalCount(Criteria cri);
	
	public int setDelete(long gno);
	
	public int setUpdate(GalleryDTO dto);
	
	
	public void updatestatistics(@Param("gno") long gno, @Param("regidate") Date regidate);
	
}

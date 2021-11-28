package com.ryu.service;

import java.util.List;
import com.ryu.common.Criteria;
import com.ryu.dto.GalleryDTO;

public interface GalleryService {
	public void setInsert(GalleryDTO dto); 
	public List<GalleryDTO> getListWithPaging(Criteria cri);
	public int getTotalCount(Criteria cri);
	public GalleryDTO getRead(long gno);
	public boolean setUpdate(GalleryDTO dto);
	public boolean setDelete(long gno);
}

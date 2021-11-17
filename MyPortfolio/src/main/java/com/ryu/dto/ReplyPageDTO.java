package com.ryu.dto;

import java.util.List;

import com.ryu.common.PageDTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@AllArgsConstructor
@Getter
public class ReplyPageDTO {
	private PageDTO dto;
	private List<ReplyDTO> list;
}

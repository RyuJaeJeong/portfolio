package com.ryu.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;


import com.ryu.dto.BoardDTO;
import com.ryu.dto.ReplyDTO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class MapperTests {
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	/*@Test
	public void testInsert() {
		BoardDTO dto = new BoardDTO();
		
		for (int i = 1; i < 101; i++) {
			log.info("test" + i);
			dto.setTitle("test title " + i);
			dto.setWriter("test writer " + i);
			dto.setContent("test content " + i);
			
			mapper.setInsert(dto);
		}
	}*/
	
	@Test
	public void insertReply() {
		ReplyDTO dto = new ReplyDTO();
		for (int i = 1; i < 101; i++) {
			if(i<10) {
				dto.setBoard_no(101);
			}else if(i<20){
				dto.setBoard_no(102);
			}else if(i<30){
				dto.setBoard_no(103);
			}else if(i<40){
				dto.setBoard_no(104);
			}else if(i<50){
				dto.setBoard_no(105);
			}else if(i<60){
				dto.setBoard_no(106);
			}else if(i<70){
				dto.setBoard_no(107);
			}else if(i<80){
				dto.setBoard_no(108);
			}else if(i<90){
				dto.setBoard_no(109);
			}else if(i<101){
				dto.setBoard_no(110);
			}
			
			dto.setReply("테스트 댓글" + i);
			dto.setReplyer("테스터" + i);
			
			mapper.insert(dto);
			
		}
	}
	
	
}

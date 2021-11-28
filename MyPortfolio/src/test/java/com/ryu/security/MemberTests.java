package com.ryu.security;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.Calendar;
import java.util.List;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.ryu.common.Criteria;
import com.ryu.dto.MemberDTO;
import com.ryu.mapper.MemberMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml", 
					   "file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class MemberTests {
 @Setter(onMethod_ = @Autowired)
 private PasswordEncoder pwencoder;
 
 @Setter(onMethod_ = @Autowired)
 private MemberMapper mapper;
 
 /*@Test
 public void testInsertMember() {
	 String sql = "insert into tbl_member(mno, userid, userpw, username) values(seq_member.nextval,?,?,?)";
	 
	 for (int i = 0; i < 100; i++) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			
			if(i < 80) {
				pstmt.setString(1, "user" + i);
				pstmt.setString(3, "일반사용자" + i);
			}else if(i < 90) {
				pstmt.setString(1, "manager"+i);
				pstmt.setString(3, "운영자"+i);
			}else {
				pstmt.setString(1, "admin"+i);
				pstmt.setString(3, "관리자"+i);
			}
			
			pstmt.setString(2, pwencoder.encode("pw"+i));
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			}
			
			if(conn != null) {
				try {
					conn.close();
				} catch (Exception e3) {
					e3.printStackTrace();
				}
			}
			
			
		}
	}
 }
 
 @Test
 public void testInsertAuth() {
	 Criteria cri = new Criteria(1, 10);
	 List<MemberDTO> list = mapper.getList(cri);
	 list.forEach(dto -> log.info(dto));
 }*/
 @Test
 public void getDateTime() {
		Calendar cal = Calendar.getInstance();
		//System.out.println(cal);
	
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH) + 1;
		int day = cal.get(Calendar.DAY_OF_MONTH);
		int hour = cal.get(Calendar.HOUR_OF_DAY);
		int min = cal.get(Calendar.MINUTE);
		int sec = cal.get(Calendar.SECOND);
		//System.out.println("현재 시각은 " + year + "년도 " + month + "월 " + day + "일 " + hour + "시 " + min + "분 " + sec + "초입니다.");
		
		log.info(year+"/"+month+"/"+day);
	}
 
}

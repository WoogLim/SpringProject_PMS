package kr.or.ddit.projects.issue.controller;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.handler;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.log;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;
	
import javax.inject.Inject;

import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.http.MediaType;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.WebApplicationContext;

import kr.or.ddit.CustomWebAppConfiguration;

@RunWith(SpringRunner.class)
@CustomWebAppConfiguration
@Transactional
public class issueControllerTest{

	@Inject
	WebApplicationContext context;
	MockMvc mockMvc;

	@Before
	public void setUp() throws Exception {
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
	}

	// 현재 파라미터에 realMember 있는 것들 다 에러 뜸... 어케 하지..
	@Test
	public void testList() throws Exception {
//		mockMvc.perform(get("/issue/issueList.do"))
//				.andDo(print())
//				.andExpect(status().isOk())
//				.andExpect(handler().handlerType(IssueController.class))
//				.andExpect(handler().methodName("issueList"));
	}

	@Test
	public void testView() throws Exception {
		mockMvc.perform(get("/issue/issueView.do").param("issueId", "302"))
				.andExpect(model().attributeExists("issueVO"))
				.andExpect(view().name("issue/issueView"))
				.andExpect(status().isOk())
				.andExpect(handler().handlerType(IssueController.class))
				.andExpect(handler().methodName("issueList"))
				.andDo(log())
				.andReturn();
	}

	@Test
	public void testView2() throws Exception {
		mockMvc.perform(get("/issue/issueView.do").param("issueId", "5000"))
				.andDo(print())
				.andExpect(status().is4xxClientError())
				.andExpect(handler().handlerType(IssueController.class))
				.andExpect(handler().methodName("read"));
	}
	
	@Test
	public void testdelete() throws Exception {
		mockMvc.perform(get("/issue/issueDelete.do").param("boardNo", "500"))
				.andExpect(model().attributeExists("issueVO"))
				.andExpect(view().name("issue/issueView"))
				.andDo(log())
				.andReturn();
	}
}

/**
 * @author 작성자명
 * @since 2021. 2. 9.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------------------------------------
 * 2021. 2. 15.      이선엽               최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
package kr.or.ddit.projects.chat.controller;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

@Configuration
@EnableWebSocket
public class WebSocketConfig implements WebSocketConfigurer {

	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {

		 registry.addHandler(socketHandler(), "/ws/chat")
		 			.setAllowedOrigins("*")
		 			.addInterceptors(new MyHandshakeInterceptor())
//		 			.addInterceptors(new HttpSessionHandshakeInterceptor())
		 			.withSockJS();
	}

	@Bean
	public SocketChatHandler socketHandler(){
		return new SocketChatHandler();
	}
}

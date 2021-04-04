package kr.or.ddit;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.ContextHierarchy;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.transaction.annotation.Transactional;

@ContextHierarchy({
   @ContextConfiguration("file:src/main/resources/kr/or/ddit/spring/context-*.xml"),
   @ContextConfiguration("file:webapp/WEB-INF/spring/appServlet/*-context.xml")
})
@WebAppConfiguration
@Transactional
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
public @interface CustomWebAppConfiguration {

}
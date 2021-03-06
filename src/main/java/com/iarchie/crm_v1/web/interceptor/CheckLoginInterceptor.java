package com.iarchie.crm_v1.web.interceptor;

import com.iarchie.crm_v1.context.UserContext;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 类描述信息 登入拦截器
 *
 * @author georgedage
 * @ClassName CheckLoginInterceptor
 * @Description: TODO
 * @date 2020/02/12 15:59
 * @Viersion V1.0.1
 */
public class CheckLoginInterceptor extends HandlerInterceptorAdapter {

    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        //判断用户是否登入
        if (UserContext.getCurrentUser() == null) {
            response.sendRedirect("login.jsp");
            System.out.println("CheckLoginInterceptor.preHandle" + "----------------未登入------拦截请求--------------->");
            return false;
        }
        return true;
    }
}

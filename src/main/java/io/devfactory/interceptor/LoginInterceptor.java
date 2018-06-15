package io.devfactory.interceptor;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginInterceptor extends HandlerInterceptorAdapter {

    private static final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);
    private static final String LOGIN = "login";

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

        HttpSession session = request.getSession();

        ModelMap modelMap = modelAndView.getModelMap();
        Object userVO = modelMap.get("userVO");

        if (userVO != null) {

            logger.info("new login success");

            session.setAttribute(LOGIN, userVO);

            if (request.getParameter("useCookie") != null) {

                logger.info("remember me................");

                Cookie loginCookie = new Cookie("loginCookie", session.getId());

                loginCookie.setPath("/");
                loginCookie.setMaxAge(60 * 60 * 24 * 7); // 일주일

                response.addCookie(loginCookie);
            }

            // response.sendRedirect("/");
            Object dest = session.getAttribute("dest");
            response.sendRedirect(dest != null ? (String) dest : "/");
        }
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        HttpSession session = request.getSession();

        if (session.getAttribute(LOGIN) != null) {
            logger.info("clear login data before");
            session.removeAttribute(LOGIN);
        }

        return true;
    }
}

package io.devfactory.controller;

import io.devfactory.domain.LoginDTO;
import io.devfactory.domain.UserVO;
import io.devfactory.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.util.WebUtils;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Date;

@RequestMapping("/user")
@Controller
public class UserController {

    private static final Logger logger = LoggerFactory.getLogger(UserController.class);

    private final UserService userService;

    @Inject
    public UserController(UserService userService) {
        this.userService = userService;
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public void loginGET(@ModelAttribute("dto") LoginDTO dto) { }


    @RequestMapping(value = "/loginPost", method = RequestMethod.POST)
    public void loginPOST(LoginDTO dto, HttpSession session, Model model) {

        try {

            UserVO vo = userService.login(dto);

            if (vo == null) {
                return;
            }

            model.addAttribute("userVO", vo);

            if (dto.isUseCookie()) {

                int amount = 60 * 60 * 24 * 7;
                Date sessionLimit = new Date(System.currentTimeMillis() + (1000 * amount));

                userService.keepLogin(vo.getUid(), session.getId(), sessionLimit);
            }

        } catch (Exception e) {
            logger.error("/login error : {}", dto, e);
        }
    }

    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public void logout(HttpServletRequest request, HttpServletResponse response, HttpSession session) {

        Object obj = session.getAttribute("login");

        try {

            if (obj != null) {

                UserVO vo = (UserVO) obj;

                session.removeAttribute("login");
                session.invalidate();

                Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");

                if (loginCookie != null) {

                    loginCookie.setPath("/");
                    loginCookie.setMaxAge(0);

                    response.addCookie(loginCookie);

                    userService.keepLogin(vo.getUid(), session.getId(), new Date());
                }
            }
        } catch (Exception e) {
            logger.error("/login error : {}", obj, e);
        }
    }
}

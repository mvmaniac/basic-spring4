package io.devfactory.controller;

import io.devfactory.domain.BoardVO;
import io.devfactory.service.BoardService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.inject.Inject;

@Controller
@RequestMapping("/board/*")
public class BoardController {

    private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

    private final BoardService boardService;

    @Inject
    public BoardController(BoardService boardService) {
        this.boardService = boardService;
    }


    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public void register(BoardVO vo, Model model) throws Exception {
        logger.info("register....");
    }

    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public String registerp(BoardVO vo, Model model) throws Exception {

        logger.info("register call...");

        boardService.insert(vo);
        model.addAttribute("result", "success");

        return "/board/success";
    }
}

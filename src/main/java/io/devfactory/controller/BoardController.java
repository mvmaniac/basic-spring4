package io.devfactory.controller;

import io.devfactory.domain.BoardVO;
import io.devfactory.service.BoardService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
    public void registerGet(BoardVO vo, Model model) throws Exception {
        logger.info("register get....");
    }

    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public String registerPost(BoardVO vo, RedirectAttributes rttr) throws Exception {

        logger.info("register post...");
        logger.info("board : {}", vo);

        boardService.insert(vo);

        rttr.addFlashAttribute("result", "success");
        return "redirect:/board/listAll";
    }

    @RequestMapping(value = "/listAll", method = RequestMethod.GET)
    public void listAll(Model model) throws Exception {

        logger.info("show list all...");
    }
}

package io.devfactory.controller;

import io.devfactory.domain.BoardVO;
import io.devfactory.service.BoardService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.inject.Inject;
import java.util.ArrayList;
import java.util.List;

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
    public void registerGet() {
        logger.debug("/board/register get....");
    }

    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public String registerPost(BoardVO vo, RedirectAttributes rttr) {

        logger.debug("/board/register post...");
        logger.debug("board = {}", vo);

        String msg;

        try {
            boardService.insert(vo);
            msg = "success";

        } catch (Exception e) {
            logger.error("/board/register error ", e);
            msg = "fail";
        }

        rttr.addFlashAttribute("result", msg);
        return "redirect:/board/listAll";
    }

    @RequestMapping(value = "/modify", method = RequestMethod.GET)
    public String modifyGet(@RequestParam("bno") int bno, Model model) {

        logger.debug("/board/modify get");
        logger.debug("bno = {}", bno);

        BoardVO vo = new BoardVO();

        try {
            vo = boardService.selectByBoard(bno);
        } catch (Exception e) {
            logger.error("/board/modify error => ", e);
        }

        model.addAttribute(vo);
        return "board/modify";
    }

    @RequestMapping(value = "/modify", method = RequestMethod.POST)
    public String modifyPost(BoardVO vo, RedirectAttributes rttr) {

        logger.debug("/board/modify post...");
        logger.debug("board = {}", vo);

        String msg;

        try {
            boardService.update(vo);
            msg = "success";

        } catch (Exception e) {
            logger.error("/board/modify error ", e);
            msg = "fail";
        }

        rttr.addFlashAttribute("result", msg);
        return "redirect:/board/listAll";
    }

    @RequestMapping(value = "/remove", method = RequestMethod.POST)
    public String remove(@RequestParam("bno") int bno, RedirectAttributes rttr) {

        logger.debug("/board/remove");
        logger.debug("bno = {}", bno);

        String msg;

        try {
            boardService.delete(bno);
            msg = "success";

        } catch (Exception e) {
            logger.error("/board/remove error ", e);
            msg = "fail";
        }

        rttr.addFlashAttribute("result", msg);
        return "redirect:/board/listAll";
    }

    @RequestMapping(value = "/listAll", method = RequestMethod.GET)
    public String listAll(Model model) {

        logger.debug("/board/listAll...");

        List<BoardVO> list = new ArrayList<>();

        try {
            list = boardService.selectAll();
        } catch (Exception e) {
            logger.error("/board/listAll error ", e);
        }

        model.addAttribute("list", list);
        return "board/listAll";
    }

    @RequestMapping(value = "/read", method = RequestMethod.GET)
    public String read(@RequestParam("bno") int bno, Model model) {

        logger.debug("/board/read");
        logger.debug("bno = {}", bno);

        BoardVO vo = new BoardVO();

        try {
            vo = boardService.selectByBoard(bno);
        } catch (Exception e) {
            logger.error("/board/read error => ", e);
        }

        model.addAttribute(vo);
        return "board/read";
    }
}

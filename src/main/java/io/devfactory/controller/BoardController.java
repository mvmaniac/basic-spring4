package io.devfactory.controller;

import io.devfactory.common.paging.PagingHelper;
import io.devfactory.common.paging.SearchCriteria;
import io.devfactory.domain.BoardVO;
import io.devfactory.service.BoardService;
import io.devfactory.util.MediaUtils;
import io.devfactory.util.UploadFileUtils;
import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import javax.inject.Inject;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Controller
@RequestMapping("/board/*")
public class BoardController {

    private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

    private final BoardService boardService;

    @Resource(name = "uploadPath")
    private String uploadPath;

    @Inject
    public BoardController(BoardService boardService) {
        this.boardService = boardService;
    }

    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public void registerGet(@ModelAttribute("cri") SearchCriteria cri) {
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
    public String modifyGet(@RequestParam("bno") int bno, @ModelAttribute("cri") SearchCriteria cri, Model model) {

        logger.debug("/board/modify get");
        logger.debug("bno = {}", bno);
        logger.debug("cri = {}", cri);

        BoardVO vo = new BoardVO();

        try {
            vo = boardService.selectByBoard(bno);

            // vo가 null 인 경우는 redirect 시킴
            if (vo == null) {
                return "redirect:/board/listAll";
            }
        } catch (Exception e) {
            logger.error("/board/modify error => ", e);
        }

        model.addAttribute(vo);
        return "board/modify";
    }

    @RequestMapping(value = "/modify", method = RequestMethod.POST)
    public String modifyPost(BoardVO vo, SearchCriteria cri, RedirectAttributes rttr) {

        logger.debug("/board/modify post...");
        logger.debug("board = {}", vo);
        logger.debug("cri = {}", cri);

        String msg;

        try {
            boardService.update(vo);
            msg = "success";

        } catch (Exception e) {
            logger.error("/board/modify error ", e);
            msg = "fail";
        }

        rttr.addAttribute("page", cri.getPage());
        rttr.addAttribute("perPageNum", cri.getPerPageNum());
        rttr.addAttribute("searchType", cri.getSearchType());
        rttr.addAttribute("keyword", cri.getKeyword());

        rttr.addFlashAttribute("result", msg);
        return "redirect:/board/listAll";
    }

    @RequestMapping(value = "/remove", method = RequestMethod.POST)
    public String remove(@RequestParam("bno") int bno, SearchCriteria cri, RedirectAttributes rttr) {

        logger.debug("/board/remove");
        logger.debug("bno = {}", bno);
        logger.debug("cri = {}", cri);

        String msg;

        try {
            boardService.delete(bno);
            msg = "success";

        } catch (Exception e) {
            logger.error("/board/remove error ", e);
            msg = "fail";
        }

        rttr.addAttribute("page", cri.getPage());
        rttr.addAttribute("perPageNum", cri.getPerPageNum());
        rttr.addAttribute("searchType", cri.getSearchType());
        rttr.addAttribute("keyword", cri.getKeyword());

        rttr.addFlashAttribute("result", msg);

        return "redirect:/board/listAll";
    }

    @RequestMapping(value = "/listAll", method = RequestMethod.GET)
    public String listAll(SearchCriteria cri, Model model) {

        logger.debug("/board/listAll...");
        logger.debug("cri = {}", cri);

        List<BoardVO> list = new ArrayList<>();

        try {
            list = boardService.selectBySearch(cri);

            int totalCount = boardService.totalCountBySearch(cri);
            int page = cri.getPage();

            // 요청 페이지가 1이 아니고 전체 목록 수가 0이 아니면서 리스트 목록이 없다면 한번더 검색함
            if (page != 1 && totalCount != 0 && list.isEmpty()) {

                cri.setPage(page - 1);

                list = boardService.selectBySearch(cri);
                totalCount = boardService.totalCountBySearch(cri);
            }

            model.addAttribute("paging", PagingHelper.getPagingInfo(totalCount, cri, 5));

        } catch (Exception e) {
            logger.error("/board/listAll error ", e);
        }

        model.addAttribute("list", list);
        return "board/listAll";
    }

    @RequestMapping(value = "/read", method = RequestMethod.GET)
    public String read(@RequestParam("bno") int bno, @ModelAttribute("cri") SearchCriteria cri, Model model) {

        logger.debug("/board/read");
        logger.debug("bno = {}", bno);
        logger.debug("cri = {}", cri);

        BoardVO vo = new BoardVO();

        try {
            vo = boardService.selectByBoard(bno);

            // vo가 null 인 경우는 redirect 시킴
            if (vo == null) {
                return "redirect:/board/listAll";
            }
        } catch (Exception e) {
            logger.error("/board/read error => ", e);
        }

        model.addAttribute(vo);
        return "board/read";
    }

    @ResponseBody
    @RequestMapping(value = "/getAttach/{bno}")
    public List<String> getAttach(@PathVariable("bno") int bno) {

        logger.debug("/getAttach/{}", bno);

        List<String> attachList = new ArrayList<>();

        try {
            attachList = boardService.selectByAttach(bno);

        } catch (Exception e) {
            logger.error("/board/getAttach/{} error => ", bno, e);
        }

        return attachList;
    }

    @ResponseBody
    @RequestMapping(value ="/uploadAjax", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
    public ResponseEntity<String> uploadAjax(MultipartFile file) throws Exception {

        logger.info("originalName: " + file.getOriginalFilename());
        logger.info("size: " + file.getSize());
        logger.info("contentType: " + file.getContentType());

        return new ResponseEntity<>(UploadFileUtils.uploadFile(uploadPath, file.getOriginalFilename(), file.getBytes()), HttpStatus.CREATED);
    }

    @ResponseBody
    @RequestMapping("/displayFile")
    public ResponseEntity<byte[]> displayFile(String fileName) throws Exception {

        InputStream in = null;
        ResponseEntity<byte[]> entity;

        logger.info("FILE NAME: " + fileName);

        try {
            String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);

            MediaType mType = MediaUtils.getMediaType(formatName);

            HttpHeaders headers = new HttpHeaders();

            in = new FileInputStream(uploadPath + fileName);

            if (mType != null) {
                headers.setContentType(mType);

            } else {
                fileName = fileName.substring(fileName.indexOf("_") + 1);

                headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
                headers.add("Content-Disposition", "attachment; filename=\"" + new String(fileName.getBytes("UTF-8"), "ISO-8859-1") + "\"");
            }

            entity = new ResponseEntity<>(IOUtils.toByteArray(in), headers, HttpStatus.CREATED);

        } catch (Exception e) {
            logger.error("", e);
            entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);

        } finally {
            if (in != null) { in.close(); }
        }

        return entity;
    }

    @ResponseBody
    @RequestMapping(value = "/deleteFile", method = RequestMethod.POST)
    public ResponseEntity<String> deleteFile(String fileName) {

        logger.info("delete file: " + fileName);

        String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);
        MediaType mType = MediaUtils.getMediaType(formatName);

        if (mType != null) {
            String front = fileName.substring(0, 12);
            String end = fileName.substring(14);

            new File(uploadPath + (front + end).replace('/', File.separatorChar)).delete();
        }

        new File(uploadPath + fileName.replace('/', File.separatorChar)).delete();
        return new ResponseEntity<>("deleted", HttpStatus.OK);
    }

    @ResponseBody
    @RequestMapping(value = "/deleteAllFiles", method = RequestMethod.POST)
    public ResponseEntity<String> deleteFile(@RequestParam("files[]") String[] files) {

        logger.info("delete all files: {}", Arrays.toString(files));

        if (files == null || files.length == 0) {
            return new ResponseEntity<>("deleted", HttpStatus.OK);
        }

        for (String fileName : files) {

            String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);
            MediaType mType = MediaUtils.getMediaType(formatName);

            if (mType != null) {
                String front = fileName.substring(0, 12);
                String end = fileName.substring(14);

                new File(uploadPath + (front + end).replace('/', File.separatorChar)).delete();
            }

            new File(uploadPath + fileName.replace('/', File.separatorChar)).delete();
        }

        return new ResponseEntity<>("deleted", HttpStatus.OK);
    }
}

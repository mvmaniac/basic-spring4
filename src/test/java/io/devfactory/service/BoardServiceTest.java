package io.devfactory.service;

import io.devfactory.domain.BoardVO;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import javax.inject.Inject;
import java.util.List;

@SuppressWarnings({"SpringJavaInjectionPointsAutowiringInspection", "Duplicates"})
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"file:**/spring/**/*.xml"})
public class BoardServiceTest {

    @Inject
    private BoardService boardService;

    @Test
    public void insert() throws Exception {

        BoardVO board = new BoardVO();
        board.setTitle("1");
        board.setContent(null);
        board.setWriter("user00");

        boardService.insert(board);
    }

    @Test
    public void update() throws Exception {

        BoardVO board = new BoardVO();
        board.setTitle("수정 글 제목");
        board.setContent("수정 글 내용");
        board.setBno(1);

        boardService.update(board);
    }

    @Test
    public void delete() throws Exception {

        boardService.delete(1);
    }

    @Test
    public void select() throws Exception {

        List<BoardVO> selectList = boardService.selectAll();
        Assert.assertTrue(selectList.isEmpty());

        BoardVO selectBoardVO = boardService.selectByBoard(1);
        Assert.assertNull(selectBoardVO);
    }
}

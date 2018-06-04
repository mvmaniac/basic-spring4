package io.devfactory.persistence;

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
public class BoardMapperTest {

    @Inject
    private BoardMapper boardMapper;

    @Test
    public void insert() {

        BoardVO board = new BoardVO();
        board.setTitle("1");
        board.setContent(null);
        board.setWriter("user00");

        boardMapper.insert(board);
    }

    @Test
    public void update() {

        BoardVO board = new BoardVO();
        board.setTitle("수정 글 제목");
        board.setContent("수정 글 내용");
        board.setBno(1);

        boardMapper.update(board);
    }

    @Test
    public void delete() {

        boardMapper.delete(1);
    }

    @Test
    public void select() {

        List<BoardVO> selectList = boardMapper.selectAll();
        Assert.assertTrue(selectList.isEmpty());

        BoardVO selectBoardVO = boardMapper.selectByBoard(1);
        Assert.assertNull(selectBoardVO);
    }
}

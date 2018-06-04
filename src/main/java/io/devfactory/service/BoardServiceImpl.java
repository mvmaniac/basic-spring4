package io.devfactory.service;

import io.devfactory.domain.BoardVO;
import io.devfactory.persistence.BoardMapper;
import org.springframework.stereotype.Service;

import javax.inject.Inject;
import java.util.List;

@SuppressWarnings("SpringJavaInjectionPointsAutowiringInspection")
@Service
public class BoardServiceImpl implements BoardService {

    private final BoardMapper boardMapper;

    @Inject
    public BoardServiceImpl(BoardMapper boardMapper) {
        this.boardMapper = boardMapper;
    }

    @Override
    public void insert(BoardVO vo) throws Exception {
        boardMapper.insert(vo);
    }

    @Override
    public void update(BoardVO vo) throws Exception {
        boardMapper.update(vo);
    }

    @Override
    public void delete(int bno) throws Exception {
        boardMapper.delete(bno);
    }

    @Override
    public List<BoardVO> selectAll() throws Exception {
        return boardMapper.selectAll();
    }

    @Override
    public BoardVO selectByBoard(int bno) throws Exception {
        return boardMapper.selectByBoard(bno);
    }
}

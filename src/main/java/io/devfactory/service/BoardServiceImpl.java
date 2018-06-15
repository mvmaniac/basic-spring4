package io.devfactory.service;

import io.devfactory.common.paging.Criteria;
import io.devfactory.common.paging.SearchCriteria;
import io.devfactory.domain.BoardVO;
import io.devfactory.persistence.BoardMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

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
    public int totalCount() throws Exception {
        return boardMapper.totalCount();
    }

    @Override
    public int totalCountBySearch(SearchCriteria cri) throws Exception {
        return boardMapper.totalCountBySearch(cri);
    }

    @Transactional
    @Override
    public void insert(BoardVO vo) throws Exception {
        boardMapper.insert(vo);

        String[] files = vo.getFiles();
        if (files == null) { return; }

        for (String fileName : files) {
            boardMapper.insertAttach(fileName);
        }
    }

    @Transactional
    @Override
    public void update(BoardVO vo) throws Exception {

        boardMapper.update(vo);

        int bno = vo.getBno();
        boardMapper.deleteAttach(bno);

        String[] files = vo.getFiles();
        if (files == null) { return; }

        for (String fileName : files) {
            boardMapper.insertAttachReplace(fileName, bno);
        }
    }

    @Override
    public void updateReplyCnt(int bno, int amount) throws Exception {
        boardMapper.updateReplyCnt(bno, amount);
    }

    @Transactional
    @Override
    public void delete(int bno) throws Exception {
        boardMapper.deleteAttach(bno);
        boardMapper.delete(bno);
    }

    @Override
    public List<BoardVO> selectAll() throws Exception {
        return boardMapper.selectAll();
    }

    @Override
    public List<BoardVO> selectByCriteria(Criteria cri) throws Exception {
        return boardMapper.selectByCriteria(cri);
    }

    @Override
    public List<BoardVO> selectBySearch(SearchCriteria cri) throws Exception {
        return boardMapper.selectBySearch(cri);
    }

    @Transactional(isolation = Isolation.READ_COMMITTED)
    @Override
    public BoardVO selectByBoard(int bno) throws Exception {
        boardMapper.updateViewCnt(bno);
        return boardMapper.selectByBoard(bno);
    }

    @Override
    public List<String> selectByAttach(int bno) throws Exception {
        return boardMapper.selectByAttach(bno);
    }
}


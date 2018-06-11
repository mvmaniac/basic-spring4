package io.devfactory.service;

import io.devfactory.common.paging.Criteria;
import io.devfactory.domain.ReplyVO;
import io.devfactory.persistence.BoardMapper;
import io.devfactory.persistence.ReplyMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.inject.Inject;
import java.util.List;

@SuppressWarnings("SpringJavaInjectionPointsAutowiringInspection")
@Service
public class ReplyServiceImpl implements ReplyService {

    private final ReplyMapper replyMapper;
    private final BoardMapper boardMapper;

    @Inject
    public ReplyServiceImpl(ReplyMapper replyMapper, BoardMapper boardMapper) {

        this.replyMapper = replyMapper;
        this.boardMapper = boardMapper;
    }

    @Override
    public int totalCount(int bno) throws Exception {
        return replyMapper.totalCount(bno);
    }

    @Override
    public int getBno(int rno) throws Exception {
        return replyMapper.getBno(rno);
    }

    @Transactional
    @Override
    public void insert(ReplyVO vo) throws Exception {
        replyMapper.insert(vo);
        boardMapper.updateReplyCnt(vo.getBno(), 1);
    }

    @Override
    public void update(ReplyVO vo) throws Exception {
        replyMapper.update(vo);
    }

    @Transactional
    @Override
    public void delete(int rno) throws Exception {

        int bno = replyMapper.getBno(rno);

        replyMapper.delete(rno);
        boardMapper.updateReplyCnt(bno, -1);
    }

    @Override
    public List<ReplyVO> selectAll(int bno) throws Exception {
        return replyMapper.selectAll(bno);
    }

    @Override
    public List<ReplyVO> selectByCriteria(int bno, Criteria cri) throws Exception {
        return replyMapper.selectByCriteria(bno, cri);
    }
}


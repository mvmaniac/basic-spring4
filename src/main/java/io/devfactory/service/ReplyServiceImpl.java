package io.devfactory.service;

import io.devfactory.common.paging.Criteria;
import io.devfactory.domain.ReplyVO;
import io.devfactory.persistence.ReplyMapper;
import org.springframework.stereotype.Service;

import javax.inject.Inject;
import java.util.List;

@SuppressWarnings("SpringJavaInjectionPointsAutowiringInspection")
@Service
public class ReplyServiceImpl implements ReplyService {

    private final ReplyMapper replyMapper;

    @Inject
    public ReplyServiceImpl(ReplyMapper replyMapper) {
        this.replyMapper = replyMapper;
    }

    @Override
    public int totalCount(int bno) throws Exception {
        return replyMapper.totalCount(bno);
    }

    @Override
    public void insert(ReplyVO vo) throws Exception {
        replyMapper.insert(vo);
    }

    @Override
    public void update(ReplyVO vo) throws Exception {
        replyMapper.update(vo);
    }

    @Override
    public void delete(int rno) throws Exception {
        replyMapper.delete(rno);
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


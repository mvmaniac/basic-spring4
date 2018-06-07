package io.devfactory.service;

import io.devfactory.common.paging.Criteria;
import io.devfactory.common.paging.SearchCriteria;
import io.devfactory.domain.BoardVO;
import io.devfactory.domain.ReplyVO;

import java.util.List;

public interface ReplyService {

    public int totalCount(int bno) throws Exception;

    public void insert(ReplyVO vo) throws Exception;

    public void update(ReplyVO vo) throws Exception;

    public void delete(int rno) throws Exception;

    public List<ReplyVO> selectAll(int bno) throws Exception;

    public List<ReplyVO> selectByCriteria(int bno, Criteria cri) throws Exception;
}

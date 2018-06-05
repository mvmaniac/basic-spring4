package io.devfactory.service;

import io.devfactory.common.paging.Criteria;
import io.devfactory.domain.BoardVO;

import java.util.List;

public interface BoardService {

    public int totalCount(Criteria cri) throws Exception;

    public void insert(BoardVO vo) throws Exception;

    public void update(BoardVO vo) throws Exception;

    public void delete(int bno) throws Exception;

    public List<BoardVO> selectAll() throws Exception;

    public List<BoardVO> selectByCriteria(Criteria cri) throws Exception;

    public BoardVO selectByBoard(int bno) throws Exception;
}

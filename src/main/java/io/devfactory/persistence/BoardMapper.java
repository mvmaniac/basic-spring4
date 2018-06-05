package io.devfactory.persistence;

import io.devfactory.common.paging.Criteria;
import io.devfactory.domain.BoardVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BoardMapper {

    public int totalCount(Criteria cri);

    public void insert(BoardVO vo);

    public void update(BoardVO vo);

    public void delete(int bno);

    public List<BoardVO> selectAll();

    public List<BoardVO> selectByCriteria(Criteria cri);

    public BoardVO selectByBoard(int bno);

}

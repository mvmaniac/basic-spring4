package io.devfactory.persistence;

import io.devfactory.common.paging.Criteria;
import io.devfactory.common.paging.SearchCriteria;
import io.devfactory.domain.BoardVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface BoardMapper {

    public int totalCount();

    public int totalCountBySearch(SearchCriteria cri);

    public void insert(BoardVO vo);

    public void insertAttach(String fullName);

    public void insertAttachReplace(String fullName, int bno);

    public void update(BoardVO vo);

    public void updateReplyCnt(@Param("bno") int bno, @Param("amount") int amount);

    public void updateViewCnt(int bno);

    public void delete(int bno);

    public void deleteAttach(int bno);

    public List<BoardVO> selectAll();

    public List<BoardVO> selectByCriteria(Criteria cri);

    public List<BoardVO> selectBySearch(SearchCriteria cri);

    public BoardVO selectByBoard(int bno);

    public List<String> selectByAttach(int bno);
}

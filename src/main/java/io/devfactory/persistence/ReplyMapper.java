package io.devfactory.persistence;

import io.devfactory.common.paging.Criteria;
import io.devfactory.domain.BoardVO;
import io.devfactory.domain.ReplyVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ReplyMapper {

    public int totalCount(int bno);

    public void insert(ReplyVO vo);

    public void update(ReplyVO vo);

    public void delete(int rno);

    public List<ReplyVO> selectAll(int bno);

    public List<ReplyVO> selectByCriteria(@Param("bno") int bno, @Param("cri") Criteria cri);
}

package io.devfactory.persistence;

import io.devfactory.domain.BoardVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BoardMapper {

    public void insert(BoardVO vo);

    public void update(BoardVO vo);

    public void delete(int bno);

    public List<BoardVO> selectAll();

    public BoardVO selectByBoard(int bno);
}

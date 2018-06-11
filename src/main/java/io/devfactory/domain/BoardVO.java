package io.devfactory.domain;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class BoardVO {

    private int bno;
    private String title;
    private String content;
    private String writer;
    private Date regdate;
    private int viewcnt;
    private int replycnt;

    @Override
    public String toString() {
        return "BoardVO{" +
                "bno=" + bno +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", writer='" + writer + '\'' +
                ", regdate=" + regdate +
                ", viewcnt=" + viewcnt +
                ", replycnt=" + replycnt +
                '}';
    }
}

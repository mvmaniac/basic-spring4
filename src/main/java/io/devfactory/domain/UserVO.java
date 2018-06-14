package io.devfactory.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserVO {

    private String uid;
    private String upw;
    private String uname;
    private int upoint;

    @Override
    public String toString() {
        return "UserVO{" +
                "uid='" + uid + '\'' +
                ", upw='" + upw + '\'' +
                ", uname='" + uname + '\'' +
                ", upoint=" + upoint +
                '}';
    }
}

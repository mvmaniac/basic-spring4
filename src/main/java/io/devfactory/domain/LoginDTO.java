package io.devfactory.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class LoginDTO {
	
	private String uid;
	private String upw;
	private boolean useCookie;

    @Override
    public String toString() {
        return "LoginDTO{" +
                "uid='" + uid + '\'' +
                ", upw='" + upw + '\'' +
                ", useCookie=" + useCookie +
                '}';
    }
}

package io.devfactory.persistence;

import io.devfactory.domain.LoginDTO;
import io.devfactory.domain.UserVO;
import org.apache.ibatis.annotations.Param;

import java.util.Date;

public interface UserMapper {

    public UserVO login(LoginDTO dto);

    public UserVO checkUserWithSessionKey(String value);

    public void keepLogin(@Param("uid") String uid, @Param("sessionId") String sessionId, @Param("next") Date next);
}

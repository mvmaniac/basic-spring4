package io.devfactory.service;

import io.devfactory.domain.LoginDTO;
import io.devfactory.domain.UserVO;
import org.apache.ibatis.annotations.Param;

import java.util.Date;

public interface UserService {

    public UserVO login(LoginDTO dto) throws Exception;

    public UserVO checkUserWithSessionKey(String value) throws Exception;

    public void keepLogin(@Param("uid") String uid, @Param("sessionId") String sessionId, @Param("next") Date next) throws Exception;
}

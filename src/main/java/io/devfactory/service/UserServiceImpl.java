package io.devfactory.service;

import io.devfactory.domain.LoginDTO;
import io.devfactory.domain.UserVO;
import io.devfactory.persistence.UserMapper;
import org.springframework.stereotype.Service;

import javax.inject.Inject;
import java.util.Date;

@SuppressWarnings("SpringJavaInjectionPointsAutowiringInspection")
@Service
public class UserServiceImpl implements UserService {

    private final UserMapper userMapper;

    @Inject
    public UserServiceImpl(UserMapper userMapper) {
        this.userMapper = userMapper;
    }

    @Override
    public UserVO login(LoginDTO dto) throws Exception {
        return userMapper.login(dto);
    }

    @Override
    public UserVO checkUserWithSessionKey(String value) throws Exception {
        return userMapper.checkUserWithSessionKey(value);
    }

    @Override
    public void keepLogin(String uid, String sessionId, Date next) throws Exception {
        userMapper.keepLogin(uid, sessionId, next);
    }
}

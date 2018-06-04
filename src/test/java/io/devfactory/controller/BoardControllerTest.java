package io.devfactory.controller;

import io.devfactory.service.BoardService;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import javax.inject.Inject;

@SuppressWarnings({"SpringJavaInjectionPointsAutowiringInspection"})
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"file:**/spring/**/*.xml"})
public class BoardControllerTest {

    @Inject
    private BoardService boardService;
}

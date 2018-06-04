package io.devfactory;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.inject.Inject;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:**/root-context.xml"})
public class MyBatisTest {

    private static final Logger logger = LoggerFactory.getLogger(MyBatisTest.class);

    @Inject
    private SqlSessionFactory sqlSessionFactory;

    @Test
    public void testFactory() {
        logger.debug("{}", sqlSessionFactory);
    }

    @Test
    public void testSession() {

        try (SqlSession session = sqlSessionFactory.openSession()) {
            logger.debug("{}", session);

        } catch (Exception e) {
            logger.error("{}", e);
        }
    }
}

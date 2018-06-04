package io.devfactory;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.inject.Inject;
import javax.sql.DataSource;
import java.sql.Connection;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:**/root-context.xml"})
public class DataSourceTest {

    private static final Logger logger = LoggerFactory.getLogger(DataSourceTest.class);

    @Inject
    private DataSource dataSource;

    @Test
    public void testConnection() throws Exception {

        try (Connection con = dataSource.getConnection()) {
            logger.debug("{}", con);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

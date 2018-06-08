package io.devfactory.controller;

import io.devfactory.common.paging.Criteria;
import io.devfactory.common.paging.PagingHelper;
import io.devfactory.domain.ReplyVO;
import io.devfactory.service.ReplyService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.inject.Inject;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/replies")
public class ReplyController {
	
	private static final Logger logger = LoggerFactory.getLogger(ReplyController.class);

	private final ReplyService replyService;

	@Inject
	public ReplyController(ReplyService replyService) {
		this.replyService = replyService;
	}

	@PostMapping("")
	public ResponseEntity<String> register(@RequestBody ReplyVO vo) {

		ResponseEntity<String> entity;

		try {
			replyService.insert(vo);
			entity = new ResponseEntity<>("success", HttpStatus.OK);

		} catch (Exception e) {
			logger.error("/replies register error", e);
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}

		return entity;
	}

	@RequestMapping(value = "/{rno}", method = { RequestMethod.PUT, RequestMethod.PATCH })
	public ResponseEntity<String> modify(@PathVariable("rno") int rno, @RequestBody ReplyVO vo) {

		ResponseEntity<String> entity;

		try {
			vo.setRno(rno);
			replyService.update(vo);

			entity = new ResponseEntity<>("success", HttpStatus.OK);

		} catch (Exception e) {
			logger.error("/replies/{} modify error", rno, e);
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}

		return entity;
	}

	@DeleteMapping("/{rno}")
	public ResponseEntity<String> remove(@PathVariable("rno") int rno) {

		ResponseEntity<String> entity;

		try {
			replyService.delete(rno);
			entity = new ResponseEntity<>("success", HttpStatus.OK);

		} catch (Exception e) {
			logger.error("/replies/{} remove error", rno, e);
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}

		return entity;
	}

	@GetMapping("/list/{bno}")
	public ResponseEntity<List<ReplyVO>> listAll(@PathVariable("bno") int bno) {

		ResponseEntity<List<ReplyVO>> entity;

		try {
			List<ReplyVO> list = replyService.selectAll(bno);
			entity = new ResponseEntity<>(list, HttpStatus.OK);

		} catch (Exception e) {
			logger.error("/replies/list/{} listAll error", bno, e);
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}

		return entity;
	}

	@GetMapping("/{bno}/{page}")
	public ResponseEntity<Map<String, Object>> listPage(@PathVariable("bno") int bno, @PathVariable("page") int page) {

		Map<String, Object> result = new HashMap<>();

		ResponseEntity<Map<String, Object>> entity;

		try {

			Criteria criteria = new Criteria();
			criteria.setPage(page);
			criteria.setPerPageNum(2);

			List<ReplyVO> list = replyService.selectByCriteria(bno, criteria);

			int totalCount = replyService.totalCount(bno);

			// 요청 페이지가 1이 아니고 전체 목록 수가 0이 아니면서 리스트 목록이 없다면 한번더 검색함
			if (page != 1 && totalCount != 0 && list.isEmpty()) {

				criteria.setPage(page - 1);

				list = replyService.selectByCriteria(bno, criteria);
				totalCount = replyService.totalCount(bno);

				logger.debug("research!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
			}

			result.put("list", list);
			result.put("paging", PagingHelper.getPagingInfo(totalCount, criteria, 2));

			entity = new ResponseEntity<>(result, HttpStatus.OK);

		} catch (Exception e) {
			logger.error("/replies/{}/{} error", bno, page, e);
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}

		return entity;
	}
}

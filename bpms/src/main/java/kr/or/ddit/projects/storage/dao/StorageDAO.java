package kr.or.ddit.projects.storage.dao;

import org.springframework.stereotype.Repository;

import kr.or.ddit.projects.storage.vo.StorageVO;

@Repository
public interface StorageDAO {
	StorageVO retrievProjectFiles(StorageVO storage);
}

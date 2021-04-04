package kr.or.ddit.projects.storage.service.impl;


import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.projects.storage.dao.StorageDAO;
import kr.or.ddit.projects.storage.service.StorageService;
import kr.or.ddit.projects.storage.vo.StorageVO;

@Service
public class StorageServiceImpl implements StorageService {

	@Inject
	private StorageDAO storageDAO;
	
	@Override
	public StorageVO retrievProjectFiles(StorageVO storage) {
		return storageDAO.retrievProjectFiles(storage);
	}
	
}

package hkmu.comps380f.service;

import hkmu.comps380f.dao.LectureRepository;
import hkmu.comps380f.model.Lecture;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;
import javax.annotation.Resource;

@Service
public class LectureService {

    @Resource
    private LectureRepository lectureRepo;

    @Transactional
    public List<Lecture> getLectures() {
        return lectureRepo.findAll();
    }

    public Lecture getLecture(long id) {
        return lectureRepo.findById(id).orElse(null);
    }


}

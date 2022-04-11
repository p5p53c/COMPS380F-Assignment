package hkmu.comps380f.service;

//import hkmu.comps380f.dao.AttachmentRepository;

import hkmu.comps380f.dao.CourseRepository;
import hkmu.comps380f.exception.CourseNotFound;
import hkmu.comps380f.model.Course;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.io.IOException;
import java.util.List;

@Service
public class CourseService {

    @Resource
    private CourseRepository courseRepo;

    @Transactional
    public List<Course> getCourses() {
        return courseRepo.findAll();
    }

    @Transactional
    public Course getCourse(long id) {
        return courseRepo.findById(id).orElse(null);
    }

    @Transactional
    public long createCourse(String title) {
        Course course = new Course();
        course.setCourseTitle(title);

        Course savedCourse = courseRepo.save(course);
        return savedCourse.getId();
    }

    @Transactional(rollbackFor = CourseNotFound.class)
    public void delete(long id) throws CourseNotFound {
        Course deletedTicket = courseRepo.findById(id).orElse(null);
        if (deletedTicket == null) {
            throw new CourseNotFound();
        }
        courseRepo.delete(deletedTicket);
    }
}

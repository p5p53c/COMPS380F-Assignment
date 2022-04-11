package hkmu.comps380f.dao;

import hkmu.comps380f.model.Course;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CourseRepository extends JpaRepository<Course, Long> {
}


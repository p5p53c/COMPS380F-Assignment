package hkmu.comps380f.dao;

import hkmu.comps380f.model.CourseUser;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CourseUserRepository extends JpaRepository<CourseUser, String> {
}

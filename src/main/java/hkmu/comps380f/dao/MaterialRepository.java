package hkmu.comps380f.dao;

import hkmu.comps380f.model.Material;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MaterialRepository extends JpaRepository<Material, Long> {
    //public Material findByLectureId(long lectureId);
}

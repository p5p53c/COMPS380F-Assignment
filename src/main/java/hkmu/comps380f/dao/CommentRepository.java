package hkmu.comps380f.dao;

import hkmu.comps380f.model.Material;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CommentRepository extends JpaRepository<Material, Long> {
}

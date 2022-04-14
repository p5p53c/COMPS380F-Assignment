package hkmu.comps380f.dao;

import hkmu.comps380f.model.Poll;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PollRepository  extends JpaRepository<Poll, Long> {

}

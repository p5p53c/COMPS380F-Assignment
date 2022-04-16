package hkmu.comps380f.dao;

import hkmu.comps380f.model.Vote;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface VoteRepository extends JpaRepository<Vote, Long> {

    List<Vote> findByPollid(long pollid);

    Vote findByPollidAndUsername(long pollid, String username);

    Long countByPollidAndVoted(long pollid, int voted);


}

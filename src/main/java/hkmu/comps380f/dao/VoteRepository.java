package hkmu.comps380f.dao;

import hkmu.comps380f.model.Vote;
import hkmu.comps380f.model.VoteId;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface VoteRepository extends JpaRepository<Vote, VoteId> {

    List<Vote> findByPollid(long pollid);
    //@Query("select v from votes v where v.pollid = ?1 and v.username = ?2")
    Vote findByPollidAndUsername(long pollid, String username);

    //Long countByPollidAndVotetarget(long pollid, int voteTarget);
}

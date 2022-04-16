package hkmu.comps380f.service;

import hkmu.comps380f.dao.PollRepository;
import hkmu.comps380f.dao.VoteRepository;
import hkmu.comps380f.exception.PollNotFound;
import hkmu.comps380f.model.Poll;
import hkmu.comps380f.model.Vote;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
public class VoteService {
    
    @Resource
    private PollRepository pollRepo;
    @Resource
    private VoteRepository voteRepo;

    //get all votes of specified poll
    @Transactional
    public List<Vote> getVotes(long id) {
        return voteRepo.findByPollid(id);
    }

    //get current user's vote of specified poll
    @Transactional
    public Vote getVote(long id, String username) {
        return voteRepo.findByPollidAndUsername(id, username);
    }
    
    @Transactional
    public long create(long pollId, String username,
            int voteTarget) {
        Vote vote = new Vote();
        vote.setPollid(pollId);
        vote.setUsername(username);
        vote.setVoteTarget(voteTarget);
        
        Vote savedVote = voteRepo.save(vote);
        return savedVote.getPollid();
    }
    
    @Transactional(rollbackFor = PollNotFound.class)
    public void update(long id, String username, int voteTarget) throws PollNotFound {
        Vote updatedVote = voteRepo.findByPollidAndUsername(id, username);
        if (updatedVote == null) {
            throw new PollNotFound();
        }
        updatedVote.setVoteTarget(voteTarget);
        voteRepo.save(updatedVote);
    }
}

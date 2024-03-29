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
public class PollService {

    @Resource
    private PollRepository pollRepo;

    @Resource
    private VoteRepository voteRepo;

    @Transactional
    public List<Poll> getPolls() {
        return pollRepo.findAll();
    }

    @Transactional
    public Poll getPoll(long id) {
        return pollRepo.findById(id).orElse(null);
    }

    //can create
    @Transactional
    public long createPoll(String question,
            String pollMC1, String pollMC2, String pollMC3, String pollMC4) {
        Poll poll = new Poll();
        //poll.setId(pollId);
        poll.setPollQuestion(question);
        poll.setPollMC1(pollMC1);
        poll.setPollMC2(pollMC2);
        poll.setPollMC3(pollMC3);
        poll.setPollMC4(pollMC4);

        Poll savedPoll = pollRepo.save(poll);
        return savedPoll.getId();
    }

    //can delete
    @Transactional(rollbackFor = PollNotFound.class)
    public void delete(long id) throws PollNotFound {
        Poll deletedPoll = pollRepo.findById(id).orElse(null);
        List<Vote> deletedVotes = voteRepo.findByPollid(id);
        if (deletedPoll == null) {
            throw new PollNotFound();
        }
        for (Vote vote : deletedVotes) {
            voteRepo.delete(vote);
        }
        pollRepo.delete(deletedPoll);
    }
}

package hkmu.comps380f.controller;

import hkmu.comps380f.dao.PollRepository;
import hkmu.comps380f.exception.PollNotFound;
import hkmu.comps380f.model.Poll;
<<<<<<< Updated upstream
=======
import hkmu.comps380f.model.Vote;
import hkmu.comps380f.service.VoteService;
>>>>>>> Stashed changes
import hkmu.comps380f.service.PollService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.io.IOException;
import java.security.Principal;
<<<<<<< Updated upstream
=======
import java.util.List;
>>>>>>> Stashed changes

@Controller
@RequestMapping("/poll")
public class PollController {

    @Autowired
    PollRepository pollRepo;

    @Autowired
    private PollService pollService;

<<<<<<< Updated upstream
=======
    @Autowired
    private VoteService voteService;

    /*
>>>>>>> Stashed changes
    // Controller methods, Form object, ...
    @GetMapping("/{pollId}")
    public String view(@PathVariable("pollId") long pollId, ModelMap model) {
        Poll poll = pollService.getPoll(pollId);
        if (poll == null) {
            return "redirect:/course/list";
        }
        model.addAttribute("poll", poll);
        return "poll";
    }
<<<<<<< Updated upstream
=======
     */
    @GetMapping("/{pollId}")
    public ModelAndView view(@PathVariable("pollId") long pollId, ModelMap model) {
        Poll poll = pollService.getPoll(pollId);
        List<Vote> vote = voteService.getVotes(pollId);
        if (poll == null) {
            return new ModelAndView("list");
        }
        model.addAttribute("poll", poll);
        model.addAttribute("vote", vote);
        return new ModelAndView("poll", "voteForm", new voteForm());
    }

    public static class voteForm {

        private long pollId;
        private String question;
        private String mc1;
        private String mc2;
        private String mc3;
        private String mc4;
        private int voteMC1;
        private int voteMC2;
        private int voteMC3;
        private int voteMC4;

        // Getters and Setters of subject, body, attachments
        public long getPollId() {
            return pollId;
        }

        public void setPollId(long pollId) {
            this.pollId = pollId;
        }

        public String getQuestion() {
            return question;
        }

        public void setQuestion(String question) {
            this.question = question;
        }

        public String getMc1() {
            return mc1;
        }

        public void setMc1(String mc1) {
            this.mc1 = mc1;
        }

        public String getMc2() {
            return mc2;
        }

        public void setMc2(String mc2) {
            this.mc2 = mc2;
        }

        public String getMc3() {
            return mc3;
        }

        public void setMc3(String mc3) {
            this.mc3 = mc3;
        }

        public String getMc4() {
            return mc4;
        }

        public void setMc4(String mc4) {
            this.mc4 = mc4;
        }

        public int getVoteMC1() {
            return voteMC1;
        }

        public void setVoteMC1(int voteMC1) {
            this.voteMC1 = voteMC1;
        }

        public int getVoteMC2() {
            return voteMC2;
        }

        public void setVoteMC2(int voteMC2) {
            this.voteMC2 = voteMC2;
        }

        public int getVoteMC3() {
            return voteMC3;
        }

        public void setVoteMC3(int voteMC3) {
            this.voteMC3 = voteMC3;
        }

        public int getVoteMC4() {
            return voteMC4;
        }

        public void setVoteMC4(int voteMC4) {
            this.voteMC4 = voteMC4;
        }

    }
>>>>>>> Stashed changes

    @PostMapping("/{pollId}")
    public String viewPoll(@PathVariable("pollId") long pollId, ModelMap model) {
        Poll poll = pollService.getPoll(pollId);
        if (poll == null) {
            return "redirect:/course/list";
        }
        model.addAttribute("poll", poll);
        return "poll";
    }

<<<<<<< Updated upstream

=======
>>>>>>> Stashed changes
    @GetMapping("/create")
    public ModelAndView create() {
        return new ModelAndView("addPoll", "pollForm", new Form());
    }

    public static class Form {

        private long pollId;
        private String question;
        private String mc1;
        private String mc2;
        private String mc3;
        private String mc4;

        // Getters and Setters of subject, body, attachments
        public long getPollId() {
            return pollId;
        }

        public void setPollId(long pollId) {
            this.pollId = pollId;
        }

        public String getQuestion() {
            return question;
        }

        public void setQuestion(String question) {
            this.question = question;
        }

        public String getMc1() {
            return mc1;
        }

        public void setMc1(String mc1) {
            this.mc1 = mc1;
        }

        public String getMc2() {
            return mc2;
        }

        public void setMc2(String mc2) {
            this.mc2 = mc2;
        }

        public String getMc3() {
            return mc3;
        }

        public void setMc3(String mc3) {
            this.mc3 = mc3;
        }

        public String getMc4() {
            return mc4;
        }

        public void setMc4(String mc4) {
            this.mc4 = mc4;
        }

    }

    @PostMapping("/create")
    public String create(Form form, Principal principal) throws IOException {
        long pollId = pollService.createPoll(form.getPollId(), form.getQuestion(),
<<<<<<< Updated upstream
                 form.getMc1(), form.getMc2(), form.getMc3(), form.getMc4());
=======
                form.getMc1(), form.getMc2(), form.getMc3(), form.getMc4());
>>>>>>> Stashed changes
        return "redirect:/poll/" + pollId;
    }

    @GetMapping("/delete/{pollId}")
    public String delete(@PathVariable("pollId") long pollId)
            throws PollNotFound {
        pollService.delete(pollId);
        return "redirect:/course/list";
    }
}

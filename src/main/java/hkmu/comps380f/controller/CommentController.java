package hkmu.comps380f.controller;

import hkmu.comps380f.exception.CommentNotFound;
import hkmu.comps380f.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.security.Principal;

@Controller
@RequestMapping("/comment")
public class CommentController {

    @Autowired
    private CommentService commentService;

    @GetMapping({"", "/list"})
    public String list(ModelMap model) {
        model.addAttribute("commentDatabase", commentService.getComments());
        return "listcomment";
    }

    public static class Form {

        private long id;

        private String username;

        private String commentbody;

        private long pollId;

        public long getId() {
            return id;
        }

        public void setId(long id) {
            this.id = id;
        }

        public String getUsername() {
            return username;
        }

        public void setUsername(String username) {
            this.username = username;
        }

        public String getCommentbody() {
            return commentbody;
        }

        public void setCommentbody(String commentbody) {
            this.commentbody = commentbody;
        }

        public long getPollId() {
            return pollId;
        }

        public void setPollId(long pollId) {
            this.pollId = pollId;
        }


    }

    @GetMapping("/create")
    public ModelAndView create() {
        return new ModelAndView("addComment", "comments", new Form());
    }

    @PostMapping("/create")
    public String create(Form form, Principal principal) throws IOException {
        long commendId = commentService.createComment(principal.getName(), form.getCommentbody());
        return "redirect:/poll/"+ form.getPollId() ;
    }

    @GetMapping("/delete/{pollId}/{commentId}")
    public String deleteTicket(@PathVariable("commentId") long commentId, @PathVariable("pollId")long pollId) throws CommentNotFound {
        String username = commentService.getComment(commentId).getUsername();
        commentService.delete(username, commentId);
        return "redirect:/poll/"+ pollId;
    }
}

package hkmu.comps380f.controller;

import hkmu.comps380f.model.Comment;

import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.RedirectView;

@Controller
@RequestMapping("/comment")
public class CommentController {

    private volatile long Comment_ID_SEQUENCE = 1;
    private Map<Long, Comment> commentDatabase = new ConcurrentHashMap<>();

    // Controller methods, Form object, ...
    @GetMapping(value = {"", "/commentlist"})
    public String list(ModelMap model) {
        model.addAttribute("commentDatabase", commentDatabase);
        return "commentlist";
    }

    @GetMapping("/create")
    public ModelAndView create() {
        return new ModelAndView("addComment", "commentForm", new Form());
    }

    public static class Form {

        private String name;
        private String subject;
        private String body;

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public String getSubject() {
            return subject;
        }

        public void setSubject(String subject) {
            this.subject = subject;
        }

        public String getBody() {
            return body;
        }

        public void setBody(String body) {
            this.body = body;
        }

    }

    @PostMapping("/create")
    public View create(Form form) throws IOException {
        Comment comment = new Comment();
        comment.setId(this.getNextCommentId());
        comment.setName(form.getName());
        comment.setSubject(form.getSubject());
        comment.setBody(form.getBody());

        this.commentDatabase.put(comment.getId(), comment);
        return new RedirectView("/comment/view/" + comment.getId(), true);
    }

    private synchronized long getNextCommentId() {
        return this.Comment_ID_SEQUENCE++;
    }

    @GetMapping("/view/{commentId}")
    public String view(@PathVariable("commentId") long commentId,
            ModelMap model) {
        Comment comment = this.commentDatabase.get(commentId);
        if (comment == null) {
            return "redirect:/comment/commentlist";
        }
        model.addAttribute("commentId", commentId);
        model.addAttribute("comment", comment);
        return "viewComment";
    }


}

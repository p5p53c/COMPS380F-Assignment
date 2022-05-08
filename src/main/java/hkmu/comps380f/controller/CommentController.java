package hkmu.comps380f.controller;

import hkmu.comps380f.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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
}

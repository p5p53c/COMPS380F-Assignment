package hkmu.comps380f.controller;

import hkmu.comps380f.model.Course;
import hkmu.comps380f.service.CourseService;
import hkmu.comps380f.service.PollService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/course")
public class CourseController {

    @Autowired
    private CourseService courseService;

    @Autowired
    private PollService pollService;

    // Controller methods, Form object, ...
    @GetMapping({"", "/list"})
    public String list(ModelMap model) {
        model.addAttribute("courseDatabase", courseService.getCourses());
        model.addAttribute("pollDatabase", pollService.getPolls());
        return "list";
    }

    @GetMapping("/view/{courseId}")
    public String view(@PathVariable("courseId") long courseId, ModelMap model) {
        Course course = courseService.getCourse(courseId);
        if (course == null) {
            return "redirect:/course/list";
        }
        model.addAttribute("course", course);
        return "view";
    }

}

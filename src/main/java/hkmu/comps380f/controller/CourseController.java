package hkmu.comps380f.controller;

import hkmu.comps380f.model.Course;
import hkmu.comps380f.service.AttachmentService;
import hkmu.comps380f.service.CourseService;
import hkmu.comps380f.service.MaterialService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import java.io.IOException;
import java.security.Principal;
import java.util.List;

@Controller
@RequestMapping("/course")
public class CourseController {

    @Autowired
    private CourseService courseService;

    // Controller methods, Form object, ...
    @GetMapping({"", "/list"})
    public String list(ModelMap model) {
        model.addAttribute("courseDatabase", courseService.getCourses());
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
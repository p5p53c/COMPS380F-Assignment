package hkmu.comps380f.controller;

import hkmu.comps380f.model.Lecture;
import hkmu.comps380f.service.CourseService;
import hkmu.comps380f.service.LectureService;
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
@RequestMapping("/lecture")
public class LectureController {

    @Autowired
    private LectureService lectureService;

    @GetMapping("/view/{lectureId}")
    public String view(@PathVariable("lectureId") Long lectureid, ModelMap model) {
        Lecture lecture = lectureService.getLecture(lectureid);
        if (lecture == null)
            return "redirect:/course/list";
        model.addAttribute("lecture", lecture);
        return "lectureview";
    }

}

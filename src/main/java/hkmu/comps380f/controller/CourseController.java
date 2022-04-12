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

    @Autowired
    private MaterialService materialService;

    @Autowired
    private AttachmentService attachmentService;

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

    @GetMapping("/create")
    public ModelAndView create() {
        return new ModelAndView("add", "materialForm", new Form());
    }

    public static class Form {
        private Long courseid;
        private String materialname;
        private String materialbody;
        private List<MultipartFile> attachments;

        public Long getCourseid() {
            return courseid;
        }

        public void setCourseid(Long courseid) {
            this.courseid = courseid;
        }

        public String getMaterialname() {
            return materialname;
        }

        public void setMaterialname(String materialname) {
            this.materialname = materialname;
        }

        public String getMaterialbody() {
            return materialbody;
        }

        public void setMaterialbody(String materialbody) {
            this.materialbody = materialbody;
        }

        public List<MultipartFile> getAttachments() {
            return attachments;
        }

        public void setAttachments(List<MultipartFile> attachments) {
            this.attachments = attachments;
        }
    }

    @PostMapping("/create")
    public String create(Form form, Principal principal) throws IOException {
        long materialId = materialService.createMaterial(form.getCourseid(),
                form.getMaterialname(), form.getMaterialbody(), form.getAttachments());
        return "redirect:/material/view/" + materialId;
    }

}

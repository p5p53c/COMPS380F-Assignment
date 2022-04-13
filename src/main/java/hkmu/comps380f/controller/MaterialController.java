package hkmu.comps380f.controller;

import hkmu.comps380f.exception.AttachmentNotFound;
import hkmu.comps380f.exception.MaterialNotFound;
import hkmu.comps380f.model.Attachment;
import hkmu.comps380f.model.Material;
import hkmu.comps380f.service.AttachmentService;
import hkmu.comps380f.service.MaterialService;
import hkmu.comps380f.view.DownloadingView;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.security.Principal;
import java.util.List;

@Controller
@RequestMapping("/material")
public class MaterialController {

    @Autowired
    private MaterialService materialService;

    @Autowired
    private AttachmentService attachmentService;

    public static class Form {
        private Long lectureId;
        private String materialname;
        private String materialbody;
        private List<MultipartFile> attachments;

        public Long getLectureId() {
            return lectureId;
        }

        public void setLectureId(Long lectureId) {
            this.lectureId = lectureId;
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

    @GetMapping("/{lectureId}/create")
    public ModelAndView create() {
        return new ModelAndView("add", "materialForm", new Form());
    }

    @PostMapping("/{lectureId}/create")
    public String create(Form form) throws IOException {
        long materialId = materialService.createMaterial(form.getLectureId(),
                form.getMaterialname(), form.getMaterialbody(), form.getAttachments());
        return "redirect:/material/view/" + materialId;
    }

    @GetMapping("/view/{materialId}")
    public String view(@PathVariable("materialId") long materialId, ModelMap model) {
        Material material = materialService.getMaterial(materialId);
        if (material == null)
            return "redirect:/course/list";
        model.addAttribute("material", material);
        return "materialView";
    }

    @GetMapping("/{materialId}/attachment/{attachment:.+}")
    public View download(@PathVariable("materialId") long materialId,
                         @PathVariable("attachment") String name) {
        Attachment attachment = attachmentService.getAttachment(materialId, name);
        if (attachment != null) {
            return new DownloadingView(attachment.getName(),
                    attachment.getMimeContentType(), attachment.getContents());
        }
        return new RedirectView("/course/list", true);
    }

    @GetMapping("{materialId}/delete/{attachment:.+}")
    public String deleteAttachment(@PathVariable("materialId") long materialId,
                                   @PathVariable("attachment") String name) throws AttachmentNotFound {
        materialService.deleteAttachment(materialId, name);
        return "redirect:/material/edit/" + materialId;
    }

    @GetMapping("/edit/{materialId}")
    public ModelAndView showEdit(@PathVariable("materialId") long materialId,
                                 Principal principal, HttpServletRequest request) {
        Material material = materialService.getMaterial(materialId);
        if (material == null || !request.isUserInRole("ROLE_ADMIN"))
            return  new ModelAndView(new RedirectView("/ticked/list", true));

        ModelAndView modelAndView = new ModelAndView("edit");
        modelAndView.addObject("material", material);

        Form materialForm = new Form();
        materialForm.setMaterialname(material.getMaterialname());
        materialForm.setMaterialbody(material.getMaterialbody());
        modelAndView.addObject("materialForm", materialForm);

        return modelAndView;
    }

    @PostMapping("/edit/{materialId}")
    public String edit(@PathVariable("materialid") long materialId, Form form,
                       Principal principal, HttpServletRequest request)
        throws IOException, MaterialNotFound {
        Material material = materialService.getMaterial(materialId);
        if (material == null || !request.isUserInRole("ROLE_ADMIN"))
            return "redirect:/course/list";

        materialService.updateMaterial(materialId, form.getMaterialname(),
                form.getMaterialbody(), form.getAttachments());
        return "redirect:/material/view/" + materialId;
    }

    @GetMapping("/delete/{materialId}")
    public String deleteMaterial(@PathVariable("materialId") long materialId)
        throws MaterialNotFound {
        materialService.delete(materialId);
        return "redirect:/course/list";
    }

}

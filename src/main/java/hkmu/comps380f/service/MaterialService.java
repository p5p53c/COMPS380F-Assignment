package hkmu.comps380f.service;

import hkmu.comps380f.dao.AttachmentRepository;
import hkmu.comps380f.dao.CourseRepository;
import hkmu.comps380f.dao.LectureRepository;
import hkmu.comps380f.dao.MaterialRepository;
import hkmu.comps380f.exception.AttachmentNotFound;
import hkmu.comps380f.exception.MaterialNotFound;
import hkmu.comps380f.model.Attachment;
import hkmu.comps380f.model.Course;
import hkmu.comps380f.model.Lecture;
import hkmu.comps380f.model.Material;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import javax.annotation.Resource;

@Service
public class MaterialService {

    @Resource
    private MaterialRepository materialRepo;

    @Resource
    private AttachmentRepository attachmentRepo;

    @Resource
    private LectureRepository lectureRepository;

    @Transactional
    public List<Material> getMaterials() {
        return materialRepo.findAll();
    }

    @Transactional
    public Material getMaterial(long id) {
        return materialRepo.findById(id).orElse(null);
    }

    @Transactional(rollbackFor = MaterialNotFound.class)
    public void delete(long id) throws MaterialNotFound {
        Material deletedMaterial = materialRepo.findById(id).orElse(null);
        if (deletedMaterial == null) {
            throw new MaterialNotFound();
        }
        materialRepo.delete(deletedMaterial);
    }

    @Transactional(rollbackFor = AttachmentNotFound.class)
    public void deleteAttachment(long materialId, String name) throws AttachmentNotFound {
        Material material = materialRepo.findById(materialId).orElse(null);
        for (Attachment attachment : material.getAttachments()) {
            if (attachment.getName().equals(name)) {
                material.deleteAttachment(attachment);
                materialRepo.save(material);
                return;
            }
        }
        throw new AttachmentNotFound();
    }

    @Transactional
    public long createMaterial(long lectureId, String name, String body, List<MultipartFile> attachments) throws IOException {

        //write material info to material bean
        Material material = new Material();
        material.setLectureid(lectureId);
        material.setMaterialname(name);
        material.setMaterialbody(body);

        //add attachment to material
        for (MultipartFile filePart : attachments) {
            Attachment attachment = new Attachment();
            attachment.setName(filePart.getOriginalFilename());
            attachment.setMimeContentType(filePart.getContentType());
            attachment.setContents(filePart.getBytes());
            attachment.setMaterial(material);
            if (attachment.getName() != null && attachment.getName().length() > 0
                    && attachment.getContents() != null
                    && attachment.getContents().length > 0) {
                material.getAttachments().add(attachment);
            }
        }
        Material savedMaterial = materialRepo.save(material);

        //add material to lecture
        Lecture updateLecture = lectureRepository.findById(lectureId).orElse(null);
        material.setLecture(updateLecture);
        updateLecture.getMaterials().add(material);

        return savedMaterial.getId();
    }

    @Transactional(rollbackFor = MaterialNotFound.class)
    public void updateMaterial(long id, String name,
                               String body, List<MultipartFile> attachments)
            throws IOException, MaterialNotFound {
        Material updatedMaterial = materialRepo.findById(id).orElse(null);
        if (updatedMaterial == null)
            throw new MaterialNotFound();

        updatedMaterial.setMaterialname(name);
        updatedMaterial.setMaterialbody(body);

        for (MultipartFile filePart : attachments) {
            Attachment attachment = new Attachment();
            attachment.setName(filePart.getOriginalFilename());
            attachment.setMimeContentType(filePart.getContentType());
            attachment.setContents(filePart.getBytes());
            attachment.setMaterial(updatedMaterial);
            if (attachment.getName() != null && attachment.getName().length() > 0
                    && attachment.getContents() != null
                    && attachment.getContents().length > 0) {
                updatedMaterial.getAttachments().add(attachment);
            }
        }
        materialRepo.save(updatedMaterial);
    }
}

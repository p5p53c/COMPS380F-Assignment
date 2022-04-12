package hkmu.comps380f.service;

import hkmu.comps380f.dao.AttachmentRepository;
import hkmu.comps380f.model.Attachment;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

@Service
public class AttachmentService {

    @Resource
    private AttachmentRepository attachmentRepo;

    @Transactional
    public Attachment getAttachment(long materialId, String name) {
        return attachmentRepo.findByMaterialIdAndName(materialId, name);
    }
}

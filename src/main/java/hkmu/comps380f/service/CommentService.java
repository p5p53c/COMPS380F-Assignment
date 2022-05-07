package hkmu.comps380f.service;

import hkmu.comps380f.dao.CommentRepository;
import hkmu.comps380f.model.Comment;
import hkmu.comps380f.model.Material;
import hkmu.comps380f.model.Poll;
import hkmu.comps380f.model.Vote;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
public class CommentService {


    private long id;
    private String name;
    private String subject;
    private String body;

    @Resource
    private CommentRepository commentRepo;

    @Transactional
    public List<Material> getComments() {
        return commentRepo.findAll();
    }

    @Transactional
    public Material getComment(long id) {
        return commentRepo.findById(id).orElse(null);
    }


    //can delete

    }

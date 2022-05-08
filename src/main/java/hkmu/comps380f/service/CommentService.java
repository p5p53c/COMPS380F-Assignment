package hkmu.comps380f.service;

import hkmu.comps380f.dao.CommentRepository;
import hkmu.comps380f.model.Comment;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
public class CommentService {

    @Resource
    private CommentRepository commentRepo;

    @Transactional
    public List<Comment> getComments() {
        return commentRepo.findAll();
    }

    @Transactional
    public Comment getComment(long id) {
        return commentRepo.findById(id).orElse(null);
    }
}

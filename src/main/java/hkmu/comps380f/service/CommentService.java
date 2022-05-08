package hkmu.comps380f.service;

import hkmu.comps380f.dao.CommentRepository;
import hkmu.comps380f.dao.CourseUserRepository;
import hkmu.comps380f.exception.CommentNotFound;
import hkmu.comps380f.model.Comment;
import hkmu.comps380f.model.CourseUser;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import java.io.IOException;
import java.util.List;

@Service
public class CommentService {

    @Resource
    private CommentRepository commentRepo;

    @Resource
    private CourseUserRepository courseUserRepo;

    @Transactional
    public List<Comment> getComments() {
        return commentRepo.findAll();
    }

    @Transactional
    public Comment getComment(long id) {
        return commentRepo.findById(id).orElse(null);
    }

    @Transactional
    public long createComment(String username, String commentbody) throws IOException {
        Comment comment = new Comment();
        comment.setUsername(username);
        comment.setCommentbody(commentbody);

        Comment savedComment = commentRepo.save(comment);
        return savedComment.getId();
    }

    @Transactional(rollbackFor = CommentNotFound.class)
    public void delete(String username, long id) throws CommentNotFound {
        Comment deletedComment = commentRepo.findById(id).orElse(null);
        if (deletedComment == null)
            throw new CommentNotFound();

        CourseUser user = courseUserRepo.findById(username).orElse(null);
        for (Comment comment: user.getComments()) {
            if (comment.getId() == id) {
                user.deleteComment(comment);
                courseUserRepo.save(user);
                return;
            }
        }
        throw new CommentNotFound();
    }
}

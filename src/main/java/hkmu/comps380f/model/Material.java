package hkmu.comps380f.model;

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import javax.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

@Entity
public class Material implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    private String materialname;

    private String materialbody;

    @OneToMany(mappedBy = "material", fetch = FetchType.EAGER,
            cascade = CascadeType.ALL, orphanRemoval = true)
    @Fetch(FetchMode.SUBSELECT)
    private List<Attachment> attachments = new ArrayList<>();

    private long courseId;

    @ManyToOne
    @JoinColumn(name = "courseid", insertable = false, updatable = false)
    private Course course;

    public Course getCourse() {
        return course;
    }

    public void setCourse(Course course) {
        this.course = course;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getCourseId() {
        return courseId;
    }

    public void setCourseId(long courseiId) {
        this.courseId = courseiId;
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

    public List<Attachment> getAttachments() {
        return attachments;
    }

    public void setAttachments(List<Attachment> attachments) {
        this.attachments = attachments;
    }

    public void deleteAttachment(Attachment attachment) {
        attachment.setMaterial(null);
        this.attachments.remove(attachment);
    }
}

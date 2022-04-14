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

    private long lectureid;

    @ManyToOne
    @JoinColumn(name = "lectureid", insertable = false, updatable = false)
    private Lecture lecture;

    public long getLectureid() {
        return lectureid;
    }

    public void setLectureid(long lectureid) {
        this.lectureid = lectureid;
    }

    public Lecture getLecture() {
        return lecture;
    }

    public void setLecture(Lecture lecture) {
        this.lecture = lecture;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
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

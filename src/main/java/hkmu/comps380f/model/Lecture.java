package hkmu.comps380f.model;

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import javax.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

@Entity
public class Lecture implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    private int lecturenumber;

    private String lecturetitle;

    @OneToMany(mappedBy = "lecture", fetch = FetchType.EAGER,
            cascade = CascadeType.ALL, orphanRemoval = true)
    @Fetch(FetchMode.SUBSELECT)
    private List<Material> materials = new ArrayList<>();

    private long courseId;

    @ManyToOne
    @JoinColumn(name = "courseid", insertable = false, updatable = false)
    private Course course;


    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public int getLecturenumber() {
        return lecturenumber;
    }

    public void setLecturenumber(int lecturenumber) {
        this.lecturenumber = lecturenumber;
    }

    public String getLecturetitle() {
        return lecturetitle;
    }

    public void setLecturetitle(String lecturetitle) {
        this.lecturetitle = lecturetitle;
    }

    public List<Material> getMaterials() {
        return materials;
    }

    public void setMaterials(List<Material> materials) {
        this.materials = materials;
    }

    public long getCourseId() {
        return courseId;
    }

    public void setCourseId(long courseId) {
        this.courseId = courseId;
    }

    public Course getCourse() {
        return course;
    }

    public void setCourse(Course course) {
        this.course = course;
    }

    public void deleteMaterial(Material material) {
        material.setLecture(null);
        this.materials.remove(material);
    }
}

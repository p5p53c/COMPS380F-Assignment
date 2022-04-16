package hkmu.comps380f.model;

import javax.persistence.*;
import java.io.Serializable;


@Entity
public class Attachment implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column(name = "filename")
    private String name;

    @Column(name = "content_type")
    private String mimeContentType;

    @Column(name = "content")
    @Basic(fetch = FetchType.LAZY)
    @Lob
    private byte[] contents;

    @Column(name = "materialid", insertable = false, updatable = false)
    private long materialId;

    @ManyToOne
    @JoinColumn(name = "materialid")
    private Material material;

    // getters and setters of all properties
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getMimeContentType() {
        return mimeContentType;
    }

    public void setMimeContentType(String mimeContentType) {
        this.mimeContentType = mimeContentType;
    }

    public byte[] getContents() {
        return contents;
    }

    public void setContents(byte[] contents) {
        this.contents = contents;
    }

    public long getMaterialId() {
        return materialId;
    }

    public void setMaterialId(long courseId) {
        this.materialId = courseId;
    }

    public Material getMaterial() {
        return material;
    }

    public void setMaterial(Material material) {
        this.material = material;
    }
}

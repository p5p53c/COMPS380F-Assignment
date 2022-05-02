package hkmu.comps380f.model;

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import javax.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "users")
public class CourseUser implements Serializable {

    @Id
    private String username;

    private String password;

    private String fullname;

    private String address;

    private String phone;

    @OneToMany(mappedBy = "user", fetch = FetchType.EAGER,
            cascade = CascadeType.ALL, orphanRemoval = true)
    @Fetch(FetchMode.SUBSELECT)
    private List<UserRole> roles = new ArrayList<>();

    @OneToMany(mappedBy = "username", fetch = FetchType.EAGER,
            cascade = CascadeType.ALL, orphanRemoval = true)
    @Fetch(FetchMode.SUBSELECT)
    private List<Vote> votes = new ArrayList<>();

    public CourseUser() {
    }

    public CourseUser(String username, String password, String fullname, String address, String phone, String[] roles) {
        this.username = username;
        this.password = "{noop}" + password;
        this.fullname = fullname;
        this.address = address;
        this.phone = phone;
        for (String role : roles) {
            this.roles.add(new UserRole(this, role));
        }
    }

    // getters and setters of all properties
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public List<UserRole> getRoles() {
        return roles;
    }

    public void setRoles(String[] roles) {
        for (String role : roles) {
            this.roles.add(new UserRole(this, role));
        }
    }

    public List<Vote> getVotes() {
        return votes;
    }

}
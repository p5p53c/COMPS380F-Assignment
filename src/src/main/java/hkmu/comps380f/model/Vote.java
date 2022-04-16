package hkmu.comps380f.model;

import java.io.Serializable;
import javax.persistence.*;

@Entity
@Table(name = "votes")
public class Vote implements Serializable {

    @Id
    private long pollid;
    @Id
    private String username;

    @Column(name = "votetarget")
    private String voteTarget;

    public long getPollid() {
        return pollid;
    }

    public void setPollid(long pollid) {
        this.pollid = pollid;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getVoteTarget() {
        return voteTarget;
    }

    public void setVoteTarget(String voteTarget) {
        this.voteTarget = voteTarget;
    }

}
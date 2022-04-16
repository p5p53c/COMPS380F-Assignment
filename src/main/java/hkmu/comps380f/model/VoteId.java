package hkmu.comps380f.model;

import java.io.Serializable;

public class VoteId implements Serializable {
    private long pollid;

    private String username;

    public VoteId(long pollid, String username) {
        this.pollid = pollid;
        this.username = username;
    }
}

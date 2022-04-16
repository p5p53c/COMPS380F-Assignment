package hkmu.comps380f.model;

import java.io.Serializable;
import javax.persistence.*;

@Entity
@Table(name = "polls")
public class Poll implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column(name = "pollquestion")
    private String pollQuestion;

    private String pollMC1;
    private String pollMC2;
    private String pollMC3;
    private String pollMC4;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getPollQuestion() {
        return pollQuestion;
    }

    public void setPollQuestion(String pollQuestion) {
        this.pollQuestion = pollQuestion;
    }

    public String getPollMC1() {
        return pollMC1;
    }

    public void setPollMC1(String pollMC1) {
        this.pollMC1 = pollMC1;
    }

    public String getPollMC2() {
        return pollMC2;
    }

    public void setPollMC2(String pollMC2) {
        this.pollMC2 = pollMC2;
    }

    public String getPollMC3() {
        return pollMC3;
    }

    public void setPollMC3(String pollMC3) {
        this.pollMC3 = pollMC3;
    }

    public String getPollMC4() {
        return pollMC4;
    }

    public void setPollMC4(String pollMC4) {
        this.pollMC4 = pollMC4;
    }

}

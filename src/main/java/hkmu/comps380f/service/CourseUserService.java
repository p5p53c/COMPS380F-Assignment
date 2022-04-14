package hkmu.comps380f.service;

import hkmu.comps380f.dao.CourseUserRepository;
import hkmu.comps380f.exception.CourseUserNotFound;
import hkmu.comps380f.exception.MaterialNotFound;
import hkmu.comps380f.model.CourseUser;
import hkmu.comps380f.model.UserRole;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.Resource;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class CourseUserService implements UserDetailsService {

    @Resource
    CourseUserRepository courseUserRepo;

    @Override
    public UserDetails loadUserByUsername(String username)
            throws UsernameNotFoundException {
        CourseUser courseUser = courseUserRepo.findById(username).orElse(null);
        if (courseUser == null) {
            throw new UsernameNotFoundException("User '" + username + "' not found.");
        }
        List<GrantedAuthority> authorities = new ArrayList<>();
        for (UserRole role : courseUser.getRoles()) {
            authorities.add(new SimpleGrantedAuthority(role.getRole()));
        }
        return new User(courseUser.getUsername(), courseUser.getPassword(), authorities);
    }

    @Transactional
    public CourseUser getUser(String username) {
        return courseUserRepo.findById(username).orElse(null);
    }

}

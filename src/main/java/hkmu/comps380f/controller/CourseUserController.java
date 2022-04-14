package hkmu.comps380f.controller;

import hkmu.comps380f.dao.CourseUserRepository;
import hkmu.comps380f.exception.CourseUserNotFound;
import hkmu.comps380f.model.CourseUser;
import hkmu.comps380f.model.UserRole;
import hkmu.comps380f.service.CourseUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.RedirectView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

@Controller
@RequestMapping("/user")
public class CourseUserController {

    @Resource
    CourseUserRepository courseUserRepo;

    @Autowired
    private CourseUserService userService;

    @GetMapping({"", "/list"})
    public String list(ModelMap model) {
        model.addAttribute("courseUsers", courseUserRepo.findAll());
        return "listUser";
    }

    public static class Form {

        private String username;
        private String password;

        private String fullname;

        private String address;

        private String phone;
        private String[] roles;

        // ... getters and setters for each of the properties
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

        public String[] getRoles() {
            return roles;
        }

        public void setRoles(String[] roles) {
            this.roles = roles;
        }
    }

    @GetMapping("/create")
    public ModelAndView create() {
        return new ModelAndView("addUser", "courseUsers", new Form());
    }

    @PostMapping("/create")
    public View create(Form form) throws IOException {
        if (form.getRoles().length == 0) {
            return new RedirectView("/user/create?error=role");
        }
        CourseUser user = new CourseUser(form.getUsername(),
                form.getPassword(),
                form.getFullname(), form.getAddress(),
                form.getPhone(), form.getRoles());
        courseUserRepo.save(user);
        return new RedirectView("/user/list", true);
    }

    @GetMapping("/delete/{username}")
    public View deleteTicket(@PathVariable("username") String username) {
        courseUserRepo.delete(courseUserRepo.findById(username).orElse(null));
        return new RedirectView("/user/list", true);
    }

    @GetMapping("/edit/{username}")
    public ModelAndView showEdit(@PathVariable("username") String username, HttpServletRequest request) {
        CourseUser user = userService.getUser(username);
        if (user == null || !request.isUserInRole("ROLE_ADMIN"))
            return new ModelAndView(new RedirectView("/course/list", true));

        ModelAndView modelAndView = new ModelAndView("editUser");
        modelAndView.addObject("user", user);

        Form userForm = new Form();
        userForm.setUsername(user.getUsername());
        userForm.setPassword(user.getPassword().split("}")[1]);
        userForm.setFullname(user.getFullname());
        userForm.setAddress(user.getAddress());
        userForm.setPhone(user.getPhone());
        String[] role = new String[3];
        int i = 0;
        for (UserRole userRole : user.getRoles()) {
            role[i] = userRole.getRole();
            i++;
        }
        userForm.setRoles(role);
        
        
        modelAndView.addObject("userForm", userForm);

        return modelAndView;
    }

    @PostMapping("/edit/{username}")
    public String edit(@PathVariable("username") String username, Form form,
                       HttpServletRequest request)
        throws IOException, CourseUserNotFound {
        CourseUser updatedUser = userService.getUser(username);
        if (updatedUser == null || !request.isUserInRole("ROLE_ADMIN"))
            return "redirect:/course/list";

        updatedUser.setPassword("{noop}" + form.getPassword());
        updatedUser.setFullname(form.getFullname());
        updatedUser.setAddress(form.getAddress());
        updatedUser.setPhone(form.getPhone());

        courseUserRepo.save(updatedUser);

        return "redirect:/user/list";
    }
}

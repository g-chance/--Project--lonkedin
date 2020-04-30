package com.wabdavinc.lonkedin.validator;



import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.wabdavinc.lonkedin.models.User;
import com.wabdavinc.lonkedin.repositories.UserRepo;

@Component
public class UserValidator implements Validator {
	
	private final UserRepo urepo;
	
	public UserValidator(UserRepo urepo) {
		this.urepo = urepo;
	}

	@Override
	public boolean supports(Class<?> clazz) {
		return User.class.equals(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		User user = (User) target;
		if(user.getUniverse() == null) {
			if(!user.getConfirmPassword().equals(user.getPassword())) {
				errors.rejectValue("confirmPassword", "Match");
			} if (urepo.findByEmail(user.getEmail()) != null) {
				errors.rejectValue("email", "Duplicate");
			}
		}
		if(user.getUniverse() != null) {
			if(urepo.findByNameAndUniverse(user.getName(), user.getUniverse()) != null) {
				errors.rejectValue("universe", "Duplicate");
			}
		}
	}
	
}

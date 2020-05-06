package com.wabdavinc.lonkedin.validator;



import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.wabdavinc.lonkedin.models.Game;
import com.wabdavinc.lonkedin.repositories.GameRepo;

@Component
public class GameValidator implements Validator {
	
	private final GameRepo grepo;
	
	public GameValidator(GameRepo grepo) {
		this.grepo = grepo;
	}

	@Override
	public boolean supports(Class<?> clazz) {
		return Game.class.equals(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		Game game = (Game) target;
		if(grepo.findByName(game.getName()) != null) {
			errors.rejectValue("name", "Duplicate");
		}
	}
	
}

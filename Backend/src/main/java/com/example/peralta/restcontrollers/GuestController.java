package com.example.peralta.restcontrollers;

import com.example.peralta.security.JWTTokenProvider;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("guest")
public class GuestController {

    @PostMapping("login")
    public ResponseEntity<Object> login(String username, String password) {
        //logar no banco e verificar a existência do usuário
        //validar a senha
        // caso ok : gerar token
        if(username != null && password != null)
        {
            if(username.equals("admin") && password.equals("admin123"))
            {
                String token;
                token = JWTTokenProvider.createToken(username, "admin");
                return ResponseEntity.ok().body(token);
            }
        }
        return ResponseEntity.badRequest().body("Usuário e senha inválidos");
    }
}

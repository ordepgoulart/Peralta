package com.example.peralta.restcontrollers;

import com.example.peralta.security.JWTTokenProvider;
import com.example.peralta.services.UsuarioService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/apis/guest")
public class GuestController {

    UsuarioService usuarioService;

    @PostMapping("login")
    public ResponseEntity<Object> login(String username, String password) {
        //logar no banco e verificar a existência do usuário
        //validar a senha
        // caso ok : gerar token
        if(username != null && password != null)
        {
            String token;
            if(username.equals("admin") && password.equals("admin123"))
            {
                token = JWTTokenProvider.createToken(username, "admin");
                return ResponseEntity.ok().body(token);
            }
            else
            {

                token = JWTTokenProvider.createToken(username, "basic");
                return ResponseEntity.ok().body(token);
            }
        }
        return ResponseEntity.badRequest().body("Usuário e senha inválidos");
    }
}

package com.example.peralta.restcontrollers;

import com.example.peralta.security.JWTTokenProvider;
import com.example.peralta.services.UsuarioService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/guest")
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
                try
                {
                    token = JWTTokenProvider.createToken(username, "admin");
                    System.out.println(token);
                    return ResponseEntity.ok().body(token);
                }
                catch (Exception e)
                {
                    System.out.println(e.getMessage());
                }
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

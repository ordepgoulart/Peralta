package com.example.peralta.restcontrollers;

import com.example.peralta.entities.Erro;
import com.example.peralta.entities.Usuario;
import com.example.peralta.security.JWTTokenProvider;
import com.example.peralta.services.UsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/guest")
public class GuestController {

    @Autowired
    UsuarioService usuarioService;

    @PostMapping("login")
    public ResponseEntity<Object> login(String username, String senha) {

        if(username != null && senha != null)
        {
            Usuario usuario = usuarioService.findByKeyAccess(username);
            String token;
            if(usuario != null && senha.equals(usuario.getSenha()))
            {

                try
                {
                    if(usuario.getAcesso() == 1)
                        token = JWTTokenProvider.createToken(usuario.getEmail(), "admin");
                    else
                        token = JWTTokenProvider.createToken(usuario.getEmail(), "basic");
                    System.out.println(token);
                    return ResponseEntity.ok().body(token);
                }
                catch (Exception e)
                {
                    System.out.println(e.getMessage());
                }

            }
        }
        return ResponseEntity.badRequest().body("Usuário e senha inválidos");
    }

    @PostMapping("cadastrar")
    public ResponseEntity<Object> cadastrar(String email, String senha, String cpf) {
        System.out.println(email);
        System.out.println(senha);
        System.out.println(cpf);
        if(email != null && senha != null && cpf != null)
        {
            Usuario usuario = usuarioService.findByKeyAccess(email);
            Usuario usuario2 = usuarioService.findByKeyAccess(cpf);
            if(usuario != null || usuario2 != null)
                return ResponseEntity.badRequest().body("Já existe um usuário cadastrado com " + (usuario == null ? "esse EMAIL" : "esse CPF"));
            else
            {
                Usuario newUsuario = new Usuario(cpf, email, 2, senha);
                newUsuario = usuarioService.save(newUsuario);
                if (newUsuario != null) {
                    return ResponseEntity.ok().body(newUsuario);
                }
                return ResponseEntity.badRequest().body(new Erro("Não foi possível cadastrar o tipo de problema especificado."));
            }
        }
        return ResponseEntity.badRequest().body("Todos os campos devem ser preenchidos");
    }
}

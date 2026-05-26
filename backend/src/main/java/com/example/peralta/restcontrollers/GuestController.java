package com.example.peralta.restcontrollers;

import com.example.peralta.DTO.LOGIN;
import com.example.peralta.DTO.TRANSFER_DTO;
import com.example.peralta.entities.Erro;
import com.example.peralta.entities.Usuario;
import com.example.peralta.security.JWTTokenProvider;
import com.example.peralta.services.UsuarioService;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/guest")
public class GuestController {


    @Autowired
    UsuarioService usuarioService;

    @PostMapping("login")
    public ResponseEntity<Object> login(@RequestBody LOGIN requestDTO) {
        System.out.println("login");
        if(requestDTO.username() != null && requestDTO.senha() != null)
        {
            Usuario usuario = usuarioService.findByKeyAccess(requestDTO.username());
            String token;
            if(usuario != null && requestDTO.senha().equals(usuario.getSenha()))
            {

                try
                {
                    if(usuario.getAcesso() == 1)
                        token = JWTTokenProvider.createToken(usuario.getEmail(), "admin");
                    else
                        token = JWTTokenProvider.createToken(usuario.getEmail(), "basic");
                    TRANSFER_DTO transferDto = new TRANSFER_DTO(usuario.getAcesso(), token, usuario.getId());
                    return ResponseEntity.ok(transferDto);
                }
                catch (Exception e)
                {
                    System.out.println(e.getMessage());
                }

            }
        }
        return ResponseEntity.badRequest().body("Usuário e senha inválidos");
    }

    @PostMapping("cadastrar/{email}/{senha}/{cpf}")
    public ResponseEntity<Object> cadastrar(@PathVariable("email") String email, @PathVariable("senha") String senha,@PathVariable("cpf") String cpf) {
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
                    return ResponseEntity.ok().body("Usuario cadastrado com sucesso");
                }
                return ResponseEntity.badRequest().body(new Erro("Um erro não especificado ocorreu durante o cadastro."));
            }
        }
        return ResponseEntity.badRequest().body("Todos os campos devem ser preenchidos");
    }
}

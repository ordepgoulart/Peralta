package com.example.peralta.restcontrollers;


import com.example.peralta.entities.Tipo;
import com.example.peralta.security.JWTTokenProvider;
import com.example.peralta.services.TipoService;
import jakarta.persistence.Entity;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/apis/admin")
public class AdminController {

    @Autowired
    private TipoService tipoService;
    @Autowired
    private HttpServletRequest httpServletRequest;

    @GetMapping("all-types")
    public ResponseEntity<Object> getAllTypes ()
    {
//        try
//        {
//            String token = httpServletRequest.getHeader("Authorization");
//            if(JWTTokenProvider.verifyToken(token)) {
//                String nivel = JWTTokenProvider.getAllClaimsFromToken(token).get("nivel").toString();
                //if(nivel.equals("admin")) {
                    List<Tipo> tipoList = new ArrayList<Tipo>();
                    tipoList = tipoService.findAll();
                    return ResponseEntity.ok(tipoList);
                //}
//            }
            //return ResponseEntity.badRequest().body("Token inválido");
//        }
//        catch (Exception ex)
//        {
//            return ResponseEntity.badRequest().body(ex.getMessage());
//        }

    }

}

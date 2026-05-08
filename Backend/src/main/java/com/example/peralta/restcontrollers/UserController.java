package com.example.peralta.restcontrollers;

import com.example.peralta.entities.*;
import com.example.peralta.services.DenunciaService;
import com.example.peralta.services.FeedBackService;
import com.example.peralta.services.OrgaoService;
import com.example.peralta.services.TipoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/apis/basic")
public class UserController {

    @Autowired
    private OrgaoService orgaoService;
    @Autowired
    private TipoService tipoService;
    @Autowired
    private DenunciaService denunciaService;
    @Autowired
    private FeedBackService feedBackService;

    @GetMapping("get-institutions")
    public ResponseEntity<Object> getInstitutions() {
        List<Orgao> orgaos = orgaoService.findAll();
        if(orgaos.isEmpty())
            return ResponseEntity.badRequest().body("Nenhum órgão e/ou instiuição interessados foi encontrado.");
        return ResponseEntity.ok(orgaos);
    }

    @GetMapping("get-type_problems")
    public ResponseEntity<Object> getTypeProblems() {
        List<Tipo> tipos = tipoService.findAll();
        if(tipos.isEmpty())
            return ResponseEntity.badRequest().body(new Erro("Nenhum tipo de problema foi encontrado."));
        return ResponseEntity.ok(tipos);
    }

    @GetMapping("view-my_reports/{id}")
    public ResponseEntity<Object> getMyReports(@PathVariable Long id) {
        List<Denuncia> denuncias = denunciaService.findByUser(id);
        if(denuncias.isEmpty())
            return ResponseEntity.badRequest().body(new Erro("Nenhuma denuncia foi encontrado."));
        return ResponseEntity.ok(denuncias);
    }

    @GetMapping("get-feedback")
    public ResponseEntity<Object> getFeedback(Long denunciaId)
    {
        Feedback feedback = feedBackService.getByReportId(denunciaId);
        if(feedback != null)
            return ResponseEntity.ok(feedback);
        return ResponseEntity.badRequest().body(new Erro("A denúncia informada, ainda não possui um feedbakc"));
    }

    @PostMapping("add_report")
    public ResponseEntity<Object> addReport() {

        return null;
    }
}

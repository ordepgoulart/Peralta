package com.example.peralta.restcontrollers;


import com.example.peralta.entities.*;
import com.example.peralta.security.JWTTokenProvider;
import com.example.peralta.services.*;
import jakarta.persistence.Entity;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/apis/admin")
public class AdminController {

    @Autowired
    private TipoService tipoService;
    @Autowired
    private HttpServletRequest httpServletRequest;
    @Autowired
    private UsuarioService usuarioService;
    @Autowired
    private OrgaoService orgaoService;
    @Autowired
    private DenunciaService denunciaService;
    @Autowired
    private FeedBackService feedBackService;

    @GetMapping("all-institutions")
    public ResponseEntity<Object> getInstitutions() {
        List<Orgao> orgaos = orgaoService.findAll();
        if(orgaos.isEmpty())
            return ResponseEntity.badRequest().body("Nenhum órgão e/ou instiuição interessados foi encontrado.");
        return ResponseEntity.ok(orgaos);
    }

    @GetMapping("get-institution/{id}")
    public ResponseEntity<Object> getInstitutionById(@PathVariable Long id)
    {
        Orgao orgao = orgaoService.findById(id);
        if(orgao == null)
            return ResponseEntity.badRequest().body(new Erro("Órgão não encontrado"));
        return ResponseEntity.ok(orgao);
    }

    @DeleteMapping("delete-institution/{id}")
    public ResponseEntity<Object> deleteInstitutionById(@PathVariable Long id)
    {
        boolean ret = orgaoService.delete(id);
        if (ret)
            return ResponseEntity.ok("Órgão deletado com sucesso");
        else
            return ResponseEntity.badRequest().body(new Erro("Um erro ocorreu e não foi possível deletar o órgão especificado."));
    }

    @PostMapping("add-institution")
    public ResponseEntity<Object> addInstitution(@RequestParam("nome") String nome)
    {
        if(nome == null || nome.isEmpty())
            return ResponseEntity.badRequest().body(new Erro("Todos os dados devem ser fornecidos : "  + "NOME IS REQUIRED"));
        Orgao orgao = new Orgao(nome);
        orgao = orgaoService.save(orgao);
        if(orgao != null)
            return ResponseEntity.ok(orgao);
        return ResponseEntity.badRequest().body(new Erro("Não foi possível inserir o órgão especificado."));

    }

    @PutMapping("update-institution")
    public ResponseEntity<Object> updateInstitution(@RequestParam("nome") String nome, @RequestParam("id") Long id)
    {
        if(nome == null || nome.isEmpty() || id == null)
            return ResponseEntity.badRequest().body(new Erro("Todos os dados devem ser fornecidos : "  + (id == null ? "ID IS REQUIRED" : "NOME IS REQUIRED")));
        Orgao orgao = new Orgao(id,nome);
        orgao = orgaoService.save(orgao);
        if(orgao != null)
            return ResponseEntity.ok(orgao);
        return ResponseEntity.badRequest().body(new Erro("Não foi possível alterar o órgão especificado."));

    }

    @GetMapping("all-reports")
    public ResponseEntity<Object> getAllReports()
    {
        List<Denuncia> denuncias = denunciaService.findAll();
        return ResponseEntity.ok(denuncias);
    }

    @DeleteMapping("delete-report/{id}")
    public ResponseEntity<Object> deleteReportById(@PathVariable Long id)
    {
        boolean ret = denunciaService.delete(id);
        if (ret)
            return ResponseEntity.ok("Denúncia deletada com sucesso");
        else
            return ResponseEntity.badRequest().body(new Erro("Um erro ocorreu e não foi possível deletar a denúncia"));
    }

    @PostMapping("add-feedback")
    public ResponseEntity<Object> addReport(@RequestParam("denuncia") Denuncia denuncia, @RequestParam("texto") String texto)
    {
        if(denuncia == null || texto == null || texto.isEmpty() ||denuncia.getId() == 0)
            return ResponseEntity.badRequest().body(new Erro("Todos os dados devem ser fornecidos : " + (denuncia == null || denuncia.getId() == 0 ? "DENÚNCIA IS MISSING." : "TEXTO IS REQUIRED")));
        Feedback feedback = new Feedback(texto, denuncia);
        Feedback result = feedBackService.getByReportId(denuncia.getId());
        if(result == null)
        {
            feedback = feedBackService.save(feedback);
            if(feedback != null)
                return ResponseEntity.ok(feedback);
            return ResponseEntity.badRequest().body(new Erro("Não foi possível inserir o feedback."));
        }
        return ResponseEntity.badRequest().body(new Erro("A denúncia informada já possui um feedback registrado."));
    }

    @PostMapping("add-type")
    public ResponseEntity<Object> addType(@RequestParam("nome") String nome)
    {
        if(nome == null || nome.isEmpty())
            return ResponseEntity.badRequest().body(new Erro("Todos os dados devem ser fornecidos : "  + "NOME IS REQUIRED"));
        Tipo tipo = new Tipo(nome);
        tipo = tipoService.save(tipo);
        if(tipo != null)
            return ResponseEntity.ok(tipo);
        return ResponseEntity.badRequest().body(new Erro("Não foi possível inserir o tipo de problema especificado."));

    }

    @GetMapping("get-type/{id}")
    public ResponseEntity<Object> getTypeById(@PathVariable Long id)
    {
        Tipo tipo = tipoService.findById(id);
        if(tipo == null)
            return ResponseEntity.badRequest().body(new Erro("Tipo não encontrado"));
        return ResponseEntity.ok(tipo);
    }

    @GetMapping("all-types")
    public ResponseEntity<Object> getAllTypes ()
    {
        List<Tipo> tipoList = new ArrayList<Tipo>();
        tipoList = tipoService.findAll();
        return ResponseEntity.ok(tipoList);
    }

    @DeleteMapping("delete-type/{id}")
    public ResponseEntity<Object> deleteTypeById(@PathVariable Long id)
    {
        boolean ret = tipoService.delete(id);
        if (ret)
            return ResponseEntity.ok("Tipo de problema deletado com sucesso");
        else
            return ResponseEntity.badRequest().body(new Erro("Um erro ocorreu e não foi possível deletar o tipo de problema especificado."));
    }

}

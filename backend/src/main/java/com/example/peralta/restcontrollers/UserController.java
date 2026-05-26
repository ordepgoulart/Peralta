package com.example.peralta.restcontrollers;

import com.example.peralta.entities.*;
import com.example.peralta.security.JWTTokenProvider;
import com.example.peralta.services.*;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.apache.commons.io.FilenameUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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
    @Autowired
    private HttpServletRequest httpServletRequest;
    @Autowired
    private UsuarioService usuarioService;

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

    @GetMapping("view-my-reports/{id}")
    public ResponseEntity<Object> getMyReports(@PathVariable Long id) {
        List<Denuncia> denuncias = denunciaService.findByUser(id);
        if(denuncias.isEmpty())
            return ResponseEntity.badRequest().body(new Erro("Nenhuma denuncia foi encontrado."));
        return ResponseEntity.ok(denuncias);
    }

    @GetMapping("get-feedback/{id}")
    public ResponseEntity<Object> getFeedback(@PathVariable Long id)
    {
        Feedback feedback = feedBackService.getByReportId(id);
        if(feedback != null)
            return ResponseEntity.ok(feedback);
        return ResponseEntity.badRequest().body(new Erro("A denúncia informada, ainda não possui um feedbakc"));
    }

    @PostMapping("add_report")
    public ResponseEntity<Object> addReport(@RequestParam("fotos") MultipartFile[] fotos,
                                            @RequestParam("titulo") String titulo, @RequestParam("texto") String texto,
                                            @RequestParam("urgencia") int urgencia, @RequestParam("orgao") Orgao orgao,
                                            @RequestParam("tipo") Tipo tipo
    ) {
        if(titulo == null || orgao == null || tipo == null || titulo.isEmpty() || texto.isEmpty())
            return ResponseEntity.badRequest().body(Map.of("message","Todos os dados devem ser preenchidos"));
        final String UPLOAD_FOLDER = System.getProperty("user.dir") + "/uploads/";
        try
        {   int i = 0;
            String token = httpServletRequest.getHeader("Authorization");
            String username = JWTTokenProvider.getAllClaimsFromToken(token).getSubject();
            LocalDate localDate = LocalDate.now();
            Usuario usuario = usuarioService.findByKeyAccess(username);
            if(usuario == null)
                return ResponseEntity.badRequest().body(new Erro("Usuário não localizado."));
            Denuncia denuncia = new Denuncia(orgao,usuario,tipo,localDate,urgencia,titulo,texto);
            File uploadFolder = new File(UPLOAD_FOLDER);
            if (!uploadFolder.exists()) uploadFolder.mkdir();
            for (MultipartFile foto : fotos) {
                String fileName = titulo + "_" + username + "_" + tipo.getId() + localDate.toString() + i + FilenameUtils.getExtension(foto.getOriginalFilename());
                i++;
                foto.transferTo(new File(uploadFolder.getAbsolutePath() + "/"+ fileName));
                denuncia.addFoto(new Foto(fileName));
            }
            DenunciaService denunciaService = new DenunciaService();
            denuncia = denunciaService.save(denuncia);
            if (denuncia != null)
                return ResponseEntity.ok(denuncia);
            return ResponseEntity.badRequest().body(new Erro("Não foi possível inserir a denúncia"));
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return ResponseEntity.badRequest().body(Map.of("message",e.getMessage()));
        }
    }
}

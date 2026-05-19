package com.example.peralta.security;

import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Component;

import java.io.IOException;

@Component
public class AccessFilter implements Filter {

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws ServletException, IOException {
        String token = ((HttpServletRequest) servletRequest).getHeader("Authorization");
        String mensage = "Unauthorized";
        String rota = ((HttpServletRequest) servletRequest).getRequestURI();
        System.out.println(token == null);
        if(!rota.startsWith("/apis"))
        {
            filterChain.doFilter(servletRequest, servletResponse);
        } else {
            if (JWTTokenProvider.verifyToken(token)) {
                String nivel = JWTTokenProvider.getAllClaimsFromToken(token).get("nivel").toString();
                String route = ((HttpServletRequest) servletRequest).getRequestURI();
                if (route.contains(nivel))
                    filterChain.doFilter(servletRequest, servletResponse);
                else {
                    mensage = "Unauthorized : Access Denied, level insufficient, required : " + nivel;
                }
            }
            ((HttpServletResponse) servletResponse).setStatus(500);
            servletResponse.getOutputStream().write(mensage.getBytes());
        }
    }
}

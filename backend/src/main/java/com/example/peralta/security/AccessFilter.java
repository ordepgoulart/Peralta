//package com.example.peralta.security;
//
//import jakarta.servlet.*;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import org.springframework.stereotype.Component;
//
//import java.io.IOException;
//
//@Component
//public class AccessFilter implements Filter {
//
//    @Override
//    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws ServletException, IOException {
//        System.out.println("Passei");
//        String token = ((HttpServletRequest) servletRequest).getHeader("Authorization");
//
//        String mensage = "Unauthorized";
//        String rota = ((HttpServletRequest) servletRequest).getRequestURI();
//
//        if(token != null && JWTTokenProvider.verifyToken(token)) {
//            String nivel = JWTTokenProvider.getAllClaimsFromToken(token).get("nivel").toString();
//            String route = ((HttpServletRequest) servletRequest).getRequestURI();
//            if(route.contains(nivel))
//                filterChain.doFilter(servletRequest,servletResponse);
//            else {
//                mensage = "Unauthorized : Access Denied, level insufficient, required : " + nivel;
//            }
//        } else if (!(rota.equals("/apis/guest/login")))
//            {
//                ((HttpServletResponse) servletResponse).setStatus(HttpServletResponse.SC_UNAUTHORIZED);
//                servletResponse.getOutputStream().write(mensage.getBytes());
//            }
//        else filterChain.doFilter(servletRequest,servletResponse);
//    }
//}

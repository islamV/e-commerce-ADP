package com.ecommerce.ecommerce.security;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.interfaces.DecodedJWT;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import redis.clients.jedis.Jedis;

import java.io.IOException;

// Security Filter for authentication and authorization
@WebFilter("/*")
public class AuthFilter implements Filter {


    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest request=(HttpServletRequest) req;
        HttpServletResponse response=(HttpServletResponse) res;
        String path =request.getRequestURI().substring(request.getContextPath().length());

         // Allow access to login/register/error page without auth
        if(path.contains("login.jsp") || path.contains("/login") || path.contains("/register") || path.contains("error.jsp")){

            chain.doFilter(request,response);
            return;
        }
        String user=null;
        String role=null;
        Cookie[] cookies=request.getCookies();

        // Try to find session in redis
        String sessionId=null;
        if(cookies != null){
            for(Cookie c :cookies ){
                if("SESSION_ID".equals(c.getName())) sessionId=c.getValue();
            }
        }

        if(sessionId!=null){
            try(Jedis jedis=new Jedis("127.0.0.1", 6379)){
                user =jedis.get("session:"+sessionId);
                if(user!=null){
                    role=jedis.get("role:"+user);
                    System.out.println("Session Auth success for "+user);
                }
            }catch (Exception e){
                System.err.println("Redis down then falling back to jwt check");
            }
        }

        // fallback to jwt if session not found
        if(user==null && cookies!=null){
            String token=null;
            for(Cookie c:cookies){
                if("JWT_TOKEN".equals(c.getName())) token=c.getValue();
            }
            if (token != null) {
                try {
                    DecodedJWT jwt = JWT.require(Algorithm.HMAC256("secret")).build().verify(token);
                    user = jwt.getClaim("user").asString();
                    role = jwt.getClaim("role").asString();
                    System.out.println("JWT Auth Success for: " + user);
                } catch (Exception e) {
                    System.err.println("Invalid JWT : " + e.getMessage());
                }
            }
        }

        // redirect to login if two mechanism fail
        if(user==null){
            System.out.println("Unautorized access to "+path);
            response.sendRedirect("login.jsp");
            return;
        }
        request.setAttribute("user",user);
        request.setAttribute("role",role);
        chain.doFilter(request,response);


    }
}
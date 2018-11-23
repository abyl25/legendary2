package services;

import java.util.HashSet;
import java.util.Set;
import javax.ws.rs.ApplicationPath;
import javax.ws.rs.core.Application;

//import Users_service;

@ApplicationPath("/api")
public class MyApplication extends Application {
    private Set<Object> singletons = new HashSet<Object>();
    private Set<Class<?>> empty = new HashSet<Class<?>>();
    
    public MyApplication() {
        singletons.add(new Users_service());
        singletons.add(new Jobs_service());
        singletons.add(new PostService());
        //singletons.add(new AdminDeleteUsers());
    }
    
    @Override
    public Set<Class<?>> getClasses() {
        return empty;
    }

    @Override
    public Set<Object> getSingletons() {
        return singletons;
    }
}

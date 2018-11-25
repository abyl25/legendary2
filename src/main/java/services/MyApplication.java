package services;

import java.util.HashSet;
import java.util.Set;

import javax.ws.rs.ApplicationPath;
import javax.ws.rs.core.Application;

import org.glassfish.jersey.media.multipart.MultiPartFeature;

//import Users_service;

@ApplicationPath("/api")
public class MyApplication extends Application {
    private Set<Object> singletons = new HashSet<Object>();
    private Set<Class<?>> empty = new HashSet<Class<?>>();
    
    public MyApplication() {
    	singletons.add(MultiPartFeature.class);
//    	singletons.add(MultiPartResource.class);
//    	singletons.add(LoggingFilter.class);
    	
        singletons.add(new Users_service());
        singletons.add(new Jobs_service());
        singletons.add(new PostService());
        
        //singletons.add(new AdminDeleteUsers());
    }
    
    @Override
    public Set<Class<?>> getClasses() {
//    	final Set<Class<?>> resources = new HashSet<Class<?>>();

        // Add additional features such as support for Multipart.
//        resources.add(MultiPartFeature.class);
//        resources.add(Users_service.class);
//        resources.add(Jobs_service.class);
//        resources.add(PostService.class);
        
//        return resources;
    	return empty;
    }

    @Override
    public Set<Object> getSingletons() {
        return singletons;
    }
}

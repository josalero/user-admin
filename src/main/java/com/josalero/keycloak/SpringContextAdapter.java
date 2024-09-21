package com.josalero.keycloak;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;

/**
 * Provides Spring-managed classes to non-Spring-managed class.
 *
 * <p>Example:
 *
 * <pre>
 *     MyBeanClass myBeanInstance = SpringContextAdapter.getBean(MyBeanClass.class);
 * </pre>
 */
@Component
public class SpringContextAdapter implements ApplicationContextAware {

  private static ApplicationContext context;

  /**
   * Returns the Spring managed bean instance of the given class type if it exists. Returns null
   * otherwise.
   *
   * @param beanClass the class of the bean to return, not the name.
   * @return the bean for the class.
   */
  public static <T> T getBean(Class<T> beanClass) {
    return context.getBean(beanClass);
  }

  public static <T> T getProperty(String property, Class<T> propertyClass) {
    return context.getEnvironment().getProperty(property, propertyClass);
  }

  @Override
  public void setApplicationContext(ApplicationContext context) throws BeansException {

    // store ApplicationContext reference to access required beans later on
    SpringContextAdapter.context = context;
  }
}

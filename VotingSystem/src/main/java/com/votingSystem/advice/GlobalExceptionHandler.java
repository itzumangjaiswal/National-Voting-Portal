package com.votingSystem.advice;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.web.servlet.ModelAndView;

/**
 * GlobalExceptionHandler is a controller advice class that handles exceptions
 * thrown by controllers in the application. It provides a centralized way to
 * manage exceptions and return user-friendly error pages.
 *
 * @author Anand Raj
 */
@ControllerAdvice
public class GlobalExceptionHandler {

    /**
     * Handles generic exceptions that are not explicitly handled by other
     * exception handlers. This method captures the exception message and
     * returns a ModelAndView object that directs the user to a generic error page.
     *
     * @param ex the exception that was thrown
     * @return ModelAndView object containing the error message and view name
     */
    @ExceptionHandler(Exception.class)
    public ModelAndView handleGenericException(Exception ex) {

        ModelAndView mav = new ModelAndView();

        mav.addObject("message", ex.getMessage());
        mav.setViewName("errorPage");

        return mav;
    }

//    @ExceptionHandler(ResponseStatusException.class)
//    public ModelAndView handleResponseStatusException(ResponseStatusException ex) {
//        ModelAndView mav = new ModelAndView();
//        mav.addObject("message", ex.getMessage());
//        mav.setViewName("errorPage");
//        return mav;
//    }

}

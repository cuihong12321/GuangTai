package com.guangtai.service;

import com.guangtai.model.domain.Interviewee;

import java.util.List;

/**
 * Created by Rojackios on 2017/2/14.
 * IntervieweeService 被访人接口
 */
public interface IntervieweeService {

    List<Interviewee> getInterviewee();

    Interviewee getById(Class<Interviewee> interviewee, int id);

    void add(Interviewee interviewee);

    void edit(Interviewee interviewee);

    void delete(Interviewee interviewee);

}

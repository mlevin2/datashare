<!--
 |  (C) Copyright IBM Corporation 2001, 2005. All Rights Reserved.
 |
 | The Darwin Information Typing Architecture (DITA) was orginated by
 | IBM's XML Workgroup and ID Workbench tools team.
 |
 | Refer to this file by the following public identfier or an appropriate
 | system identifier:
 |
 |   PUBLIC "-//IBM//ELEMENTS DITA Task//EN"
 |
 | Release history (vrm):
 |   1.0.0 Initial release on developerWorks, March 2001 (dita00.zip)
 |   1.0.1 fix 1 on developerWorks, October 2001 (dita01.zip)
 |   1.0.2 consolidated redesign December 2001
 |   1.0.3 fix 1, dtd freeze for UCD-1 January 2002
 |   1.1.0 Release 1 March 2002 (dita10.zip)
 |   1.1.1 Release 1.1 December 2002
 |   1.1.2 Release 1.2 June 2003
 |   1.1.3 Release 1.3 March 2004: bug fixes and map updates
 |   1.1.3a bug fix: revised "DTDVersion" to match release version (consistency);
 |                   revised conbody attlist to match other infotype's body attlists (consistency)
 *-->

<!ENTITY DTDVersion 'V1.1.3' >



<!-- ============ Specialization of declared elements ============ -->
<!ENTITY % taskClasses SYSTEM "task_class.ent">
<!--%taskClasses;-->

<!ENTITY % task        "task">
<!ENTITY % taskbody    "taskbody">
<!ENTITY % steps       "steps">
<!ENTITY % steps-unordered "steps-unordered">
<!ENTITY % step        "step">
<!ENTITY % cmd         "cmd">
<!ENTITY % substeps    "substeps">
<!ENTITY % substep     "substep">
<!ENTITY % tutorialinfo "tutorialinfo">
<!ENTITY % info        "info">
<!ENTITY % stepxmp     "stepxmp">
<!ENTITY % stepresult  "stepresult">
<!ENTITY % choices     "choices">
<!ENTITY % choice      "choice">
<!ENTITY % result      "result">
<!ENTITY % prereq      "prereq">
<!ENTITY % postreq     "postreq">
<!ENTITY % context     "context">
<!ENTITY % choicetable "choicetable">
<!ENTITY % chhead      "chhead">
<!ENTITY % chrow       "chrow">
<!ENTITY % choptionhd  "choptionhd">
<!ENTITY % chdeschd    "chdeschd">
<!ENTITY % choption    "choption">
<!ENTITY % chdesc      "chdesc">


<!-- provide an alternative set of univ-atts that allows importance to be redefined locally-->
<!ENTITY % univ-atts-no-importance-task
                         '%id-atts;
                          platform CDATA #IMPLIED
                          product CDATA #IMPLIED
                          audience CDATA #IMPLIED
                          otherprops CDATA #IMPLIED
                          rev CDATA #IMPLIED
                          status (new|changed|deleted|unchanged) #IMPLIED
                          translate (yes|no) #IMPLIED
                          xml:lang NMTOKEN #IMPLIED'
>

<!ENTITY % task-info-types "%info-types;">
<!ENTITY included-domains "">

<!--doc:The <task> element is the top-level element for a task topic. Tasks are the main building blocks for task-oriented user assistance. They generally provide step-by-step instructions that will enable a user to perform a task. A task answers the question of "how to?" by telling the user precisely what to do and the order in which to do it. Tasks have the same high-level structure as other topics, with a title, short description and body.
Category: Task elements-->
<!ELEMENT task           (%title;, (%titlealts;)?, (%shortdesc;)?, (%prolog;)?, %taskbody;, (%related-links;)?, (%task-info-types;)* )>
<!ATTLIST task            id ID #REQUIRED
                          conref CDATA #IMPLIED
                          %select-atts;
                          outputclass CDATA #IMPLIED
                          xml:lang NMTOKEN #IMPLIED
                          DTDVersion CDATA #FIXED "&DTDVersion;"
                          domains CDATA "&included-domains;"
>

<!--doc:The <taskbody> element is the main body-level element inside a task topic. A task body has a very specific structure, with the following elements in this order: <prereq>, <context>, <steps>, <result>, <example> and <postreq>. Each of the body sections are optional.
Category: Task elements-->
<!ELEMENT taskbody       ((%prereq;)?, (%context;)?, (%steps;|%steps-unordered;)?, (%result;)?, (%example;)?, (%postreq;)?) >
<!ATTLIST taskbody        %id-atts;
                          translate (yes|no) #IMPLIED
                          xml:lang NMTOKEN #IMPLIED
                          outputclass CDATA #IMPLIED
>

<!--doc:The pre-requisite (<prereq>) section of a task should document things the user needs to know or do before starting the current task. Prerequisite links will be placed in a list after the related-links section; on output the <prereq> links from the related-links section are added to the <prereq> section.
Category: Task elements-->
<!ELEMENT prereq         (%section.notitle.cnt;)* >
<!ATTLIST prereq          %univ-atts;
                          outputclass CDATA #IMPLIED
>
<!--doc:The <context> section of a task provides background information for the task. This information helps the user understand what the purpose of the task is and what they will gain by completing the task. This section should be brief and does not replace or recreate a concept topic on the same subject, although the context section may include some conceptual information.
Category: Task elements-->
<!ELEMENT context        (%section.notitle.cnt;)* >
<!ATTLIST context         %univ-atts;
                          outputclass CDATA #IMPLIED
>


<!--doc:The <steps> section of a task provides the main content of the task topic. The task is described as a series of steps that the user must follow to accomplish the task. One or more <steps> elements is required inside the <steps> section.
Category: Task elements-->
<!ELEMENT steps          ((%step;)+)>
<!ATTLIST steps           %univ-atts;
                          outputclass CDATA #IMPLIED
>

<!--doc:Like the <steps> element, the <steps-unordered> section of a task provides the main content of the task topic, but particularly for cases in which the order of steps may vary from one situation to another. One or more steps is required inside the <steps-unordered> section.
Category: Task elements-->
<!ELEMENT steps-unordered ((%step;)+)>
<!ATTLIST steps-unordered %univ-atts;
                          outputclass CDATA #IMPLIED
>

<!--doc:The <step> element represents an action that a user must follow to accomplish a task. Each step in a task must contain a command <cmd> element which describes the particular action the user must do to accomplish the overall task. The step element can also contain information <info>, substeps <substeps>, tutorial information <tutorialinfo>, a step example <stepxmp>, choices <choices> or a stepresult <stepresult>, although these are optional.
Category: Task elements-->
<!ELEMENT step           (%cmd;, (%info;|%substeps;|%tutorialinfo;|%stepxmp;|%choicetable;|%choices;)*, (%stepresult;)?) >
<!ATTLIST step            importance (optional | required) #IMPLIED
                          %univ-atts-no-importance-task;
                          outputclass CDATA #IMPLIED
>
<!--ATTLIST step          importance ( optional | required ) #IMPLIED-->

<!--doc:The command (<cmd>) element is required as the first element inside a <step>. It provides the active voice instruction to the user for completing the step, and should not be more than one sentence. If the step needs additional explanation, this can follow the <cmd> element inside an <info > element.
Category: Task elements-->
<!ELEMENT cmd            (%ph.cnt;)* >
<!ATTLIST cmd             keyref NMTOKEN #IMPLIED
                          %univ-atts;
                          outputclass CDATA #IMPLIED
>
<!--doc:The information element (<info>) occurs inside a <step> element to provide additional information about the step.
Category: Task elements-->
<!ELEMENT info           (%itemgroup.cnt;)* >
<!ATTLIST info            %univ-atts;
                          outputclass CDATA #IMPLIED
>

<!--doc:The <substeps> element allows you to break a step down into a series of separate actions, and should be used only if necessary. Try to describe the steps of a task in a single level of steps. If you need to use more than one level of substep nesting, you should probably rewrite the task to simplify it.
Category: Task elements-->
<!ELEMENT substeps       (%substep;)+ >
<!ATTLIST substeps        %univ-atts;
                          outputclass CDATA #IMPLIED
>
<!--doc:A <substep> element has the same structure as a <step>, except that it does not allow lists of choices or substeps within it, in order to prevent unlimited nesting of steps.
Category: Task elements-->
<!ELEMENT substep        (%cmd;,  (%info;|%tutorialinfo;|%stepxmp;)*, (%stepresult;)?)>
<!ATTLIST substep         importance (optional | required) #IMPLIED
                          %univ-atts-no-importance-task;
                          outputclass CDATA #IMPLIED
>
<!--ATTLIST substep       importance ( optional | required ) #IMPLIED-->

<!--doc:The tutorial info (<tutorialinfo>) element contains additional information that is useful when the task is part of a tutorial.
Category: Task elements-->
<!ELEMENT tutorialinfo   (%itemgroup.cnt;)* >
<!ATTLIST tutorialinfo    %univ-atts;
                          outputclass CDATA #IMPLIED
>

<!--doc:The step example (<stepxmp>) element is used to illustrate a step of a task. The example can be a couple of words, or an entire paragraph.
Category: Task elements-->
<!ELEMENT stepxmp        (%itemgroup.cnt;)* >
<!ATTLIST stepxmp         %univ-atts;
                          outputclass CDATA #IMPLIED
>

<!--doc:The <choices> element contains a list of <choice> elements. It is used when the user will need to choose one of several actions while performing the steps of a task.
Category: Task elements-->
<!ELEMENT choices        ((%choice;)+) >
<!ATTLIST choices         %univ-atts;
                          outputclass CDATA #IMPLIED
>
<!--doc:Each <choice> element describes one way that the user could accomplish the current step.
Category: Task elements-->
<!ELEMENT choice         (#PCDATA|%basic.ph;)*>


<!--doc:The <choicetable> element contains a series of optional choices available within a step of a task.
Category: Task elements-->
<!ELEMENT choicetable    ((%chhead;)?, (%chrow;)+) >
<!ATTLIST choicetable     relcolwidth CDATA #IMPLIED
                          keycol NMTOKEN "1"
                          refcols NMTOKENS #IMPLIED
                          %display-atts;
                          %univ-atts;
                          spectitle CDATA #IMPLIED
                          outputclass CDATA #IMPLIED
>
<!--doc:The <chhead> element is a container inside the <choicetable> element that provides specific heading text to override the default Options and Description headings. The <chhead> element contains both a <choptionhd> and <chdeschd> element as a pair.
Category: Task elements-->
<!ELEMENT chhead         ((%choptionhd;), (%chdeschd;))>
<!ATTLIST chhead          %univ-atts;
                          outputclass CDATA #IMPLIED
>
<!--doc:The <choptionhd> element provides a specific label for the list of options that a user chooses from to accomplish a step. The default label for options is Option.
Category: Task elements-->
<!ELEMENT choptionhd     (%tblcell.cnt;)*>
<!ATTLIST choptionhd      %univ-atts;
                          specentry CDATA #IMPLIED
                          outputclass CDATA #IMPLIED
>
<!--doc:The <chdeschd> option provides a specific label for the list of descriptions of options that a user must choose to accomplish a step of a task. The default label overridden by <chdeschd> is Description.
Category: Task elements-->
<!ELEMENT chdeschd       (%tblcell.cnt;)*>
<!ATTLIST chdeschd        %univ-atts;
                          specentry CDATA #IMPLIED
                          outputclass CDATA #IMPLIED
>

<!--doc:The <chrow> element is a container inside the <choicetable> element. The <chrow> element contains both a <choption> and <chdesc> element as a pair.
Category: Task elements-->
<!ELEMENT chrow          ((%choption;), (%chdesc;))>
<!ATTLIST chrow           %univ-atts;
                          outputclass CDATA #IMPLIED
>
<!--doc:The <choption> element describes an option that a user could choose to accomplish a step of a task. In a user interface, for example, this might be the name of radio button.
Category: Task elements-->
<!ELEMENT choption       (%tblcell.cnt;)*>
<!ATTLIST choption        %univ-atts;
                          specentry CDATA #IMPLIED
                          outputclass CDATA #IMPLIED
>
<!--doc:The <chdesc> element is a description of an option that a user chooses while performing a step to accomplish a task. It explains why the user would choose that option, and might explain the result of the choice when it is not immediately obvious.
Category: Task elements-->
<!ELEMENT chdesc         (%tblcell.cnt;)*>
<!ATTLIST chdesc          %univ-atts;
                          specentry CDATA #IMPLIED
                          outputclass CDATA #IMPLIED
>


<!--doc:The <stepresult> element provides information on the expected outcome of a step. If a user interface is being documented, the outcome could describe a dialog box opening, or the appearance of a progress indicator. Step results are useful to assure a user that they are on track, but should not be used for every step, as this quickly becomes tedious.
Category: Task elements-->
<!ELEMENT stepresult     (%itemgroup.cnt;)* >
<!ATTLIST stepresult      %univ-atts;
                          outputclass CDATA #IMPLIED
>

<!--doc:The <result> element describes the expected outcome for the task as a whole.
Category: Task elements-->
<!ELEMENT result         (%section.notitle.cnt;)* >
<!ATTLIST result          %univ-atts;
                          outputclass CDATA #IMPLIED
>

<!--doc:The <postreq> element describes steps or tasks that the user should do after the successful completion of the current task. It is often supported by links to the next task or tasks in the <related-links> section.
Category: Task elements-->
<!ELEMENT postreq        (%section.notitle.cnt;)* >
<!ATTLIST postreq         %univ-atts;
                          outputclass CDATA #IMPLIED
>


<!--specialization attributes-->

<!ATTLIST task         %global-atts; class  CDATA "- topic/topic task/task ">
<!ATTLIST taskbody     %global-atts; class  CDATA "- topic/body task/taskbody ">
<!ATTLIST steps        %global-atts; class  CDATA "- topic/ol task/steps ">
<!ATTLIST steps-unordered %global-atts; class  CDATA "- topic/ul task/steps-unordered ">
<!ATTLIST step         %global-atts; class  CDATA "- topic/li task/step ">
<!ATTLIST cmd          %global-atts; class  CDATA "- topic/ph task/cmd ">
<!ATTLIST substeps     %global-atts; class  CDATA "- topic/ol task/substeps ">
<!ATTLIST substep      %global-atts; class  CDATA "- topic/li task/substep ">
<!ATTLIST tutorialinfo %global-atts; class  CDATA "- topic/itemgroup task/tutorialinfo ">
<!ATTLIST info         %global-atts; class  CDATA "- topic/itemgroup task/info ">
<!ATTLIST stepxmp      %global-atts; class  CDATA "- topic/itemgroup task/stepxmp ">
<!ATTLIST stepresult   %global-atts; class  CDATA "- topic/itemgroup task/stepresult ">

<!ATTLIST choices      %global-atts; class  CDATA "- topic/ul task/choices ">
<!ATTLIST choice       %global-atts; class  CDATA "- topic/li task/choice ">

<!ATTLIST result       %global-atts; class  CDATA "- topic/section task/result ">
<!ATTLIST prereq       %global-atts; class  CDATA "- topic/section task/prereq ">
<!ATTLIST postreq      %global-atts; class  CDATA "- topic/section task/postreq ">
<!ATTLIST context      %global-atts; class  CDATA "- topic/section task/context ">

<!ATTLIST choicetable  %global-atts; class  CDATA "- topic/simpletable task/choicetable ">
<!ATTLIST chhead       %global-atts; class  CDATA "- topic/sthead task/chhead ">
<!ATTLIST chrow        %global-atts; class  CDATA "- topic/strow task/chrow ">
<!ATTLIST choptionhd   %global-atts; class  CDATA "- topic/stentry task/choptionhd ">
<!ATTLIST chdeschd     %global-atts; class  CDATA "- topic/stentry task/chdeschd ">
<!ATTLIST choption     %global-atts; class  CDATA "- topic/stentry task/choption ">
<!ATTLIST chdesc       %global-atts; class  CDATA "- topic/stentry task/chdesc ">




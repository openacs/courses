<master>
<property name=title>@page_title@</property>
<property name="context">@context;noquote@</property>
<if @create_p@ eq 1>
    <div align="right"><a href="cc-admin/course-list"><img border=0 src=images/admin.gif></a></div>
</if>

<multiple name="course_list">
   <a href="course-info?course_id=@course_list.course_id@&course_name=@course_list.course_name@&course_key=@course_list.course_key@"> @course_list.course_key@ ---> @course_list.course_name@</a>
    <br>
</multiple>
<master>
<property name=title>@page_title@</property>
<property name="context">@context;noquote@</property>
<if @admin_p@ eq 1>
    <div align="right"><a href="admin/"><img border=0 src=images/admin.gif></a></div>
</if>
<if @create_p@ eq 1>
<ul>
    <li><a href="cc-admin/add-edit-course?return_url=@return_url@">#courses.add_course#</a>
    <li><a href="cc-admin/course-list?return_url=@return_url@">#courses.course_list#</a>
    <li><a href="cc-admin/grant-list?return_url=@return_url@">#courses.grant_per#</a>
</ul>
</if>

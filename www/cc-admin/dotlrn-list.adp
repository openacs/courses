<master>
<property name=title>@page_title@</property>
<property name="context">@context;noquote@</property>

<if @course_key@ not nil>
	<h2>#courses.associate# @course_key@ (@course_name@) #courses.to# #courses.class#:</h2> 
</if>
<else>
        <h2>#courses.associate# #courses.to# #courses.class#:</h2> 
</else>

<listtemplate name="dotlrn_classes"></listtemplate>

<if @course_key@ not nil>
	<h2>#courses.associate# @course_key@ (@course_name@) #courses.to# #courses.community#:</h2> 
</if>
<else>
        <h2>#courses.associate# #courses.to# #courses.community#:</h2> 
</else>
<listtemplate name="dotlrn_communities"></listtemplate>
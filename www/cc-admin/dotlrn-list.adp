<master>
<property name=title>@page_title@</property>
<property name="context">@context;noquote@</property>

<if @course_key@ not nil>
	<h2>#courses.associate# @course_key@ #courses.to#:</h2> 
</if>
<listtemplate name="dotlrn_classes"></listtemplate>

<master>
<property name=title>@page_title@</property>
<property name="context">@context;noquote@</property>


<h2>@course_key;noquote@ #courses.is_assoc#</h2>

<multiple name="relations">
    <include src="/packages/courses/lib/dotlrn-chunk" class_id=@relations.class_id@>
</multiple>

<a href="dotlrn-list?course_id=@course_id@&course_key=@course_key@">#courses.associate_more#</a>
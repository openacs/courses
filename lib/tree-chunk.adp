<h3>#courses.categorized#:</h3>
@tree_view;noquote@
<br>
<if @uncat_p@ eq 1>
   <h3>#courses.uncategorized#:</h3>
</if>
<ul>
<multiple name="uncat">
    <li><a href="">(@uncat.course_key@) @uncat.course_name@</a>
</multiple>
</ul>
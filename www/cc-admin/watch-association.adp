<master>
<property name=title>@page_title@</property>
<property name="context">@context;noquote@</property>


<h2>@course_key;noquote@ #courses.is_assoc#</h2>

<multiple name="relations">
    <if @relations.type@ eq "course_catalog_class_rel">
    	<include src="/packages/courses/lib/dotlrn-chunk" class_id=@relations.object_id@>
    </if>
    <else>
    	<include src="/packages/courses/lib/community-chunk" community_id=@relations.object_id@>
    </else>
</multiple>


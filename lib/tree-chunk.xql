<?xml version="1.0"?>
<queryset>

<fullquery name="get_course_info">
      <querytext>
            select cc.course_id, cc.course_key, cc.course_name
            from course_catalog cc, cr_items ci
            where cc.course_id = ci.live_revision and cc.course_id = :course_id
      </querytext>
</fullquery>


<fullquery name="get_courses_uncat">
      <querytext>
            select cc.course_id, cc.course_key, cc.course_name
            from course_catalog cc, cr_items ci
            where cc.course_id = ci.live_revision and cc.course_id not in (
		select object_id from category_object_map where category_id in (
	 	    select category_id from categories where tree_id =:tree_id
	    	)	
	    )	
      </querytext>
</fullquery>


</queryset>

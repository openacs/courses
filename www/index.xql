<?xml version="1.0"?>
<queryset>

<fullquery name="get_course_list">      
      <querytext>
            select cc.course_id, cc.course_key, cc.course_name, cc.course_info, cc.assessment_id, ci.item_id
	    from course_catalog cc, cr_items ci
 	    where cc.course_id = ci.live_revision
      </querytext>
</fullquery>

</queryset>
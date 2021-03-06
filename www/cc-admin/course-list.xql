<?xml version="1.0"?>
<queryset>

<fullquery name="get_course_info">      
      <querytext>
            select cc.course_id, cc.course_key, cc.course_name, cc.course_info, cc.assessment_id, ci.item_id
	    from course_catalog cc, cr_items ci
 	    where cc.course_id = ci.live_revision and  
	    ci.item_id in (
		select object_id from acs_permissions where grantee_id = :user_id and
		privilege = 'admin')
         	
      </querytext>
</fullquery>

<fullquery name="get_course_info_site_wide">      
      <querytext>
            select cc.course_id, cc.course_key, cc.course_name, cc.course_info, cc.assessment_id, ci.item_id
	    from course_catalog cc, cr_items ci
 	    where cc.course_id = ci.live_revision
      </querytext>
</fullquery>

<fullquery name="get_asm_name">
      <querytext>
            select cr.title from
            cr_folders cf, cr_items ci, cr_revisions cr, as_assessments a
            where cr.revision_id = ci.latest_revision and a.assessment_id = cr.revision_id and
            ci.parent_id = cf.folder_id and cf.package_id = :asm_package_id and
            ci.item_id = :assessment_id order by cr.title
      </querytext>
</fullquery>


</queryset>

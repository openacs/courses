<?xml version="1.0"?>
<queryset>

<fullquery name="get_course_info">      
      <querytext>
            select course_id, course_key, course_name, course_info, assessment_id, item_id
	    from course_catalog, cr_items
	    where course_id = live_revision and  
	    item_id in (
		select object_id from acs_permissions where grantee_id = :user_id and
		privilege = 'admin')
         	
      </querytext>
</fullquery>

<fullquery name="get_course_info_site_wide">      
      <querytext>
            select course_id, course_key, course_name, course_info, assessment_id 
	    from course_catalog, cr_items
	    where course_id = live_revision          	
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

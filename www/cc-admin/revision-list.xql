<?xml version="1.0"?>
<queryset>

<fullquery name="get_course_info">      
      <querytext>
	    select course_id, course_key, course_name, course_info, assessment_id, live_revision
	    from course_catalog, cr_items
	    where course_key = :course_key and name= :course_key
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

    <fullquery name="get_class_info">
        <querytext>
            select pretty_name, url
	    from dotlrn_class_instances_full 
	    where class_instance_id = :class_id
        </querytext>
    </fullquery>

</queryset>

<?xml version="1.0"?>
<queryset>

<fullquery name="get_course_info">      
      <querytext>
            select cc.course_info, cc.assessment_id, cr.item_id
	    from course_catalog cc, cr_revisions cr
 	    where cr.revision_id = :course_id and cc.course_id = :course_id
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
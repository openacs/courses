<?xml version="1.0"?>
<queryset>

<fullquery name="course_catalog::get_folder_id.check_folder_name">
  <querytext>
        select folder_id from cr_folders
        where label = 'Course Catalog'
  </querytext>
</fullquery>

<fullquery name="course_catalog::get_item_id.get_item_from_name">
  <querytext>
        select item_id from cr_items
        where name = :name and parent_id = :parent_id and content_type = 'course_catalog'
  </querytext>
</fullquery>

<fullquery name="course_catalog::get_creation_user.get_creation_user">
  <querytext>
        select creation_user from acs_objects
        where object_id = :object_id
  </querytext>
</fullquery>


<fullquery name="course_catalog::set_live.set_live_revision">      
      <querytext>
            update cr_items
            set live_revision = :revision_id
	    where name = :name
      </querytext>
</fullquery>

<fullquery name="course_catalog::rename.set_item_name">      
      <querytext>
            update cr_items
            set name = :name
	    where item_id = :item_id
      </querytext>
</fullquery>

<fullquery name="course_catalog::has_relation.has_relation">      
      <querytext>
            select count (rel_id)
	    from acs_rels where rel_type = 'course_catalog_rel' and object_id_one = :course_id 
      </querytext>
</fullquery>

<fullquery name="course_catalog::com_has_relation.com_has_relation">      
      <querytext>
            select count (rel_id)
	    from acs_rels where rel_type = 'course_catalog_rel' and object_id_two = :community_id
      </querytext>
</fullquery>


<fullquery name="course_catalog::has_relation_rel_id.has_relation_rel_id">      
      <querytext>
            select rel_id
	    from acs_rels where
	    rel_type = 'course_catalog_rel' and object_id_one = :course_id
      </querytext>
</fullquery>


<fullquery name="course_catalog::delete_row.delete_row">      
      <querytext>
	   delete from course_catalog where course_id = :course_id
      </querytext>
</fullquery>

<fullquery name="course_catalog::delete_row.delete_rev">      
      <querytext>
	   delete from cr_revisions where revision_id = :course_id
      </querytext>
</fullquery>

<fullquery name="course_catalog::check_live_latest.check_live">      
      <querytext>
	   select 1 from cr_items where live_revision = :revision_id
      </querytext>
</fullquery>

<fullquery name="course_catalog::check_live_latest.check_latest">      
      <querytext>
	   select 1 from cr_items where latest_revision = :revision_id
      </querytext>
</fullquery>

<fullquery name="course_catalog::grant_permissions.assessment">
      <querytext>
            select ci.item_id as assessment_id from
            cr_folders cf, cr_items ci, cr_revisions cr, as_assessments a
            where cr.revision_id = ci.latest_revision and a.assessment_id = cr.revision_id and
            ci.parent_id = cf.folder_id and cf.package_id = :asm_package_id 
      </querytext>
</fullquery>

<fullquery name="course_catalog::revoke_permissions.assessment">
      <querytext>
            select ci.item_id as assessment_id from
            cr_folders cf, cr_items ci, cr_revisions cr, as_assessments a
            where cr.revision_id = ci.latest_revision and a.assessment_id = cr.revision_id and
            ci.parent_id = cf.folder_id and cf.package_id = :asm_package_id 
      </querytext>
</fullquery>


</queryset>





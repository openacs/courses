ad_page_contract {
    Deletes one revision

    @author          Miguel Marin (miguelmarin@viaro.net) 
    @author          Viaro Networks www.viaro.net
    @creation date   02-02-2005
} {
    course_key:notnull
    revision_id:notnull
}

# Delete row and revision from course_catalog and cr_revisions
course_catalog::delete_row -course_id $revision_id

ad_returnredirect "/courses/cc-admin/course-list"

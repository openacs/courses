ad_page_contract {
    Makes one revision live

    @author          Miguel Marin (miguelmarin@viaro.net) 
    @author          Viaro Networks www.viaro.net
    @creation date   29-01-2005
} {
    course_key:notnull
    revision_id:notnull
}

course_catalog::set_live -name $course_key -revision_id $revision_id

ad_returnredirect "/courses/cc-admin/course-list"

ad_page_contract {
    Displays a information about course_catalog(course_id) and dotlrn_class_instance
    list of all revisions for one course

    @author          Miguel Marin (miguelmarin@viaro.net) Viaro Networks (www.viaro.net)
    @creation date   28-01-2005
} {
    { return_url "" }
    course_id:notnull
    course_key:notnull
}

set page_title "[_ courses.watch_assoc]"
set context [list [list "/courses/cc-admin/course-list"  "[_ courses.course_list]"] "[_ courses.watch_asoc]"]

set user_id [auth::get_user_id]

# Check if users has admin permission to edit course_catalog
permission::require_permission -party_id $user_id -object_id $course_id -privilege "admin"


set class_id [course_catalog::has_relation -course_id $course_id]

db_1row get_class_info { }


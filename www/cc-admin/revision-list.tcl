ad_page_contract {
    Displays a list of all revisions for one course

    @author          Miguel Marin (miguelmarin@viaro.net) 
    @author          Viaro Networks www.viaro.net
    @creation date   28-01-2005
} {
    { return_url "" }
    course_key:notnull
    course_id:notnull
}

set page_title "[_ courses.rev_list]"
if {[string equal $return_url ""]} {
    set return_url "/courses/course-list"
}

set user_id [ad_conn user_id]
set item_id [course_catalog::get_item_id -revision_id $course_id]

# Check if users has admin permission to edit course_catalog
permission::require_permission -party_id $user_id -object_id $course_id -privilege "admin"


set context [list [list "/courses/cc-admin/course-list"  "[_ courses.course_list]"] "[_ courses.rev_list]"]

set asm_package_id [apm_package_id_from_key assessment]

db_multirow -extend { asm_name rel } course_list get_course_info { } {
    set asm_name [db_string get_asm_name { } -default "[_ courses.not_associated]"]
    set rel [course_catalog::has_relation -course_id $course_id]
}


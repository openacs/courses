ad_page_contract {
    Displays a delete confirmation message and deletes the course
    @author          Miguel Marin (miguelmarin@viaro.net) 
    @author          Viaro Networks www.viaro.net
    @creation-date   09-02-2005
} {
    object_id:notnull
    course_key:notnull
    creation_user:notnull
}

set user_id [ad_conn user_id]
set page_title "[_ courses.confirm_delete] $course_key"
set context [list [list course-list "[_ courses.course_list]"] "[_ courses.delete_course]"]

set rev_assoc [course_catalog::check_rev_assoc -item_id $object_id]
set rev_num [lindex $rev_assoc 0]
set assoc_num [lindex $rev_assoc 1]

ad_form -name delete_course -export {course_key $course_key creation_user $creation_user } -cancel_url "course-list" -form {
    {object_id:text(hidden) 
	{ value $object_id }
    }
} -on_submit {
    course_catalog::course_delete -item_id $object_id
} -after_submit {
    ad_returnredirect "course-list"
}